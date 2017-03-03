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

@property (nonatomic, weak)   id<FJDropSheetDelegate> delegate;
@property (nonatomic, copy)   void(^tapBlock)(void);
@property (nonatomic, assign) CGFloat stay_duration;

- (id)initWithTitle:(NSString *)title delegate:(id<FJDropSheetDelegate>)delegate;
- (void)showFromRect:(CGRect)rect inView:(UIView *)view animated:(BOOL)animated;
- (void)showInView:(UIView *)view;
- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated;

@end

@protocol FJDropSheetDelegate

@optional

- (void)dropTipSheetActionSheet:(FJDropSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
- (void)dropTipSheetActionSheetCancel:(FJDropSheet *)actionSheet;

@end
