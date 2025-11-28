#!/usr/bin/env python3
import signal
import sys

import dbus
from dbus.mainloop.glib import DBusGMainLoop
from gi.repository import GLib


def handle_settings_changed(namespace, key, value):
    if namespace == "org.freedesktop.appearance" and key == "color-scheme":
        theme_value = value if isinstance(value, int) else value
        print("DARK" if theme_value == 1 else "LIGHT", flush=True)


def get_initial_theme(settings_interface):
    try:
        result = settings_interface.Read("org.freedesktop.appearance", "color-scheme")
        if result:
            value = result[0]
            theme_value = value if isinstance(value, int) else value
            print("DARK" if theme_value == 1 else "LIGHT", flush=True)
    except (dbus.DBusException, KeyError, IndexError):
        print("DARK", flush=True)


def main():
    DBusGMainLoop(set_as_default=True)
    bus = dbus.SessionBus()

    try:
        settings = bus.get_object(
            "org.freedesktop.portal.Desktop", "/org/freedesktop/portal/desktop"
        )
        settings_interface = dbus.Interface(settings, "org.freedesktop.portal.Settings")

        get_initial_theme(settings_interface)

        settings.connect_to_signal(
            "SettingChanged",
            handle_settings_changed,
            dbus_interface="org.freedesktop.portal.Settings",
        )

        loop = GLib.MainLoop()

        def signal_handler(sig, frame):
            loop.quit()
            sys.exit(0)

        signal.signal(signal.SIGINT, signal_handler)
        signal.signal(signal.SIGTERM, signal_handler)

        loop.run()

    except dbus.DBusException as e:
        print(f"D-Bus error: {e}", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    main()
