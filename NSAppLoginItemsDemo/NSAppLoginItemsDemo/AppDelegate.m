//
//  AppDelegate.m
//  NSAppLoginItemsDemo
//
//  Created by Kevin Wojniak on 10/20/12.
//  Copyright (c) 2012 Kevin Wojniak. All rights reserved.
//

#import "AppDelegate.h"
#import "NSApplication+LoginItems.h"

@implementation AppDelegate

- (IBAction)add:(id)sender
{
    [NSApp addToLoginItems];
}

- (IBAction)remove:(id)sender
{
    [NSApp removeFromLoginItems];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    return YES;
}

@end
