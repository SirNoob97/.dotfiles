from __future__ import annotations

import os
# import sys
import subprocess

from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile import hook
from libqtile.utils import guess_terminal
# from libqtile.widget.battery import Battery, BatteryState


def exec_autostart():
    script_path = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.Popen(script_path)


@hook.subscribe.restart
def restart():
    exec_autostart()


@hook.subscribe.startup_once
def autostart():
    exec_autostart()


def find_custom_module(module):
    return os.path.expanduser('~/.config/qtile/modules/' + module)


def custom_widget(script_name, args):

    def closure():
        script_path = find_custom_module(script_name)
        output = subprocess.check_output(script_path + args,
                                         shell=True).decode()
        return output.rstrip()

    return closure


mod = "mod4"
terminal = guess_terminal()

keys = [
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod],
        "space",
        lazy.layout.next(),
        desc="Move window focus to other window"),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"],
        "h",
        lazy.layout.shuffle_left(),
        desc="Move window to the left"),
    Key([mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right"),
    Key([mod, "shift"],
        "j",
        lazy.layout.shuffle_down(),
        desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"],
        "h",
        lazy.layout.grow_left(),
        desc="Grow window to the left"),
    Key([mod, "control"],
        "l",
        lazy.layout.grow_right(),
        desc="Grow window to the right"),
    Key([mod, "control"],
        "j",
        lazy.layout.grow_down(),
        desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "shift"], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod, "control"],
        "v",
        lazy.validate_config(),
        desc="Validate Qtile config"),
    Key([mod, "shift"],
        "f",
        lazy.window.toggle_floating(),
        desc="Toggle floating windows"),
    #Key([], "Print", lazy.spawn("gnome-screenshot -i"), desc="Launch gnome-screenshot"),
    Key([],
        "Print",
        lazy.spawn("xfce4-screenshooter"),
        desc="Launch xfce4-screenshooter"),
    Key([],
        "XF86AudioRaiseVolume",
        lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +10%"),
        desc="Increase volume"),
    Key([],
        "XF86AudioLowerVolume",
        lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -10%"),
        desc="Decrease volume"),
    Key([],
        "XF86AudioMute",
        lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle"),
        desc="Mute Audio"),
    Key([],
        "XF86AudioMicMute",
        lazy.spawn("pactl set-source-mute @DEFAULT_SOURCE@ toggle"),
        desc="Mute Audio"),
    Key([],
        "XF86MonBrightnessUp",
        lazy.spawn("brightnessctl --quiet set +10%"),
        desc="Increase Backlight"),
    Key([],
        "XF86MonBrightnessDown",
        lazy.spawn("brightnessctl --quiet set 10%-"),
        desc="Decrease Backlight"),

    #  Key([mod], "r", lazy.spawn("rofi -show run"), desc="Launch Rofi"),
    Key([mod], "v", lazy.spawn("code"), desc="Launch VS Code"),
    Key([mod], "b", lazy.spawn("firefox"), desc="Launch Firefox"),
    Key([mod], "e", lazy.spawn("emacsclient -c -a emacs"),
        desc="Launch Emacs"),
]

groups = [
    Group("1",
          matches=[
              Match(wm_class="emacs"),
              Match(wm_class="Emacs"),
              Match(wm_class="code"),
              Match(wm_class="Code")
          ],
          layout="monadtall"),
    Group("2",
          matches=[
              Match(wm_class="Navigator"),
              Match(wm_class="firefox"),
              Match(wm_class="google-chrome"),
              Match(wm_class="Google-chrome"),
          ],
          layout="stack"),
    Group("3", matches=[Match(wm_class="Alacritty")], layout="columns"),
    Group("4", layout="monadtall"),
    Group("5", layout="monadtall"),
    Group("6", layout="monadtall"),
]
for i in groups:
    keys.extend([
        Key([mod],
            i.name,
            lazy.group[i.name].toscreen(),
            desc="Switch to group {}".format(i.name)),
        Key([mod, "shift"],
            i.name,
            lazy.window.togroup(i.name, switch_group=True),
            desc="Switch & move focused window to group {}".format(i.name)),
        # Or, use below if you prefer not to switch to that group.
        # # mod1 + shift + letter of group = move focused window to group
        # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
        #     desc="move focused window to group {}".format(i.name)),
    ])

layout_theme = {
    "border_normal": "#222222",
    "border_focus": "#ff4400",
    "border_width": 3,
    "margin": 5,
}

layouts = [
    layout.Stack(**layout_theme, num_stacks=1),
    layout.MonadTall(**layout_theme, single_border_width=3, single_margin=5),
    layout.Columns(
        **layout_theme,
        border_normal_stack="#222222",
        border_focus_stack="#ff4400",
        border_on_single=3,
        margin_on_single=5,
    ),
]

widget_defaults = dict(
    font='JetBrainsMono Nerd Font Mono',
    fontsize=16,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayout(),
                widget.Sep(),
                widget.GroupBox(),
                widget.Spacer(),
                widget.Clock(format='%Y-%m-%d %H:%M'),
                widget.Spacer(),
                widget.GenPollText(
                    update_interval=1,
                    func=custom_widget(
                        'volume.bash',
                        ' --icons-volume "奔 ,墳 " --icon-muted "婢 " output')),
                widget.Sep(),
                #  widget.Backlight(
                #      backlight_name=os.listdir('/sys/class/backlight')[0],
                #      step=1,
                #      update_interval=None,
                #      format="",
                #      change_command=None,
                #  ),
                #  widget.Sep(),
                widget.GenPollText(update_interval=1,
                                   func=custom_widget('battery.sh', '')),
                #  widget.Sep(),
                #  widget.GenPollText(
                #      update_interval = 20,
                #      func=custom_widget('network.sh', '')
                #  ),
                widget.Sep(),
                widget.QuickExit(
                    default_text="  ",
                    countdown_format="[{}]",
                ),
            ],
            24,
        ), ),
]

# Drag floating layouts.
mouse = [
    Drag([mod],
         "Button1",
         lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod],
         "Button3",
         lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(wm_type='notification'),
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
])
auto_fullscreen = True
focus_on_window_activation = "smart"
follow_mouse_focus = False
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
