#!/usr/bin/env python3

import objc
from AppKit import NSApp, NSAppearance, NSApplication
from Foundation import NSDistributedNotificationCenter, NSObject
from PyObjCTools import AppHelper


def get_current_theme():
    app = NSApp()
    if app is None:
        app = NSApplication.sharedApplication()

    appearance = (
        app.effectiveAppearance() if hasattr(app, "effectiveAppearance") else None
    )
    if appearance is None:
        appearance = NSAppearance.currentAppearance()

    name = appearance.name() if appearance is not None else None
    if not name or "Dark" in str(name):
        return "DARK"
    return "LIGHT"


class ThemeObserver(NSObject):
    def init(self):
        self = objc.super(ThemeObserver, self).init()
        if self is None:
            return None

        self.app = NSApplication.sharedApplication()
        self.currentTheme = get_current_theme()
        print(self.currentTheme, flush=True)

        center = NSDistributedNotificationCenter.defaultCenter()
        center.addObserver_selector_name_object_(
            self,
            objc.selector(self.themeChanged_, signature=b"v@:@"),
            "AppleInterfaceThemeChangedNotification",
            None,
        )
        return self

    def themeChanged_(self, notification):
        new_theme = get_current_theme()
        if new_theme != getattr(self, "currentTheme", None):
            self.currentTheme = new_theme
            print(new_theme, flush=True)


if __name__ == "__main__":
    observer = ThemeObserver.alloc().init()
    AppHelper.runEventLoop()
