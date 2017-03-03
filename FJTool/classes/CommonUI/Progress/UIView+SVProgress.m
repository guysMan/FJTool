//
//  UIView+SVProgress.m
//  FJTool
//
//  Created by Jeff on 2017/3/3.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "UIView+SVProgress.h"

#define Text_Font        [UIFont systemFontOfSize:14.0]
#define Foreground_Color [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0]
#define Background_Color [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0]
#define ThickNess        (2.0)
#define Default_Message @"正在加载..."

@implementation UIView (SVProgress)

// SVProgress StartLoading[Default]
- (void)startLoadingAnimation {
    [self startLoadingAnimation:Default_Message];
}

// SVProgress StartLoading[Message]
- (void)startLoadingAnimation:(NSString*)message {
    [self startLoadingAnimation:message textFont:Text_Font foregroundColor:Foreground_Color backgroundColor:Background_Color ringThickness:ThickNess];
}

// SVProgress StartLoading[Basic]
- (void)startLoadingAnimation:(NSString*)message textFont:(UIFont*)textFont foregroundColor:(UIColor*)foregroundColor backgroundColor:(UIColor*)backgroundColor ringThickness:(CGFloat)ringThickness {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
        [SVProgressHUD setFont:textFont];
        [SVProgressHUD setForegroundColor:foregroundColor];
        [SVProgressHUD setBackgroundColor:backgroundColor];
        [SVProgressHUD setRingThickness:ringThickness];
    });
    
    @synchronized (self) {
        if (message == nil || message.length == 0) {
            [SVProgressHUD show];
        }else {
            [SVProgressHUD showWithStatus:message];
        }
    }
}

// SVProgress[Message]
- (void)stopLoadingAnimation {
    [SVProgressHUD dismiss];
}

// SVProgress[Message, CompletonBlock]
- (void)stopLoadingAnimation:(SVProgressHUDDismissCompletion)completion {
    [SVProgressHUD dismiss];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        completion == nil ? : completion();
    });
}


@end
