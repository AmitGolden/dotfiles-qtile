#    ____  __  _ __
#   / __ \/ /_(_) /__
#  / / / / __/ / / _ \
# / /_/ / /_/ / /  __/
# \___\_\__/_/_/\___/
#
# Material ColorScheme

import psutil
from typing import List  # noqa: F401

from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile import qtile

import os
import subprocess
from libqtile import hook

from battery import get_battery_icon

mod = "mod4"
alt = "mod1"
terminal = "kitty"
browser = "brave"
home = os.path.expanduser("~")
qtileDir = f"{home}/.config/qtile"

powermenu = "rofi -show p -modi p:rofi-power-menu -width 20 -lines 6"
toggle_caffeine_path = f"{qtileDir}/caffeine/toggle_caffeine.sh"


@lazy.function
def window_to_prev_group(qtile):
    previous_group_name = qtile.current_group.get_previous_group().name
    qtile.current_window.togroup(previous_group_name)


@lazy.function
def window_to_next_group(qtile):
    next_group_name = qtile.current_group.get_next_group().name
    qtile.current_window.togroup(next_group_name)


keys = [
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(),
        desc="Move window focus to other window"),
    Key([mod, "shift"], "space", lazy.layout.flip()),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key(
        [mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),


    # # Grow windows. If current window is on the edge of screen and direction
    # # will be to screen edge - window would shrink.
    Key(
        [mod, "control"],
        "h",
        lazy.layout.grow_left(),
        # MonadTall
        lazy.layout.shrink_main(),
        desc="Grow window to the left.",
    ),
    Key(
        [mod, "control"],
        "l",
        lazy.layout.grow_right(),
        # MonadTall
        lazy.layout.grow_main(),
        desc="Grow window to the right.",
    ),
    Key(
        [mod, "control"],
        "j",
        lazy.layout.grow_down(),
        # MonadTall
        lazy.layout.shrink(),
        desc="Grow window down.",
    ),
    Key(
        [mod, "control"],
        "k",
        lazy.layout.grow_up(),
        # MonadTall
        lazy.layout.grow(),
        desc="Grow window up.",
    ),
    Key(
        [mod],
        "n",
        lazy.layout.normalize(),
        # MonadTall
        lazy.layout.reset(),
        desc="Reset all window sizes.",
    ),

    # Groups
    Key([mod], "i", lazy.screen.prev_group()),
    Key([mod], "o", lazy.screen.next_group()),
    Key([mod, "shift"], "i", window_to_prev_group, lazy.screen.prev_group()),
    Key([mod, "shift"], "o", window_to_next_group, lazy.screen.next_group()),

    Key([mod], "f", lazy.window.toggle_floating(), desc="Toggle floating"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "grave", lazy.prev_layout(),
        desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window."),
    Key([mod, "shift"], "q", lazy.spawn("xkill"), desc="Force kill window."),
    Key([mod, "control"], "r", lazy.restart(), desc="Restart Qtile."),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile."),


    # Rofi scripts
    Key([mod], "a", lazy.spawn("rofi -show drun"),
        desc="Spawn a command using a prompt widget."),
    Key([alt], "Tab", lazy.spawn("rofi -show window -kb-accept-entry '!Alt-Tab,!Alt+Alt_L' -kb-row-down 'Alt+Tab'"),
        desc="Switch between windows"),
    Key([mod], "v", lazy.spawn("bwmenu"),
        desc="Launch password manager"),
    Key([mod], "p", lazy.spawn(powermenu),
        desc="Launch power menu"),

    # System
    # Key(
    #     [mod, "shift"],
    #     "p",
    #     lazy.spawn("poweroff"),
    #     desc="Powers off the\
    #     system.",
    # ),
    # Key([mod, "shift"], "r", lazy.spawn(
    #     "reboot"), desc="Reboots the system"),
    Key([], "F9", lazy.spawn(
        f"{qtileDir}/misc/lock.sh"), desc="Locks the system"),
    Key([], "Print", lazy.spawn("flameshot gui"),
            desc="Take screenshot"),
    Key(["shift"], "Print", lazy.spawn(f"flameshot full -p {home}/Pictures"),
        desc="Take full screenshot"),
    Key([mod], "r", lazy.spawn(
        f"{qtileDir}/misc/toggle_redshift.sh"), desc="Toggle Redshift"),
    Key([mod, "shift"], "c", lazy.spawn(
        toggle_caffeine_path), desc="Toggle Caffeine"),

    # Brightness
    Key([], "XF86MonBrightnessUp", lazy.spawn(
        f"{qtileDir}/controllers/brightnessControl.sh up")),
    Key([], "XF86MonBrightnessDown", lazy.spawn(
        f"{qtileDir}/controllers/brightnessControl.sh down")),
    Key(["shift"], "XF86MonBrightnessUp", lazy.spawn(
        f"{qtileDir}/controllers/brightnessControl.sh max")),
    Key(["shift"], "XF86MonBrightnessDown", lazy.spawn(
        f"{qtileDir}/controllers/brightnessControl.sh blank")),

    # Volume
    Key([], "XF86AudioMute", lazy.spawn(
        f"{qtileDir}/controllers/volumeControl.sh mute")),
    Key([], "XF86AudioLowerVolume", lazy.spawn(
        f"{qtileDir}/controllers/volumeControl.sh down")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn(
        f"{qtileDir}/controllers/volumeControl.sh up")),

    # Microphone
    Key([], "XF86AudioMicMute", lazy.spawn(
        f"{qtileDir}/controllers/micControl.sh mute")),
    Key(["shift"], "XF86AudioLowerVolume", lazy.spawn(
        f"{qtileDir}/controllers/micControl.sh down")),
    Key(["shift"], "XF86AudioRaiseVolume", lazy.spawn(
        f"{qtileDir}/controllers/micControl.sh up")),

    # Programs
    Key([mod], "b", lazy.spawn(browser), desc="Opens the browser."),
    Key([mod], "m", lazy.spawn(f"{qtileDir}/misc/spotify.sh"),
        lazy.group["Music"].toscreen(toggle=False), desc="Opens Spotify."),
    Key([mod], "t", lazy.spawn(terminal), desc="Launch terminal."),
    Key([mod], "e", lazy.spawn("nemo"), desc="Launch file manager."),
    Key([mod, "shift"], "e", lazy.spawn(f"kitty {qtileDir}/misc/ranger.sh"),
        desc="Launch terminal file manager."),
    Key([mod], "c", lazy.spawn("code"),
        lazy.group["Programming"].toscreen(toggle=False), desc="Launch VSCode."),
    Key([mod], "w", lazy.spawn(f"{browser} https://web.whatsapp.com/"),
        desc="Open WhatsApp web"),

    # Music
    Key(["control", alt], 'semicolon', lazy.spawn("playerctl play-pause")
        ),
    Key(["control", alt], 'bracketright',
        lazy.spawn("playerctl next")),
    Key(["control", alt], 'bracketleft',
        lazy.spawn("playerctl previous")),
]


def show_keys():
    key_help = ""
    for k in keys:
        mods = ""

        for m in k.modifiers:
            if m == "mod4":
                mods += "Super + "
            else:
                mods += m.capitalize() + " + "

        if len(k.key) > 1:
            mods += k.key.capitalize()
        else:
            mods += k.key

        key_help += "{:<30} {}".format(mods, k.desc + "\n")

    return key_help


keys.extend(
    [
        Key(
            [mod],
            "x",
            lazy.spawn(
                "sh -c 'echo \""
                + show_keys()
                + f'" | rofi -dmenu -i -p "?"\''
            ),
            desc="Print keyboard bindings",
        ),
    ]
)


# Groups
# From: https://github.com/AugustoNicola/dotfiles/blob/main/qtile/
if __name__ in ['config', '__main__']:
    group_props = [
        ('Music', {'label': '', 'matches': [Match(wm_class=['spotify'])]}),
        ('Web', {'label': '', 'matches': [Match(wm_class=['brave'])]}),
        ('Programming', {'label': '', 'matches': [Match(wm_class=['code'])]}),
        ('Misc', {'label': ''}),
        ('Misc2', {'label': ''})
    ]

    groups = [Group(name, init=True, persist=True, **kwargs) for name, kwargs
              in group_props]

    for i, (name, kwargs) in enumerate(group_props, 1):
        keys.extend([
            # Switch to group
            Key([mod], str(i), lazy.group[name].toscreen(toggle=False),
                desc='Switch to group {}'.format(name)),

            # Move window to group
            Key([mod, 'shift'], str(i), lazy.window.togroup(name,\
                switch_group=True),
                desc='Switch to & move focused window to group {}.'.\
                format(name)),
        ])


def get_keyboard_layout():
    return subprocess.check_output(['xkblayout-state', 'print', '"%s"']).decode('utf-8').strip()[1:3]


def redshift_status():
    return subprocess.check_output([f"{qtileDir}/misc/redshift_status.sh"]).decode('utf-8').strip()


def get_caffeine_state():
    return subprocess.check_output([f"{qtileDir}/caffeine/is_caffeine_active.sh"]).decode('utf-8').strip()


def toggle_caffeine():
    qtile.cmd_spawn(toggle_caffeine_path)


colors = {
    "background": "#212121",
    "dark-grey": "#1A1A1A",
    "grey": "#4A4A4A",
    "light-grey": "#A1A1A1",
    "white": '#ffffff',
    "black": '#000000',
    "red": '#f07178',
    "orange": '#F78C6C',
    "yellow": '#FFCB6B',
    "green": '#C3E88D',
    "cyan": '#89DDFF',
    "blue": '#82AAFF',
    "paleblue": '#B2CCD6',
    "purple": '#C792EA',
    "brown": '#916b53',
    "pink": '#ff9cac',
    "violet": '#bb80b3',
    "turquoise": "#80CBC4"
}

widget_defaults = dict(
    font="FiraCode Nerd Font Medium",
    fontsize=14,
    padding=3,
)
extension_defaults = widget_defaults.copy()

layout_defaults = dict(border_width=3,
                       single_border_width=0,
                       margin=15,
                       border_focus=colors["white"],
                       border_normal=colors["background"],
                       border_focus_stack=colors["yellow"],
                       border_normal_stack=colors["background"])

# Layouts
layouts = [
    layout.MonadTall(
        name="MonadTall", **layout_defaults
    ),
    layout.Max(name="Max"),
    layout.Columns(name="Columns", **layout_defaults,
                   wrap_focus_rows=False, wrap_focus_columns=False),
    layout.MonadWide(
        name="MonadWide", **layout_defaults
    ),
]


screens = [
    Screen(
        # Bar
        top=bar.Bar(
            [
                # GroupBox
                widget.Spacer(10),
                widget.GroupBox(
                    fontsize=20,
                    padding=6,
                    block_highlight_text_color=colors["yellow"],
                    active=colors["white"],
                    inactive=colors["grey"],
                    borderwidth=0,
                ),
                widget.Spacer(10),

                # Layout
                widget.TextBox(
                    text="", padding=6, fontsize=16, foreground=colors["light-grey"]
                ),
                widget.CurrentLayout(
                    foreground=colors["light-grey"], fontsize=14),
                widget.Spacer(10),

                # WindowName
                # widget.WindowName(
                #     format="|{state} {name}", max_chars=80, foreground=colors["white"]
                # ),
                # widget.TextBox(text="|", fontsize=16,
                #                foreground=colors["white"]),
                widget.TaskList(foreground=colors["white"], icon_size=20, padding=5,
                                font="FiraCode Nerd Font", fontsize=14, borderwidth=0,
                                markup_focused='<span weight="bold">{}</span>'),
                # Systray
                widget.Systray(icon_size=16, padding=8),
                widget.Spacer(5),

                # Caffeine
                widget.GenPollText(
                    foreground=colors["white"], fontsize=18, padding=5, func=get_caffeine_state, update_interval=1, mouse_callbacks={'Button1': toggle_caffeine}),
                widget.Spacer(7),

                # Updates
                widget.CheckUpdates(
                    padding=2,
                    update_interval=1800,
                    distro="Arch_checkupdates",
                    display_format=' {updates}',
                    foreground=colors["purple"],
                    custom_command=f"{qtileDir}/misc/updates-arch-combined.sh",
                    colour_have_updates=colors["purple"], fontsize=16),
                widget.Spacer(3),

                # Keyboard Layout
                widget.TextBox(
                    text="", padding=8, foreground=colors["orange"], fontsize=18
                ),
                widget.GenPollText(
                    foreground=colors["orange"], fontsize=16, func=get_keyboard_layout, update_interval=0.5),
                widget.Spacer(3),

                # Battery
                widget.GenPollText(
                    foreground=colors["white"], fontsize=18, func=get_battery_icon, update_interval=3, padding=5),
                widget.Battery(
                    foreground=colors["white"],
                    low_foreground=colors["red"],
                    format="{percent:2.0%}",
                    low_percentage=0.15,
                    notify_below=0.15,
                    update_interval=3,
                    show_short_text=False
                ),
                widget.Spacer(3),

                # Backlight
                widget.TextBox(
                    text="", padding=8, foreground=colors["yellow"], fontsize=18
                ),
                widget.Backlight(
                    foreground=colors["yellow"],
                    backlight_name="intel_backlight",
                ),
                widget.Spacer(3),

                # Volume
                widget.TextBox(
                    text="墳", foreground=colors["green"], fontsize=17,
                    mouse_callbacks={
                        'Button1': lambda: qtile.cmd_spawn("pavucontrol")},
                    volume_app="pavucontrol"),
                widget.Volume(foreground=colors["green"],
                              mouse_callbacks={'Button1': lambda: qtile.cmd_spawn("pavucontrol")},),
                widget.Spacer(3),

                # Network
                # widget.TextBox(
                #     text="直", foreground=colors["cyan"], fontsize=17,  padding=8),
                # widget.Wlan(foreground=colors["cyan"],
                #             format="{essid} {percent:2.0%}",
                #             disconnected_message="--", update_interval=10),
                # widget.Spacer(3),

                # Time
                widget.TextBox(
                    text="", fontsize=18, padding=8, foreground=colors["blue"]
                ),
                widget.Clock(
                    foreground=colors["blue"], format="%-H:%M, %-d %b"),
                widget.Spacer(8),
                widget.TextBox(text="襤", fontsize=24, padding=4,
                               foreground=colors["red"], mouse_callbacks={'Button1': lambda: qtile.cmd_spawn(powermenu)}),
                widget.Spacer(10),
            ],
            32,
            background=colors["background"],
            opacity=0.8
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
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = True
bring_front_click = True
cursor_warp = False
floating_layout = layout.Floating(
    auto_float_types=["notification",
                      "toolbar",
                      "splash",
                      "dialog", ],
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),
        Match(wm_class="pavucontrol"),  # ssh-askpass
        Match(wm_class="zoom"),
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ],
    # Configuration
    border_width=0,
)
auto_fullscreen = True
focus_on_window_activation = "smart"
auto_minimize = False


# Set the wallpaper and start the compositor.
@hook.subscribe.startup_once
def autostart():
    autostart_script = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.call([autostart_script])


# Disable rounded corners when using Max layout.
@hook.subscribe.layout_change
def layout_change(currlayout, group):
    is_max = isinstance(currlayout, layout.Max)
    wids = map(lambda w: w.wid, group.windows)

    for id in wids:
        if is_max:
            qtile.cmd_spawn(
                f"xprop -id {id} -f _PICOM_ROUNDED 32c -set _PICOM_ROUNDED 1")
        else:
            qtile.cmd_spawn(
                f"xprop -id {id} -remove _PICOM_ROUNDED")


@hook.subscribe.group_window_add
def new_window(group, window):
    if group.current_layout == 1:
        qtile.cmd_spawn(
            f"xprop -id {window.wid} -f _PICOM_ROUNDED 32c -set _PICOM_ROUNDED 1")


# Window Swallowing
@hook.subscribe.client_new
def _swallow(window):
    pid = window.window.get_net_wm_pid()
    ppid = psutil.Process(pid).ppid()
    cpids = {c.window.get_net_wm_pid(): wid for wid,
             c in window.qtile.windows_map.items()}
    for _ in range(5):
        if not ppid:
            return
        if ppid in cpids:
            parent = window.qtile.windows_map.get(cpids[ppid])
            parent.minimized = True
            window.parent = parent
            return
        ppid = psutil.Process(ppid).ppid()


@hook.subscribe.client_killed
def _unswallow(window):
    if hasattr(window, 'parent'):
        window.parent.minimized = False


# Java UI ToolKits
wmname = "LG3D"
