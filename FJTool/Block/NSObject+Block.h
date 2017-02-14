//
//  NSObject+Block.h
//  FJTool
//
//  Created by Jeff on 2017/2/14.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Block)

// 添加通知（无参）
- (void)addNotification:(NSString*)name notifyBlock:(void(^)(void))notifyBlock;

// 添加通知（带参）
- (void)addNotification:(NSString*)name parameterBlock:(void (^)(NSDictionary *userInfo))notifyBlock;

// 发送通知（无参）
- (void)postNotification:(NSString*)name;

// 发送通知（带参object）
- (void)postNotification:(NSString*)name object:(id)object;

// 发送通知（带参object,infos）
- (void)postNotification:(NSString*)name object:(id)object infos:(id)infos;

// 删除通知
- (void)removeNotifications;

// 删除通知（通知名称）
- (void)removeNotification:(NSString*)name;

@end
