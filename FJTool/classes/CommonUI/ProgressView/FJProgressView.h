//
//  FJProgressView.h
//  FJTool
//
//  Created by Jeff on 2017/3/3.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FJProgressView : UIView

@property (nonatomic, strong) UIColor* progressTintColor;
@property (nonatomic, strong) UIColor* borderTintColor;
@property (nonatomic, strong) UIColor* progressBackgroundColor;
@property (nonatomic) CGFloat progress;
@property (nonatomic, strong) NSNumber *kWidth;

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated;

@end
