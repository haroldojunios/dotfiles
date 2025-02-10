import datetime
import json
import subprocess
from collections import defaultdict

import humanize
import psutil
from kitty.boss import get_boss
from kitty.fast_data_types import Screen, add_timer, get_options
from kitty.tab_bar import (
    DrawData,
    ExtraData,
    Formatter,
    TabBarData,
    as_rgb,
    draw_attributed_string,
    draw_tab_with_powerline,
)
from kitty.utils import color_as_int

opts = get_options()
accent_color = as_rgb(color_as_int(opts.active_tab_background))
timer_id = None


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    global timer_id

    if timer_id is None:
        timer_id = add_timer(_redraw_tab_bar, 1, True)
    draw_tab_with_powerline(
        draw_data,
        screen,
        tab,
        before,
        max_title_length,
        index,
        is_last,
        extra_data,
    )
    if is_last:
        draw_right_status(draw_data, screen)
    return screen.cursor.x


def draw_right_status(draw_data: DrawData, screen: Screen) -> None:
    # The tabs may have left some formats enabled. Disable them now.
    draw_attributed_string(Formatter.reset, screen)
    cells = create_cells()
    # Drop cells that wont fit
    while True:
        if not cells:
            return
        padding = (
            screen.columns - screen.cursor.x - sum(len(c) + 3 for c in cells)
        )
        if padding >= 0:
            break
        cells = cells[1:]

    if padding:
        screen.draw(" " * padding)

    tab_bg = as_rgb(int(draw_data.inactive_bg))
    tab_fg = as_rgb(int(draw_data.inactive_fg))
    default_bg = as_rgb(int(draw_data.default_bg))
    for cell in cells:
        # Draw the separator
        if cell == cells[0]:
            screen.cursor.fg = tab_bg
            screen.draw("")
        else:
            screen.cursor.fg = default_bg
            screen.cursor.bg = tab_bg
            screen.draw("")
        screen.cursor.bg = tab_bg
        screen.cursor.fg = accent_color
        screen.draw(f" {cell[0]}")
        screen.cursor.fg = tab_fg
        screen.draw(f"{cell[1:]} ")


def create_cells() -> list[str]:
    mem_used, mem_total, swap_used, swap_total = get_memory()
    mem_used_str = natural_size(mem_used)
    mem_total_str = natural_size(mem_total)
    swap_used_str = natural_size(swap_used)
    swap_total_str = natural_size(swap_total)
    # cpu_temp = get_cpu_temp()
    now = datetime.datetime.now()

    cells = [
        f"󰋊 {round(psutil.disk_usage('/').percent)}%",
        f"󰻠 {round(psutil.cpu_percent(0.01))}%",
    ]
    mem_str = f" {mem_used_str}/{mem_total_str}"
    if swap_total and swap_used / swap_total > 0.1:
        mem_str += f" | {swap_used_str}/{swap_total_str}"
    cells.append(mem_str)
    # if cpu_temp is not None:
    #     cells.append(f" {round(cpu_temp)}°C")
    cells.append(f"󰸘 {now.strftime('%d/%m %H:%M:%S')}")
    return cells


def natural_size(num):
    ns = humanize.naturalsize(num, binary=True)
    ns = ns.replace(" ", "")
    ns = ns.replace("i", "")
    return ns


def get_memory():
    mem_used = psutil.virtual_memory().used
    mem_total = psutil.virtual_memory().total
    swap_used = psutil.swap_memory().used
    swap_total = psutil.swap_memory().total
    return mem_used, mem_total, swap_used, swap_total


def get_cpu_temp():
    sensor_temps = psutil.sensors_temperatures()
    coretemp = sensor_temps.get("coretemp", sensor_temps.get("it8655"))
    if coretemp is not None:
        for t in coretemp:
            if "id 0" in t.label:
                temp = t.current
                break
        else:
            if len(coretemp):
                temp = coretemp[0].current
            else:
                temp = None
    return temp


STATE = defaultdict(lambda: "", {"Paused": "", "Playing": ""})


def currently_playing():
    # TODO: Work out how to add python libraries so that I can query dbus directly
    # For now, implemented in a separate python project: dbus-player-status
    status = " "
    data = {}
    try:
        data = json.loads(subprocess.getoutput("dbus-player-status"))
    except ValueError:
        pass
    if data:
        if "state" in data:
            status = f"{status} {STATE[data['state']]}"
        if "title" in data:
            status = f"{status} {data['title']}"
        if "artist" in data:
            status = f"{status} - {data['artist']}"
    else:
        status = ""
    return status


def _redraw_tab_bar(timer_id):
    for tm in get_boss().all_tab_managers:
        tm.mark_tab_bar_dirty()
