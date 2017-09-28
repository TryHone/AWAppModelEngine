//
//  AWAppDelegate.m
//  AWAppModelEngine
//
//  Created by tryhone on 09/28/2017.
//  Copyright (c) 2017 tryhone. All rights reserved.
//

#import "AWAppDelegate.h"
#import "AWAppModelEngine.h"
#import "AWPayHelper.h"
#import "AWShareHelper.h"

@implementation AWAppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [[AWAppModelEngine shareInstance] registerClass:[AWPayHelper new]];
  [[AWAppModelEngine shareInstance] registerClass:[AWShareHelper new]];
  [[AWAppModelEngine shareInstance] application:application
                  didFinishLaunchingWithOptions:launchOptions];

  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
  [[AWAppModelEngine shareInstance] applicationWillResignActive:application];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
