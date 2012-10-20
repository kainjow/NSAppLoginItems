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

- (void)updateCheckbox
{
    [self.checkbox setState:[NSApp isInLoginItems] ? NSOnState : NSOffState];
}

- (void)awakeFromNib
{
    [self updateCheckbox];
}

- (IBAction)add:(id)sender
{
    [NSApp addToLoginItems];
    [self updateCheckbox];
}

- (IBAction)remove:(id)sender
{
    [NSApp removeFromLoginItems];
    [self updateCheckbox];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    return YES;
}

@end
