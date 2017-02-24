//
//  FJTimer.h
//  Demo
//
//  Created by Fu Jie on 16/5/17.
//  Copyright © 2016年 Aichen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^FJTimerBlock) (int days, int hrs, int mins, int secs);

@interface FJTimer : NSObject

// 初始化(countdown, interval, callback)
- (id)initWithCoutdown:(int)countdown interval:(int)interval callback:(FJTimerBlock)callback;

// 设置回调
- (void)setTimerCallback:(FJTimerBlock)callback;

// 开始计时（重复调用和第一次调用效果一样）
- (void)startTimer;
- (void)startTime:(long long)startTime endTime:(long long)endTime interval:(float)interval;
- (void)startTimer:(int)timeout interval:(float)interval;

// 重新计时
- (void)reStartTimer;
- (void)reStartTime:(long long)startTime endTime:(long long)endTime interval:(float)interval;
- (void)reStartTimer:(int)timeout interval:(float)interval;

// 停止
- (void)endTimer;

// 暂停
- (void)suspend;

// 继续
- (void)resume;

// 公共方法
- (void)startTimer:(int)countdown interval:(float)interval restart:(BOOL)restart;

@end
