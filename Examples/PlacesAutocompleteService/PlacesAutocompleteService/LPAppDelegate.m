//
//  LPAppDelegate.m
//  PlacesAutocompleteService
//
//  Created by Luka Penger on 27/10/13.
//  Copyright (c) 2013 Luka Penger. All rights reserved.
//

#import "LPAppDelegate.h"

@implementation LPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    LPMainViewController *mainViewController = [[LPMainViewController alloc] initWithNibName:@"LPMainViewController" bundle:nil];
    self.window.rootViewController = mainViewController;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
