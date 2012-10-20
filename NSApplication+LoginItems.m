//
// NSApplication+LoginItems.m
// Created by Kevin Wojniak on 9/2/09.
//
// Copyright (c) 2009-2012 Kevin Wojniak
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of this
// software and associated documentation files (the "Software"), to deal in the Software
// without restriction, including without limitation the rights to use, copy, modify,
// merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to the following
// conditions:
//
// The above copyright notice and this permission notice shall be included in all copies
// or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
// INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
// PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
// HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
// CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
// THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "NSApplication+LoginItems.h"

@implementation NSApplication (KainjowLoginItems)

static BOOL isAppInstalled(CFStringRef appName, LSSharedFileListRef list, LSSharedFileListItemRef *outItem)
{
    CFArrayRef loginItems = LSSharedFileListCopySnapshot(list, NULL);
    if (loginItems == NULL) {
        return NO;
    }
    BOOL ret = NO;
    for (CFIndex i=0; i<CFArrayGetCount(loginItems); i++) {
        LSSharedFileListItemRef listItem = (LSSharedFileListItemRef)CFArrayGetValueAtIndex(loginItems, i);
        CFStringRef displayName = LSSharedFileListItemCopyDisplayName(listItem);
        if (displayName != NULL) {
            if (CFStringCompare(displayName, appName, kCFCompareCaseInsensitive) == kCFCompareEqualTo) {
                ret = YES;
                if (outItem != NULL) {
                    *outItem = listItem;
                    CFRetain(*outItem);
                }
            }
            CFRelease(displayName);
            if (ret) {
                break;
            }
        }
    }
    CFRelease(loginItems);
    return ret;
}

- (void)addToLoginItems
{
    LSSharedFileListRef list = LSSharedFileListCreate(NULL, kLSSharedFileListSessionLoginItems, NULL);
    if (list != NULL) {
        CFStringRef appName = (CFStringRef)[[NSProcessInfo processInfo] processName];
        if (isAppInstalled(appName, list, NULL) == NO) {
            CFURLRef url = (CFURLRef)[[NSBundle mainBundle] bundleURL];
            LSSharedFileListItemRef newItem = LSSharedFileListInsertItemURL(list, kLSSharedFileListItemLast, NULL, NULL, url, NULL, NULL);
            if (newItem != NULL) {
                CFRelease(newItem);
            }
        }
        CFRelease(list);
    }
}

- (void)removeFromLoginItems
{
    LSSharedFileListRef list = LSSharedFileListCreate(NULL, kLSSharedFileListSessionLoginItems, NULL);
    if (list != NULL) {
        CFStringRef appName = (CFStringRef)[[NSProcessInfo processInfo] processName];
        LSSharedFileListItemRef item = NULL;
        if ((isAppInstalled(appName, list, &item) == YES) && (item != NULL)) {
            LSSharedFileListItemRemove(list, item);
            CFRelease(item);
        }
        CFRelease(list);
    }
}

@end
