NSAppLoginItems
===============

This is an NSApplication extension that allows easy adding or removing of the app to and from the login items. Works with ARC and manual reference counting. Not compatible with the sandbox.

```objc
[NSApp addToLoginItems];
[NSApp removeFromLoginItems];
```