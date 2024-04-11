from pathlib import Path

from libqtile import bar, layout, qtile, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

mod = "mod4"
terminal = guess_terminal(["kitty", "alacritty", "konsole"])


## keybindings

keys = [
    ## default
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key(
        [mod],
        "space",
        lazy.layout.next(),
        desc="Move window focus to other window",
    ),
    Key(
        [mod, "shift"],
        "h",
        lazy.layout.shuffle_left(),
        desc="Move window to the left",
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key(
        [mod, "shift"],
        "j",
        lazy.layout.shuffle_down(),
        desc="Move window down",
    ),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    Key(
        [mod, "control"],
        "h",
        lazy.layout.grow_left(),
        desc="Grow window to the left",
    ),
    Key(
        [mod, "control"],
        "l",
        lazy.layout.grow_right(),
        desc="Grow window to the right",
    ),
    Key(
        [mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"
    ),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    Key(
        [mod],
        "t",
        lazy.window.toggle_floating(),
        desc="Toggle floating on the focused window",
    ),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key(
        [mod],
        "r",
        lazy.spawncmd(),
        desc="Spawn a command using a prompt widget",
    ),
    # custom
    Key(
        [],
        "XF86AudioRaiseVolume",
        lazy.spawn("pactl set-sink-volume 0 +5%"),
        desc="Volume Up",
    ),
    Key(
        [],
        "XF86AudioLowerVolume",
        lazy.spawn("pactl set-sink-volume 0 -5%"),
        desc="volume down",
    ),
    Key(
        [],
        "XF86AudioMute",
        lazy.spawn("pulsemixer --toggle-mute"),
        desc="Volume Mute",
    ),
    Key(
        [],
        "XF86AudioPlay",
        lazy.spawn("playerctl play-pause"),
        desc="playerctl",
    ),
    Key(
        [], "XF86AudioPrev", lazy.spawn("playerctl previous"), desc="playerctl"
    ),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next"), desc="playerctl"),
    Key(
        [],
        "XF86MonBrightnessUp",
        lazy.spawn("brightnessctl s 10%+"),
        desc="brightness UP",
    ),
    Key(
        [],
        "XF86MonBrightnessDown",
        lazy.spawn("brightnessctl s 10%-"),
        desc="brightness Down",
    ),
    Key([mod], "e", lazy.spawn("dolphin"), desc="file manager"),
    # Key([mod], "h", lazy.spawn("roficlip"), desc='clipboard'),
    # Key([mod], "s", lazy.spawn("flameshot gui"), desc='Screenshot'),
]

# Add key bindings to switch VTs in Wayland.
# We can't check qtile.core.name in default config as it is loaded before qtile is started
# We therefore defer the check until the key binding is run by using .when(func=...)
for vt in range(1, 8):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(
                func=lambda: qtile.core.name == "wayland"
            ),
            desc=f"Switch to VT{vt}",
        )
    )


## groups

groups = [Group(f"{i+1}", label="󰏃") for i in range(9)]

for i in groups:
    keys.extend(
        [
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(
                    i.name
                ),
            ),
        ]
    )


## layouts

layouts = [
    layout.Columns(
        margin=[10, 10, 10, 10],
        border_focus="#1F1D2E",
        border_normal="#1F1D2E",
        border_width=0,
    ),
    layout.Max(
        border_focus="#1F1D2E",
        border_normal="#1F1D2E",
        margin=10,
        border_width=0,
    ),
    layout.Floating(
        border_focus="#1F1D2E",
        border_normal="#1F1D2E",
        margin=10,
        border_width=0,
    ),
    # Try more layouts by unleashing below layouts
    #  layout.Stack(num_stacks=2),
    #  layout.Bsp(),
    layout.Matrix(
        border_focus="#1F1D2E",
        border_normal="#1F1D2E",
        margin=10,
        border_width=0,
    ),
    layout.MonadTall(
        border_focus="#1F1D2E",
        border_normal="#1F1D2E",
        margin=10,
        border_width=0,
    ),
    layout.MonadWide(
        border_focus="#1F1D2E",
        border_normal="#1F1D2E",
        margin=10,
        border_width=0,
    ),
    #  layout.RatioTile(),
    layout.Tile(
        border_focus="#1F1D2E",
        border_normal="#1F1D2E",
    ),
    #  layout.TreeTab(),
    #  layout.VerticalTile(),
    #  layout.Zoomy(),
]

