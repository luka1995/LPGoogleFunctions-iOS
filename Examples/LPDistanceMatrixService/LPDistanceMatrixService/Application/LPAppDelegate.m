//
//  LPAppDelegate.m
//  LPDistanceMatrixService
//
//  Created by Luka Penger on 14/07/14.
//  Copyright (c) 2014 Luka Penger. All rights reserved.
//

#import "LPAppDelegate.h"


@implementation LPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Init Controller
    
    LPMainViewController *mainViewController = [[LPMainViewController alloc] initWithNibName:@"LPMainViewController" bundle:nil];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:mainViewController];
    self.window.rootViewController = navigationController;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
