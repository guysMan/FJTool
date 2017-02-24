//
//  UIView+Layer.h
//  FJTool
//
//  Created by Jeff on 2017/2/14.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Layer)

// 设置圆形
- (void)setRoundView;

// 设置圆形（边宽、颜色）
- (void)setRoundViewWidth:(CGFloat)width color:(UIColor*)color;

// 设置圆角（角度）
- (void)setViewCornerRadius:(CGFloat)radius;

// 设置圆角（角度，边宽，颜色）
- (void)setViewCornerRadius:(CGFloat)radius borderWidth:(CGFloat)width boderColor:(UIColor*)color;

// 设置边框（边宽，颜色）
- (void)setViewBorderWidth:(CGFloat)width boderColor:(UIColor*)color;

// Outter Shadow
- (void)shadowOffset:(CGSize)offset color:(UIColor*)color opacity:(CGFloat)opacity radius:(CGFloat)radius;

// Inner Shadow
- (void)innerShadowOffset:(CGRect)innerRect color:(UIColor*)color opacity:(CGFloat)opacity radius:(CGFloat)radius;

@end
