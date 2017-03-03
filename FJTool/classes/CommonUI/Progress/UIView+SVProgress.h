//
//  UIView+SVProgress.h
//  FJTool
//
//  Created by Jeff on 2017/3/3.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SVProgressHUD/SVProgressHUD.h>

@interface UIView (SVProgress)

// SVProgress StartLoading[Default]
- (void)startLoadingAnimation;

// SVProgress StartLoading[Message]
- (void)startLoadingAnimation:(NSString*)message;

// SVProgress StartLoading[Basic]
- (void)startLoadingAnimation:(NSString*)message textFont:(UIFont*)textFont foregroundColor:(UIColor*)foregroundColor backgroundColor:(UIColor*)backgroundColor ringThickness:(CGFloat)ringThickness;

// SVProgress[Message]
- (void)stopLoadingAnimation;

// SVProgress[Message, CompletonBlock]
- (void)stopLoadingAnimation:(SVProgressHUDDismissCompletion)completion;

@end
