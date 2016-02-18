//
//  AppDelegate.m
//  LayerMaskingPOC
//
//  Created by David Clark on 18/02/2016.
//  Copyright (c) 2016 David Clark. All rights reserved.
//


#import "AppDelegate.h"
#import "ViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setWindow:[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]]];
    [self.window setRootViewController:[[ViewController alloc] init]];
    [self.window makeKeyAndVisible];

    return YES;
}


@end
