//
//  NSObject+CRToast.m
//  FJDemo
//
//  Created by Jeff on 2017/3/3.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "NSObject+CRToast.h"
#import "PodHelper.h"

@implementation NSObject (CRToast)

// CRToast[Basic]
- (void)CRToastTitle:(NSString*)title subTitle:(NSString*)subTitle {
    [self CRToastTitle:title titleColor:[UIColor whiteColor] titleFont:[UIFont systemFontOfSize:16.0] subTitle:subTitle subTitleColor:[UIColor whiteColor] subTitleFont:[UIFont systemFontOfSize:12.0] backgroundColor:[UIColor blackColor] icon:nil duration:2.0];
}

// CRToast[Type]
- (void)CRToastTitle:(NSString*)title subTitle:(NSString*)subTitle type:(CRToastImageType)type {
    
    UIImage *image = nil;
    switch (type) {
        case CRToastImageType_Error:
            image = [PodHelper getPodImage:@"icon_toast_wrong_white" class:[self class]];
            break;
            
        case CRToastImageType_Message:
            image = [PodHelper getPodImage:@"icon_toast_email_white" class:[self class]];
            break;
            
        case CRToastImageType_Service:
            image = [PodHelper getPodImage:@"icon_toast_service_white" class:[self class]];
            break;
            
        case CRToastImageType_Success:
            image = [PodHelper getPodImage:@"icon_toast_success_white" class:[self class]];
            break;
            
        case CRToastImageType_Warning:
            image = [PodHelper getPodImage:@"icon_toast_warning_white" class:[self class]];
            break;
            
        case CRToastImageType_Infomation:
            image = [PodHelper getPodImage:@"icon_toast_information_white" class:[self class]];
            break;
            
        default:
            break;
    }
    
    [self CRToastTitle:title titleColor:[UIColor whiteColor] titleFont:[UIFont systemFontOfSize:16.0] subTitle:subTitle subTitleColor:[UIColor whiteColor] subTitleFont:[UIFont systemFontOfSize:12.0] backgroundColor:[UIColor blackColor] icon:nil duration:2.0];
}


// CRToast[All]
- (void)CRToastTitle:(NSString*)title titleColor:(UIColor*)titleColor titleFont:(UIFont*)titleFont subTitle:(NSString*)subTitle subTitleColor:(UIColor*)subTitleColor subTitleFont:(UIFont*)subTitleFont backgroundColor:(UIColor*)backgroundColor icon:(UIImage*)icon duration:(CGFloat)duration {
    
    NSDictionary *options = nil;
    if (icon == nil) {
        options = @{
                    kCRToastNotificationTypeKey : @(CRToastTypeNavigationBar),         // 风格
                    kCRToastTextKey : title,                                           // 文字
                    kCRToastFontKey: titleFont,                                        // 字体
                    kCRToastTextColorKey : titleColor,                                 // 文字颜色
                    kCRToastTextAlignmentKey : @(NSTextAlignmentLeft),                 // 文字位置
                    kCRToastSubtitleTextKey : subTitle,
                    kCRToastSubtitleFontKey : subTitleFont,
                    kCRToastSubtitleTextColorKey : subTitleColor,
                    kCRToastSubtitleTextAlignmentKey : @(NSTextAlignmentLeft),
                    
                    kCRToastBackgroundColorKey : backgroundColor,                      // 背景色
                    kCRToastTimeIntervalKey : @1,                                      // 时间
                    
                    // kCRToastForceUserInteractionKey : @YES,
                    // kCRToastIdentifierKey : @"YES",
                    
                    kCRToastAnimationInTypeKey : @(CRToastAnimationTypeLinear),        // 开始的动画方式
                    kCRToastAnimationOutTypeKey : @(CRToastAnimationTypeLinear),       // 结束的动画方式
                    kCRToastAnimationInDirectionKey : @(CRToastAnimationDirectionTop), // 动画的开始方向
                    kCRToastAnimationOutDirectionKey : @(CRToastAnimationDirectionTop),// 动画的结束方向
                    };
    }else{
        options = @{
                    kCRToastNotificationTypeKey : @(CRToastTypeNavigationBar),         // 风格
                    kCRToastTextKey : title,                                           // 文字
                    kCRToastFontKey: titleFont,                                        // 字体
                    kCRToastTextColorKey : titleColor,                                 // 文字颜色
                    kCRToastTextAlignmentKey : @(NSTextAlignmentLeft),                 // 文字位置
                    kCRToastSubtitleTextKey : subTitle,
                    kCRToastSubtitleFontKey : subTitleFont,
                    kCRToastSubtitleTextColorKey : subTitleColor,
                    kCRToastSubtitleTextAlignmentKey : @(NSTextAlignmentLeft),
                    
                    kCRToastImageKey : icon,                                           // icon
                    kCRToastImageAlignmentKey : @(CRToastAccessoryViewAlignmentLeft),  // 方位
                    
                    kCRToastBackgroundColorKey : backgroundColor,                      // 背景色
                    kCRToastTimeIntervalKey : @1,                                      // 时间
                    
                    // kCRToastForceUserInteractionKey : @YES,
                    // kCRToastIdentifierKey : @"YES",
                    
                    kCRToastAnimationInTypeKey : @(CRToastAnimationTypeLinear),        // 开始的动画方式
                    kCRToastAnimationOutTypeKey : @(CRToastAnimationTypeLinear),       // 结束的动画方式
                    kCRToastAnimationInDirectionKey : @(CRToastAnimationDirectionTop), // 动画的开始方向
                    kCRToastAnimationOutDirectionKey : @(CRToastAnimationDirectionTop),// 动画的结束方向
                    };
    }
    
    [CRToastManager showNotificationWithOptions:options
                                completionBlock:^{
                                    NSLog(@"Completed");
                                }];
    
}

@end
