//
//  FJTimer.m
//  Demo
//
//  Created by Fu Jie on 16/5/17.
//  Copyright © 2016年 Aichen. All rights reserved.
//

#import "FJTimer.h"

@interface FJTimer()
{
    dispatch_source_t _timer;
    
    int _countdown;
    int _interval;
    FJTimerBlock _block;
    
    int _curDays;
    int _curHours;
    int _curMinutes;
    int _curSeconds;
    int _curTimeout;
}

@end

@implementation FJTimer

- (void)dealloc {
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}

- (id)initWithCoutdown:(int)countdown interval:(int)interval callback:(FJTimerBlock)callback{
    self = [super init];
    if (self) {
        _countdown = countdown;
        _interval = interval;
        _block = callback;
    }
    return self;
}

- (void)setTimerCallback:(FJTimerBlock)callback {
    
    if (_block) {
        _block = nil;
    }
    
    _block = callback;
}

// 开始计时（重复调用和第一次调用效果一样）
- (void)startTimer {
    [self startTimer:_countdown interval:_interval restart:NO];
}

- (void)startTime:(long long)startTime endTime:(long long)endTime interval:(float)interval{
    [self startTimer:(int)(endTime - startTime) interval:interval restart:NO];
}

- (void)startTimer:(int)timeout interval:(float)interval {
    [self startTimer:timeout interval:interval restart:NO];
}

// 重新计时
- (void)reStartTimer {
    [self startTimer:_countdown interval:_interval restart:YES];
}

- (void)reStartTime:(long long)startTime endTime:(long long)endTime interval:(float)interval {
    [self startTimer:(int)(endTime - startTime) interval:interval restart:YES];
}

- (void)reStartTimer:(int)timeout interval:(float)interval {
    [self startTimer:timeout interval:interval restart:YES];
}

// 停止
- (void)endTimer {
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
    [self setCurrentDays:0 hours:0 minutes:0 seconds:0];
    _block(0,0,0,0);
}

// 暂停
- (void)suspend {
    [self startTimer:0 interval:0 restart:YES];
    _block(_curDays,_curHours,_curMinutes,_curSeconds);
}

// 继续
- (void)resume {
    [self startTimer:_curTimeout interval:_interval restart:YES];
}

// 公共方法
- (void)startTimer:(int)countdown interval:(float)interval restart:(BOOL)restart {
    
    if (restart == YES) {
        if (_timer) {
            dispatch_source_set_event_handler(_timer, NULL);
            _timer = nil;
        }
    }
    if (_timer == nil) {
        __block int time = countdown;
        if (time != 0) {
            
            __weak typeof(self) weakSelf = self;
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
            
            // 每period秒执行一次
            dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), interval * NSEC_PER_SEC, 0);
            dispatch_source_set_event_handler(_timer, ^{
                
                if(time <= 0){ //倒计时结束，关闭
                    dispatch_source_cancel(_timer);
                    _timer = nil;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf setCurrentDays:0 hours:0 minutes:0 seconds:0];
                        _block(0,0,0,0);
                    });
                }else{
                    int days =   (int) (time / (3600 * 24) );
                    int hours =  (int) ((time - days * 24 * 3600) / 3600);
                    int minute = (int) (time - days * 24 * 3600 - hours * 3600) / 60;
                    int second = time - days * 24 * 3600 - hours * 3600 - minute * 60;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf setCurrentDays:days hours:hours minutes:minute seconds:second];
                        _block(days, hours, minute, second);
                    });
                    time--;
                }
            });
            dispatch_resume(_timer);
        }
    }
}

- (void)setCurrentDays:(int)days hours:(int)hours minutes:(int)minutes seconds:(int)seconds {
    _curDays = days;
    _curHours = hours;
    _curMinutes = minutes;
    _curSeconds = seconds;
    _curTimeout = (days * days * 24 * 3600) + (hours * 3600) + (minutes * 60) + seconds;
}

@end
