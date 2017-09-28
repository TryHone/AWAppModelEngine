//
//  AWAppModelEngine.m
//  NSURLProtocolExample
//
//  Created by TryHone on 17/9/19.
//  Copyright © 2017年 lujb. All rights reserved.
//

#import "AWAppModelEngine.h"

@interface AWAppModelEngine()
@property(nonatomic,strong)NSMutableDictionary * engineMap;
@end

@implementation AWAppModelEngine
#pragma mark--GCD单列
static AWAppModelEngine *appModelEngine = nil;
+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appModelEngine = [[self alloc]init];
    });
    return appModelEngine;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appModelEngine = [super allocWithZone:zone];
    });
    return appModelEngine;
}
- (id)copyWithZone:(NSZone *)zone{
    return appModelEngine;
}
#pragma mark--懒加载
-(NSMutableDictionary *)engineMap{
    if (!_engineMap) {
        _engineMap = [[NSMutableDictionary alloc] init];
    }
    return _engineMap;
}
#pragma mark--辅助方法
-(void)registerClass:(id<UIApplicationDelegate>)instance{
    if(instance){
        Class  aClass = [instance class];
        NSString * classNameStr =  NSStringFromClass(aClass);
        if (classNameStr&&classNameStr.length) {
            self.engineMap[classNameStr] = instance;
        }
    }
    
}
-(void)unRegisterClass:(Class)aClass{
    if (aClass) {
        NSString * classNameStr = NSStringFromClass(aClass);
        if (classNameStr) {
            [self.engineMap removeObjectForKey:classNameStr];
        }
    }
}

