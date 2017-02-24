//
//  NSObject+Block.m
//  FJTool
//
//  Created by Jeff on 2017/2/14.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "NSObject+Block.h"

@implementation NSObject (Block)

// 添加通知（无参）
- (void)addNotification:(NSString*)name notifyBlock:(void(^)(void))notifyBlock {
    [[NSNotificationCenter defaultCenter] addObserverForName:name object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        if (notifyBlock) {
            notifyBlock();
        }
    }];
}

// 添加通知（带参）
- (void)addNotification:(NSString*)name parameterBlock:(void (^)(NSDictionary *userInfo))notifyBlock {
    [[NSNotificationCenter defaultCenter] addObserverForName:name object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        if (notifyBlock) {
            notifyBlock(note.userInfo);
        }
    }];
}

// 发送通知（无参）
- (void)postNotification:(NSString*)name {
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil userInfo:nil];
}

// 发送通知（带参object）
- (void)postNotification:(NSString*)name object:(id)object {
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:object userInfo:nil];
}

// 发送通知（带参object,infos）
- (void)postNotification:(NSString*)name object:(id)object infos:(id)infos {
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:object userInfo:infos];
}

// 删除通知
- (void)removeNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// 删除通知（通知名称）
- (void)removeNotification:(NSString*)name {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:name object:nil];
}

@end
