//
//  FJPhotoLibraryViewController.h
//  FJTool
//
//  Created by Jeff on 2017/3/1.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <UIKit/UIKit.h>

#define NOTIFY_SELECTED_PICTURE    @"NOTIFY_SELECTED_PICTURE"
#define NOTIFY_UNSELECTED_PICTURE  @"NOTIFY_UNSELECTED_PICTURE"

@interface FJPhotoLibraryUIConfig : NSObject

@property (nonatomic, strong) UIColor *viewBackgroundColor;
@property (nonatomic, assign) BOOL navigationBarHidden;
@property (nonatomic, assign) BOOL navigationBarTranslucent;
@property (nonatomic, strong) UIColor *navigationBarTintColor;
@property (nonatomic, assign) BOOL statusBarHidden;
@property (nonatomic, strong) UIImage *backImage;
@property (nonatomic, assign) CGSize backSize;
@property (nonatomic, copy) NSString *nextText;
@property (nonatomic, strong) UIFont *nextFont;
@property (nonatomic, strong) UIColor *nextColor;
@property (nonatomic, strong) UIColor *nextBackgroundColorDisabled;
@property (nonatomic, strong) UIColor *nextBackgroundColorNormal;
@property (nonatomic, assign) CGSize nextSize;
@property (nonatomic, strong) UIFont *titleViewFont;
@property (nonatomic, strong) UIColor *titleViewColor;



@end

@interface FJPhotoLibraryViewController : UIViewController

- (void)setUiconfig:(FJPhotoLibraryUIConfig *)uiconfig;

@end