- (void)applicationDidFinishLaunching:(UIApplication *)application{
    [self.engineMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id<UIApplicationDelegate> instance =(id<UIApplicationDelegate>)obj;
        if ([instance respondsToSelector:@selector(applicationDidFinishLaunching:)]) {
            [instance applicationDidFinishLaunching:application];
        }
    }];
}
- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions NS_AVAILABLE_IOS(6_0){
    [self.engineMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id<UIApplicationDelegate> instance =(id<UIApplicationDelegate>)obj;
        if ([instance respondsToSelector:@selector(application:willFinishLaunchingWithOptions:)]) {
            [instance application:application willFinishLaunchingWithOptions:launchOptions];
        }
    }];
    return YES;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions NS_AVAILABLE_IOS(3_0){

    [self.engineMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id<UIApplicationDelegate> instance =(id<UIApplicationDelegate>)obj;
        if ([instance respondsToSelector:@selector(application:didFinishLaunchingWithOptions:)]) {
            [instance application:application didFinishLaunchingWithOptions:launchOptions];
        }
    }];
    
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application{
    [self.engineMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id<UIApplicationDelegate> instance =(id<UIApplicationDelegate>)obj;
        if ([instance respondsToSelector:@selector(applicationDidBecomeActive:)]) {
            [instance applicationDidBecomeActive:application];
        }
    }];
}
- (void)applicationWillResignActive:(UIApplication *)application{
    [self.engineMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id<UIApplicationDelegate> instance =(id<UIApplicationDelegate>)obj;
        if ([instance respondsToSelector:@selector(applicationWillResignActive:)]) {
            [instance applicationWillResignActive:application];
        }
    }];
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url NS_DEPRECATED_IOS(2_0, 9_0, "Please use application:openURL:options:") __TVOS_PROHIBITED{
    [self.engineMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id<UIApplicationDelegate> instance =(id<UIApplicationDelegate>)obj;
        if ([instance respondsToSelector:@selector(application:handleOpenURL:)]) {
            [instance application:application handleOpenURL:url];
        }
    }];
    return YES;
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation NS_DEPRECATED_IOS(4_2, 9_0, "Please use application:openURL:options:") __TVOS_PROHIBITED{
    
    [self.engineMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id<UIApplicationDelegate> instance =(id<UIApplicationDelegate>)obj;
        if ([instance respondsToSelector:@selector(application:openURL:sourceApplication:annotation:)]) {
            [instance application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
        }
    }];

    return YES;
}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options NS_AVAILABLE_IOS(9_0){
    [self.engineMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id<UIApplicationDelegate> instance =(id<UIApplicationDelegate>)obj;
        if ([instance respondsToSelector:@selector(application:openURL:options:)]) {
            [instance application:app openURL:url options:options];
        }
    }];
    return YES;
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    [self.engineMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id<UIApplicationDelegate> instance =(id<UIApplicationDelegate>)obj;
        if ([instance respondsToSelector:@selector(applicationDidReceiveMemoryWarning:)]) {
            [instance applicationDidReceiveMemoryWarning:application];
        }
    }];
}
- (void)applicationWillTerminate:(UIApplication *)application{

    [self.engineMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id<UIApplicationDelegate> instance =(id<UIApplicationDelegate>)obj;
        if ([instance respondsToSelector:@selector(applicationWillTerminate:)]) {
            [instance applicationWillTerminate:application];
        }
    }];

}
- (void)applicationSignificantTimeChange:(UIApplication *)application{
    [self.engineMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id<UIApplicationDelegate> instance =(id<UIApplicationDelegate>)obj;
        if ([instance respondsToSelector:@selector(applicationSignificantTimeChange:)]) {
            [instance applicationSignificantTimeChange:application];
        }
    }];
}
- (void)application:(UIApplication *)application willChangeStatusBarOrientation:(UIInterfaceOrientation)newStatusBarOrientation duration:(NSTimeInterval)duration __TVOS_PROHIBITED{
    [self.engineMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id<UIApplicationDelegate> instance =(id<UIApplicationDelegate>)obj;
        if ([instance respondsToSelector:@selector(application:willChangeStatusBarOrientation:duration:)]) {
            [instance application:application willChangeStatusBarOrientation:newStatusBarOrientation duration:duration];
        }
    }];
}
- (void)application:(UIApplication *)application didChangeStatusBarOrientation:(UIInterfaceOrientation)oldStatusBarOrientation __TVOS_PROHIBITED{
    
    [self.engineMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id<UIApplicationDelegate> instance =(id<UIApplicationDelegate>)obj;
        if ([instance respondsToSelector:@selector(application:didChangeStatusBarOrientation:)]) {
            [instance application:application didChangeStatusBarOrientation:oldStatusBarOrientation];
        }
    }];

}
- (void)application:(UIApplication *)application willChangeStatusBarFrame:(CGRect)newStatusBarFrame __TVOS_PROHIBITED{
    [self.engineMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id<UIApplicationDelegate> instance =(id<UIApplicationDelegate>)obj;
        if ([instance respondsToSelector:@selector(application:willChangeStatusBarFrame:)]) {
            [instance application:application willChangeStatusBarFrame:newStatusBarFrame];
        }
    }];
}
- (void)application:(UIApplication *)application didChangeStatusBarFrame:(CGRect)oldStatusBarFrame __TVOS_PROHIBITED{
    [self.engineMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id<UIApplicationDelegate> instance =(id<UIApplicationDelegate>)obj;
        if ([instance respondsToSelector:@selector(application:didChangeStatusBarFrame:)]) {
            [instance application:application didChangeStatusBarFrame:oldStatusBarFrame];
        }
    }];
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings NS_AVAILABLE_IOS(8_0) __TVOS_PROHIBITED{
    [self.engineMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id<UIApplicationDelegate> instance =(id<UIApplicationDelegate>)obj;
        if ([instance respondsToSelector:@selector(application:didRegisterUserNotificationSettings:)]) {
            [instance application:application didRegisterUserNotificationSettings:notificationSettings];
        }
    }];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken NS_AVAILABLE_IOS(3_0){
    [self.engineMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id<UIApplicationDelegate> instance =(id<UIApplicationDelegate>)obj;
        if ([instance respondsToSelector:@selector(application:didRegisterForRemoteNotificationsWithDeviceToken:)]) {
            [instance application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
        }
    }];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error NS_AVAILABLE_IOS(3_0){
    [self.engineMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id<UIApplicationDelegate> instance =(id<UIApplicationDelegate>)obj;
        if ([instance respondsToSelector:@selector(application:didFailToRegisterForRemoteNotificationsWithError:)]) {
            [instance application:application didFailToRegisterForRemoteNotificationsWithError:error];
        }
    }];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo NS_AVAILABLE_IOS(3_0){
    
    [self.engineMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id<UIApplicationDelegate> instance =(id<UIApplicationDelegate>)obj;
        if ([instance respondsToSelector:@selector(application:didReceiveRemoteNotification:)]) {
            [instance application:application didReceiveRemoteNotification:userInfo];
        }
    }];

}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification NS_AVAILABLE_IOS(4_0) __TVOS_PROHIBITED{
    [self.engineMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id<UIApplicationDelegate> instance =(id<UIApplicationDelegate>)obj;
        if ([instance respondsToSelector:@selector(application:didReceiveRemoteNotification:)]) {
            [instance application:application didReceiveLocalNotification:notification];
        }
    }];
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void(^)())completionHandler NS_AVAILABLE_IOS(8_0) __TVOS_PROHIBITED{
    
    [self.engineMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id<UIApplicationDelegate> instance =(id<UIApplicationDelegate>)obj;
        if ([instance respondsToSelector:@selector(application:handleActionWithIdentifier:forLocalNotification:completionHandler:)]) {
            [instance application:application handleActionWithIdentifier:identifier forLocalNotification:notification completionHandler:completionHandler];
        }
    }];

}
- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void(^)())completionHandler NS_AVAILABLE_IOS(9_0) __TVOS_PROHIBITED{

    [self.engineMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id<UIApplicationDelegate> instance =(id<UIApplicationDelegate>)obj;
        if ([instance respondsToSelector:@selector(application:handleActionWithIdentifier:forRemoteNotification:withResponseInfo:completionHandler:)]) {
            [instance application:application handleActionWithIdentifier:identifier forRemoteNotification:userInfo withResponseInfo:responseInfo  completionHandler:completionHandler];
        }
    }];
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler NS_AVAILABLE_IOS(8_0) __TVOS_PROHIBITED{

    [self.engineMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id<UIApplicationDelegate> instance =(id<UIApplicationDelegate>)obj;
        if ([instance respondsToSelector:@selector(application:handleActionWithIdentifier:forRemoteNotification:completionHandler:)]) {
            [instance application:application handleActionWithIdentifier:identifier forRemoteNotification:userInfo completionHandler:completionHandler];
        }
    }];

}
- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forLocalNotification:(UILocalNotification *)notification withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void(^)())completionHandler NS_AVAILABLE_IOS(9_0) __TVOS_PROHIBITED{
    [self.engineMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id<UIApplicationDelegate> instance =(id<UIApplicationDelegate>)obj;
        if ([instance respondsToSelector:@selector(application:handleActionWithIdentifier:forLocalNotification:withResponseInfo:completionHandler:)]) {
            [instance application:application handleActionWithIdentifier:identifier forLocalNotification:notification withResponseInfo:responseInfo  completionHandler:completionHandler];
        }
    }];

}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler NS_AVAILABLE_IOS(7_0) __TVOS_PROHIBITED{

    [self.engineMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id<UIApplicationDelegate> instance =(id<UIApplicationDelegate>)obj;
        if ([instance respondsToSelector:@selector(application:didReceiveRemoteNotification:fetchCompletionHandler:)]) {
            [instance application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
        }
    }];
}

- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler NS_AVAILABLE_IOS(7_0) __TVOS_PROHIBITED{
    
    [self.engineMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id<UIApplicationDelegate> instance =(id<UIApplicationDelegate>)obj;
        if ([instance respondsToSelector:@selector(application:performFetchWithCompletionHandler:)]) {
            [instance application:application performFetchWithCompletionHandler:completionHandler];
        }
    }];
}
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void(^)(BOOL succeeded))completionHandler NS_AVAILABLE_IOS(9_0) __TVOS_PROHIBITED{

    [self.engineMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id<UIApplicationDelegate> instance =(id<UIApplicationDelegate>)obj;
        if ([instance respondsToSelector:@selector(application:performActionForShortcutItem:completionHandler:)]) {
            [instance application:application performActionForShortcutItem:shortcutItem completionHandler:completionHandler];
        }
    }];

}
- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)())completionHandler NS_AVAILABLE_IOS(7_0){
    [self.engineMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id<UIApplicationDelegate> instance =(id<UIApplicationDelegate>)obj;
        if ([instance respondsToSelector:@selector(application:handleEventsForBackgroundURLSession:completionHandler:)]) {
            [instance application:application handleEventsForBackgroundURLSession:identifier completionHandler:completionHandler];
        }
    }];
}

- (void)application:(UIApplication *)application handleWatchKitExtensionRequest:(nullable NSDictionary *)userInfo reply:(void(^)(NSDictionary * __nullable replyInfo))reply NS_AVAILABLE_IOS(8_2){

    [self.engineMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id<UIApplicationDelegate> instance =(id<UIApplicationDelegate>)obj;
        if ([instance respondsToSelector:@selector(application:handleWatchKitExtensionRequest:reply:)]) {
            [instance application:application handleWatchKitExtensionRequest:userInfo reply:reply];
        }
    }];

}

