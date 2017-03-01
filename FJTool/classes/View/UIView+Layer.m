//
//  UIView+Layer.m
//  FJTool
//
//  Created by Jeff on 2017/2/14.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "UIView+Layer.h"

@implementation UIView (Layer)

// 设置圆形
- (void)round {
    [self roundWithBorderWidth:0.0 borderColor:nil];
}

// 设置圆形（边宽、颜色）
- (void)roundWithBorderWidth:(CGFloat)width borderColor:(UIColor*)color {
    CGFloat w = CGRectGetWidth(self.bounds);
    CGFloat h = CGRectGetHeight(self.bounds);
    CGFloat r = 0.0f;
    if (w >= h) {
        r = w / 2.0f;
    }else {
        r = h / 2.0f;
    }
    [self cornerRadius:r borderWidth:width boderColor:color];
}

// 设置圆角（角度）
- (void)cornerRadius:(CGFloat)radius {
    [self cornerRadius:radius borderWidth:0.0 boderColor:nil];
}

// 设置圆角（角度，边宽，颜色）
- (void)cornerRadius:(CGFloat)radius borderWidth:(CGFloat)width boderColor:(UIColor*)color {
    
    self.layer.cornerRadius = radius;
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
    self.layer.masksToBounds = YES;
}

// 设置边框（边宽，颜色）
- (void)borderWidth:(CGFloat)width boderColor:(UIColor*)color {
    [self cornerRadius:0.0 borderWidth:width boderColor:color];
}

// Outter Shadow
- (void)shadowOffset:(CGSize)offset color:(UIColor*)color opacity:(CGFloat)opacity radius:(CGFloat)radius {
    
    // add shadow (use shadowPath to improve rendering performance)
    self.layer.shadowColor = [color CGColor];
    self.layer.shadowOffset = offset;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowRadius = radius;
    self.layer.masksToBounds = NO;
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds];
    self.layer.shadowPath = path.CGPath;
    
}

// Inner Shadow
- (void)innerShadowOffset:(CGRect)innerRect color:(UIColor*)color opacity:(CGFloat)opacity radius:(CGFloat)radius {
    // Please Use YIInnerShadowView
    
}

@end
