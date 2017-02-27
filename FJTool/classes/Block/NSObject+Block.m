//
//  NSObject+Block.m
//  FJTool
//
//  Created by Jeff on 2017/2/14.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "NSObject+Block.h"
#import <objc/runtime.h>

@implementation NSObject (Block)


- (void)setNoParamaterBlock:(void(^)(void))notifyBlock name:(NSString*)name {
    [self setBaseBlock:notifyBlock name:name];
}

- (void)setParamaterBlock:(void(^)(NSDictionary*))notifyBlock name:(NSString*)name {
    [self setBaseBlock:notifyBlock name:name];
}

- (void)setBaseBlock:(id)notifyBlock name:(NSString*)name {
    NSMutableDictionary *blockMap = objc_getAssociatedObject(self, @"blockMap");
    if (blockMap == nil) {
        blockMap = [[NSMutableDictionary alloc] init];
    }
    if (notifyBlock != nil && name != nil) {
        [blockMap setObject:notifyBlock forKey:name];
    }
    objc_setAssociatedObject(self, @"blockMap", blockMap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)getBlock:(NSString*)name {
    NSMutableDictionary *blockMap = objc_getAssociatedObject(self, @"blockMap");
    if (blockMap == nil) {
        return nil;
    }
    return [blockMap objectForKey:name];
}

- (void)removeBlock:(NSString*)name {
    NSMutableDictionary *blockMap = objc_getAssociatedObject(self, @"blockMap");
    [blockMap removeObjectForKey:name];
}

- (void)removeAllBlocks {
    NSMutableDictionary *blockMap = objc_getAssociatedObject(self, @"blockMap");
    [blockMap removeAllObjects];
}


// 添加通知（Block不带参）
- (void)addNotification:(NSString*)name notifyBlock:(void(^)(void))notifyBlock {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:name object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callObserverWOParameter:) name:name object:nil];
    [self setNoParamaterBlock:notifyBlock name:name];
}

- (void)callObserverWOParameter:(NSNotification*)notify {
    NSString *name = [notify name];
    void(^block)(void) = [self getBlock:name];
    block == nil ? : block();
}

// 添加通知（Block带参,postNotificationName:object:userInfo:对应，这个object和post方法中的anObject对应，设置对应后才能触发。）
- (void)addNotification:(NSString*)name notifyParameterBlock:(void(^)(NSDictionary* userInfo))notifyParameterBlock {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:name object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callObserverWParameter:) name:name object:nil];
    [self setParamaterBlock:notifyParameterBlock name:name];
}

- (void)callObserverWParameter:(NSNotification*)notify {
    NSString *name = [notify name];
    NSDictionary *userInfo = [notify userInfo];
    void(^block)(NSDictionary*) = [self getBlock:name];
    block == nil ? : block(userInfo);
}

// 发送通知（无参）
- (void)postNotification:(NSString*)name {
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil userInfo:nil];
}

// 发送通知（带参infos）
- (void)postNotification:(NSString*)name infos:(id)infos {
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil userInfo:infos];
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
    [self removeAllBlocks];
}

// 删除通知（通知名称）
- (void)removeNotification:(NSString*)name {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:name object:nil];
    [self removeBlock:name];
}

@end
