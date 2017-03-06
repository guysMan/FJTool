//
//  FJDropSheet.h
//  FJTool
//
//  Created by Jeff on 2017/3/3.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FJDropSheetDelegate;

@interface FJDropSheet : UIView

// 初始化
- (instancetype)initWithMessage:(NSString *)message;
- (instancetype)initWithMessage:(NSString *)message tapBlock:(void(^)(void))tapBlock cancelBlock:(void(^)(void))cancelBlock;
- (instancetype)initWithMessage:(NSString *)message textFont:(UIFont*)textFont textColor:(UIColor*)textColor sheetbackgroundColor:(UIColor*)sheetbackgroundColor closeImageNormal:(UIImage*)closeImageNormal closeImageHighlighted:(UIImage*)closeImageHighlighted stayDuration:(CGFloat)stayDuration tapBlock:(void(^)(void))tapBlock cancelBlock:(void(^)(void))cancelBlock;

// 显示
- (void)showInView:(UIView *)view;

@end