- (void)applicationShouldRequestHealthAuthorization:(UIApplication *)application NS_AVAILABLE_IOS(9_0){
    [self.engineMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id<UIApplicationDelegate> instance =(id<UIApplicationDelegate>)obj;
        if ([instance respondsToSelector:@selector(applicationShouldRequestHealthAuthorization:)]) {
            [instance applicationShouldRequestHealthAuthorization:application];
        }
    }];
}

- (void)applicationDidEnterBackground:(UIApplication *)application NS_AVAILABLE_IOS(4_0){
    
    [self.engineMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id<UIApplicationDelegate> instance =(id<UIApplicationDelegate>)obj;
        if ([instance respondsToSelector:@selector(applicationDidEnterBackground:)]) {
            [instance applicationDidEnterBackground:application];
        }
    }];

}
- (void)applicationWillEnterForeground:(UIApplication *)application NS_AVAILABLE_IOS(4_0){

    [self.engineMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id<UIApplicationDelegate> instance =(id<UIApplicationDelegate>)obj;
        if ([instance respondsToSelector:@selector(applicationWillEnterForeground:)]) {
            [instance applicationWillEnterForeground:application];
        }
    }];
}

- (void)applicationProtectedDataWillBecomeUnavailable:(UIApplication *)application NS_AVAILABLE_IOS(4_0){
    
    [self.engineMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id<UIApplicationDelegate> instance =(id<UIApplicationDelegate>)obj;
        if ([instance respondsToSelector:@selector(applicationProtectedDataWillBecomeUnavailable:)]) {
            [instance applicationProtectedDataWillBecomeUnavailable:application];
        }
    }];

}
- (void)applicationProtectedDataDidBecomeAvailable:(UIApplication *)application    NS_AVAILABLE_IOS(4_0){
    
    [self.engineMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id<UIApplicationDelegate> instance =(id<UIApplicationDelegate>)obj;
        if ([instance respondsToSelector:@selector(applicationProtectedDataDidBecomeAvailable:)]) {
            [instance applicationProtectedDataDidBecomeAvailable:application];
        }
    }];

}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window  NS_AVAILABLE_IOS(6_0) __TVOS_PROHIBITED{
    [self.engineMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id<UIApplicationDelegate> instance =(id<UIApplicationDelegate>)obj;
        if ([instance respondsToSelector:@selector(application:supportedInterfaceOrientationsForWindow:)]) {
            [instance application:application supportedInterfaceOrientationsForWindow:window];
        }
    }];
    
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)application:(UIApplication *)application shouldAllowExtensionPointIdentifier:(NSString *)extensionPointIdentifier NS_AVAILABLE_IOS(8_0){
    
    [self.engineMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id<UIApplicationDelegate> instance =(id<UIApplicationDelegate>)obj;
        if ([instance respondsToSelector:@selector(application:shouldAllowExtensionPointIdentifier:)]) {
            [instance application:application shouldAllowExtensionPointIdentifier:extensionPointIdentifier];
        }
    }];

   return YES;
}

