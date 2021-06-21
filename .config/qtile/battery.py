import os
import subprocess


def get_battery_icon():
    script = os.path.expanduser('~/.config/qtile/misc/get_bat_state.sh')
    bat_info = subprocess.check_output(
        [script]).decode('utf-8').strip().split()
    percent = int(bat_info[3].strip('%'))
    state = bat_info[1]
    if state == 'discharging':
        if percent < 10:
            return ''
        elif percent >= 10 and percent < 20:
            return ''
        elif percent >= 20 and percent < 30:
            return ''
        elif percent >= 30 and percent < 40:
            return ''
        elif percent >= 40 and percent < 50:
            return ''
        elif percent >= 50 and percent < 60:
            return ''
        elif percent >= 60 and percent < 70:
            return ''
        elif percent >= 70 and percent < 80:
            return ''
        elif percent >= 80 and percent < 90:
            return ''
        elif percent >= 90 and percent < 100:
            return ''
        elif percent == 100:
            return ''
        else:
            return ''
    elif state == "charging":
        if percent < 10:
            return ''  # need icon
        elif percent >= 10 and percent < 20:
            return ''  # need icon
        elif percent >= 20 and percent < 30:
            return ''
        elif percent >= 30 and percent < 40:
            return ''
        elif percent >= 40 and percent < 50:
            return ''
        elif percent >= 50 and percent < 60:
            return ''  # need icon
        elif percent >= 60 and percent < 70:
            return ''
        elif percent >= 70 and percent < 80:
            return ''  # need icon
        elif percent >= 80 and percent < 90:
            return ''
        elif percent >= 90 and percent < 100:
            return ''
        elif percent == 100:
            return ''
        else:
            return ''
    elif state == "fully-charged":
        return ''
    else:
        return ''