widget_defaults = dict(
    font="Iosevka",
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()


def search():
    qtile.cmd_spawn("rofi -show drun")


def power():
    qtile.cmd_spawn("sh -c ~/.config/rofi/scripts/power")


## bar

widgets = [
    # widget.Spacer(
    #     length=15,
    #     background="#181825",
    # ),
    widget.Image(
        filename="~/.config/qtile/Assets/launch.svg",
        margin_y=4,
        background="#181825",
        mouse_callbacks={"Button1": power},
    ),
    widget.Image(
        filename="~/.config/qtile/Assets/6.png",
    ),
    widget.GroupBox(
        fontsize=20,
        borderwidth=0,
        highlight_method="block",
        active="#b4befe",
        block_highlight_text_color="#cba6f7",
        highlight_color="#89b4fa",
        inactive="#181825",
        foreground="#89b4fa",
        background="#1e1e2e",
        this_current_screen_border="#1e1e2e",
        this_screen_border="#1e1e2e",
        other_current_screen_border="#1e1e2e",
        other_screen_border="#1e1e2e",
        urgent_border="#1e1e2e",
        rounded=True,
        disable_drag=True,
    ),
    widget.Spacer(
        length=8,
        background="#1e1e2e",
    ),
    widget.Image(
        filename="~/.config/qtile/Assets/1.png",
    ),
    widget.Image(
        filename="~/.config/qtile/Assets/layout.svg",
        background="#1e1e2e",
        margin=4,
    ),
    widget.CurrentLayout(
        background="#1e1e2e",
        foreground="#b4befe",
        fmt="{}",
    ),
    widget.Image(
        filename="~/.config/qtile/Assets/5.png",
    ),
    widget.Image(
        filename="~/.config/qtile/Assets/search.svg",
        margin_y=4,
        background="#181825",
        mouse_callbacks={"Button1": search},
    ),
    widget.TextBox(
        fmt="Search",
        background="#181825",
        foreground="#b4befe",
        mouse_callbacks={"Button1": search},
    ),
    widget.Image(
        filename="~/.config/qtile/Assets/4.png",
    ),
    widget.WindowName(
        background="#1e1e2e",
        format="{name}",
        foreground="#b4befe",
        empty_group_string="Desktop",
    ),
    widget.Image(
        filename="~/.config/qtile/Assets/3.png",
    ),
    widget.Systray(
        background="#181825",
        fontsize=2,
    ),
    widget.TextBox(
        text=" ",
        background="#181825",
    ),
    widget.Image(
        filename="~/.config/qtile/Assets/6.png",
        background="#1e1e2e",
    ),
    widget.Net(
        format=" {up:.1f}{up_suffix:<2}   {down:.1f}{down_suffix:<2} ",
        background="#1e1e2e",
        foreground="#b4befe",
    ),
    widget.Image(
        filename="~/.config/qtile/Assets/2.png",
    ),
    widget.Spacer(
        length=8,
        background="#1e1e2e",
    ),
    widget.Image(
        filename="~/.config/qtile/Assets/Misc/ram.svg",
        background="#1e1e2e",
        margin=4,
    ),
    widget.Spacer(
        length=-7,
        background="#1e1e2e",
    ),
    widget.Memory(
        background="#1e1e2e",
        format="{MemUsed:.1f}{mm}/{MemTotal:.1f}{mm}",
        foreground="#b4befe",
        update_interval=5,
        measure_mem="G",
    ),
    widget.Image(
        filename="~/.config/qtile/Assets/2.png",
    ),
]

if Path("/proc/acpi/button/lid").exists():
    widgets.extend(
        [
            widget.Spacer(
                length=8,
                background="#1e1e2e",
            ),
            widget.BatteryIcon(
                theme_path="~/.config/qtile/Assets/Battery/",
                background="#1e1e2e",
                scale=1,
            ),
            widget.Battery(
                background="#1e1e2e",
                foreground="#b4befe",
                format="{percent:2.0%}",
            ),
            widget.Image(
                filename="~/.config/qtile/Assets/2.png",
            ),
        ]
    )

widgets.extend(
    [
        widget.Spacer(
            length=8,
            background="#1e1e2e",
        ),
        widget.Volume(
            theme_path="~/.config/qtile/Assets/Volume/",
            emoji=True,
            background="#1e1e2e",
        ),
        widget.Spacer(
            length=-5,
            background="#1e1e2e",
        ),
        widget.Volume(
            font="Iosevka",
            background="#1e1e2e",
            foreground="#b4befe",
            fontsize=13,
        ),
        widget.Image(
            filename="~/.config/qtile/Assets/2.png",
            background="#1e1e2e",
        ),
        widget.Image(
            filename="~/.config/qtile/Assets/Misc/bluetooth-on.svg",
            background="#1e1e2e",
            margin_y=6,
            # margin_x=5,
        ),
        widget.Bluetooth(
            background="#1e1e2e",
            foreground="#b4befe",
        ),
        widget.Image(
            filename="~/.config/qtile/Assets/5.png",
            background="#1e1e2e",
        ),
        widget.Image(
            filename="~/.config/qtile/Assets/Misc/clock.svg",
            background="#181825",
            margin_y=6,
            # margin_x=5,
        ),
        widget.Clock(
            format="%I:%M %p",
            background="#181825",
            foreground="#b4befe",
        ),
        # widget.Spacer(
        #     length=18,
        #     background="#181825",
        # ),
    ]
)

widgets = [
    w
    for w in widgets
    if not isinstance(w, (widget.Battery, widget.BatteryIcon))
]

screens = [
    Screen(
        top=bar.Bar(
            widgets,
            30,
            border_color="#181825",
            border_width=[0, 0, 0, 0],
            # margin=[15, 60, 6, 60],
        ),
    ),
]


# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod],
        "Button3",
        lazy.window.set_size_floating(),
        start=lazy.window.get_size(),
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    border_focus="#1F1D2E",
    border_normal="#1F1D2E",
    border_width=0,
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ],
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
