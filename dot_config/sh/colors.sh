# foreground
FMT_BLACK=$(printf '\033[30m')  # black
FMT_RED=$(printf '\033[31m')    # red
FMT_GREEN=$(printf '\033[32m')  # green
FMT_YELLOW=$(printf '\033[33m') # yellow
FMT_BLUE=$(printf '\033[34m')   # blue
FMT_PURPLE=$(printf '\033[35m') # purple
FMT_CYAN=$(printf '\033[36m')   # cyan
FMT_WHITE=$(printf '\033[37m')  # white

# background
FMT_BLACK_BG=$(printf '\033[40m')  # black
FMT_RED_BG=$(printf '\033[41m')    # red
FMT_GREEN_BG=$(printf '\033[42m')  # green
FMT_YELLOW_BG=$(printf '\033[43m') # yellow
FMT_BLUE_BG=$(printf '\033[44m')   # blue
FMT_PURPLE_BG=$(printf '\033[45m') # purple
FMT_CYAN_BG=$(printf '\033[46m')   # cyan
FMT_WHITE_BG=$(printf '\033[47m')  # white

# high intensity background
FMT_BLACK_HIBG='\033[0;100m'  # black
FMT_RED_HIBG='\033[0;101m'    # red
FMT_GREEN_HIBG='\033[0;102m'  # green
FMT_YELLOW_HIBG='\033[0;103m' # yellow
FMT_BLUE_HIBG='\033[0;104m'   # blue
FMT_PURPLE_HIBG='\033[0;105m' # purple
FMT_CYAN_HIBG='\033[0;106m'   # cyan
FMT_WHITE_HIBG='\033[0;107m'  # white

# other
FMT_RESET=$(printf '\033[0m')      # reset
FMT_BOLD=$(printf '\033[1m')       # bold
FMT_FAINT=$(printf '\033[2m')      # faint
FMT_IT=$(printf '\033[3m')         # italic
FMT_UNDERLINE=$(printf '\033[4m')  # underline
FMT_BLINK=$(printf '\033[5m')      # blink
FMT_BLINK_FAST=$(printf '\033[6m') # blink fast
FMT_REV=$(printf '\033[7m')        # reverse
FMT_INVISIBLE=$(printf '\033[8m')  # invisible
FMT_STRIKE=$(printf '\033[9m')     # strike-through