#pragma mark -- State Restoration protocol adopted by UIApplication delegate --

- (nullable UIViewController *) application:(UIApplication *)application viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder NS_AVAILABLE_IOS(6_0){
    
    [self.engineMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id<UIApplicationDelegate> instance =(id<UIApplicationDelegate>)obj;
        if ([instance respondsToSelector:@selector(application:viewControllerWithRestorationIdentifierPath:coder:)]) {
            [instance application:application viewControllerWithRestorationIdentifierPath:identifierComponents coder:coder];
        }
    }];


   return [UIViewController new];
}
- (BOOL) application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder NS_AVAILABLE_IOS(6_0){
    
    [self.engineMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id<UIApplicationDelegate> instance =(id<UIApplicationDelegate>)obj;
        if ([instance respondsToSelector:@selector(application:shouldSaveApplicationState:)]) {
            [instance application:application shouldSaveApplicationState:coder];
        }
    }];

    
 return YES;
}
- (BOOL) application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder NS_AVAILABLE_IOS(6_0){
    
    [self.engineMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id<UIApplicationDelegate> instance =(id<UIApplicationDelegate>)obj;
        if ([instance respondsToSelector:@selector(application:shouldRestoreApplicationState:)]) {
            [instance application:application shouldRestoreApplicationState:coder];
        }
    }];

    return YES;
}
- (void) application:(UIApplication *)application willEncodeRestorableStateWithCoder:(NSCoder *)coder NS_AVAILABLE_IOS(6_0){
    
    [self.engineMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id<UIApplicationDelegate> instance =(id<UIApplicationDelegate>)obj;
        if ([instance respondsToSelector:@selector(application:willEncodeRestorableStateWithCoder:)]) {
            [instance application:application willEncodeRestorableStateWithCoder:coder];
        }
    }];


}
- (void) application:(UIApplication *)application didDecodeRestorableStateWithCoder:(NSCoder *)coder NS_AVAILABLE_IOS(6_0){
    
    [self.engineMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id<UIApplicationDelegate> instance =(id<UIApplicationDelegate>)obj;
        if ([instance respondsToSelector:@selector(application:didDecodeRestorableStateWithCoder:)]) {
            [instance application:application didDecodeRestorableStateWithCoder:coder];
        }
    }];

}
- (BOOL)application:(UIApplication *)application willContinueUserActivityWithType:(NSString *)userActivityType NS_AVAILABLE_IOS(8_0){
    
    [self.engineMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id<UIApplicationDelegate> instance =(id<UIApplicationDelegate>)obj;
        if ([instance respondsToSelector:@selector(application:willContinueUserActivityWithType:)]) {
            [instance application:application willContinueUserActivityWithType:userActivityType];
        }
    }];

 return YES;
}
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray * __nullable restorableObjects))restorationHandler NS_AVAILABLE_IOS(8_0){
    
    [self.engineMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id<UIApplicationDelegate> instance =(id<UIApplicationDelegate>)obj;
        if ([instance respondsToSelector:@selector(application:continueUserActivity:restorationHandler:)]) {
            [instance application:application continueUserActivity:userActivity restorationHandler:restorationHandler];
        }
    }];
    
 return YES;
}
- (void)application:(UIApplication *)application didFailToContinueUserActivityWithType:(NSString *)userActivityType error:(NSError *)error NS_AVAILABLE_IOS(8_0){

    [self.engineMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id<UIApplicationDelegate> instance =(id<UIApplicationDelegate>)obj;
        if ([instance respondsToSelector:@selector(application:didFailToContinueUserActivityWithType:error:)]) {
            [instance application:application didFailToContinueUserActivityWithType:userActivityType error:error];
        }
    }];

}

- (void)application:(UIApplication *)application didUpdateUserActivity:(NSUserActivity *)userActivity NS_AVAILABLE_IOS(8_0){

    [self.engineMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id<UIApplicationDelegate> instance =(id<UIApplicationDelegate>)obj;
        if ([instance respondsToSelector:@selector(application:didUpdateUserActivity:)]) {
            [instance application:application didUpdateUserActivity:userActivity];
        }
    }];
}

@end
