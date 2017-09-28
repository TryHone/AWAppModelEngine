//
//  AWPayHelper.m
//  AWAppModelEngine
//
//  Created by TryHone on 17/9/28.
//  Copyright © 2017年 tryhone. All rights reserved.
//

#import "AWPayHelper.h"

@implementation AWPayHelper
- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  NSLog(@"支付初始化");
  return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
  NSLog(@"APP被挂起，支付收到挂起");
}
@end
