//
//  FJProgressView.h
//  FJTool
//
//  Created by Jeff on 2017/3/3.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FJProgressView : UIView

// Initialize
- (id)initWithFrame:(CGRect)frame backgroundColor:(UIColor*)backgroundColor progressTintColor:(UIColor*)progressTintColor borderTintColor:(UIColor*)borderTintColor borderStrokeWidth:(NSNumber*)borderStrokeWidth;

// UI - Progress Tint Color
- (void)setProgressTintColor:(UIColor *)progressTintColor;

// UI - Border Tint Color
- (void)setBorderTintColor:(UIColor *)borderTintColor;

// UI- Progress Background Color
- (void)setProgressBackgroundColor:(UIColor *)backgroundColor;

// UI - Border Width
- (void)setBorderStrokeWidth:(NSNumber *)borderStrokeWidth;

// UI - Progress
- (void)setProgress:(CGFloat)progress;

// UI - Progress[Animated]
- (void)setProgress:(CGFloat)progress animated:(BOOL)animated;

@end
