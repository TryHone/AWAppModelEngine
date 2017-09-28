//
//  AWAppModelEngine.h
//  NSURLProtocolExample
//
//  Created by TryHone on 17/9/19.
//  Copyright © 2017年 lujb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AWAppModelEngine : NSObject <UIApplicationDelegate>
+ (instancetype)shareInstance;
/**
 *  @author Alan, 17-09-19 14:09:51
 *
 *  @brief 注册一个模块进来
 *
 *  @param instance 模块实例对象
 */
- (void)registerClass:(id<UIApplicationDelegate>)instance;
/**
 *  @author Alan, 17-09-19 14:09:12
 *
 *  @brief 移除一个模块
 *
 *  @param aClass 移除模块的class
 */
- (void)unRegisterClass:(Class)aClass;
@end
