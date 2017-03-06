//
//  UIView+PromptToast.h
//  FJTool
//
//  Created by Jeff on 2017/3/3.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (PromptToast)

// Toast[Title, Message]
- (void)toast:(NSString*)title message:(NSString*)message;

// Toast[Title, Message, Duration]
- (void)toast:(NSString*)title message:(NSString*)message duration:(CGFloat)duration;

// Toast[Title, Message, OverWindow]
- (void)toast:(NSString*)title message:(NSString*)message overWindow:(BOOL)overWindow;

// Toast[Title, Message, Duration, OverWindow]
- (void)toast:(NSString*)title message:(NSString*)message duration:(CGFloat)duration overWindow:(BOOL)overWindow;

// Toast[Basic]
- (void)toast:(NSString *)title titleColor:(UIColor*)titleColor titleFont:(UIFont*)titleFont titleAlignment:(NSTextAlignment)titleAlignment message:(NSString *)message messageColor:(UIColor*)messageColor messageFont:(UIFont*)messageFont messageAlignment:(NSTextAlignment)messageAlignment positon:(id)position duration:(CGFloat)duration image:(UIImage*)image cornerRadius:(CGFloat)cornerRadius queue:(BOOL)queue tapDismiss:(BOOL)tapDismiss overWindow:(BOOL)overWindow;

@end
