//
//  UIView+DropSheet.h
//  FJTool
//
//  Created by Jeff on 2017/3/6.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DropSheet)

- (void)dropSheet:(NSString*)message;

- (void)dropSheet:(NSString*)message tapBlock:(void(^)(void))tapBlock cancelBlock:(void(^)(void))cancelBlock;

- (void)dropSheet:(NSString *)message textFont:(UIFont*)textFont textColor:(UIColor*)textColor sheetbackgroundColor:(UIColor*)sheetbackgroundColor closeImageNormal:(UIImage*)closeImageNormal closeImageHighlighted:(UIImage*)closeImageHighlighted stayDuration:(CGFloat)stayDuration tapBlock:(void(^)(void))tapBlock cancelBlock:(void(^)(void))cancelBlock;

@end
