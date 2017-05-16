//
//  FJRegionViewController.h
//  FJTool
//
//  Created by Jeff on 2017/5/16.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FJRegionViewController : UIViewController

@property (nonatomic, copy) void(^selectCountryBlock)(NSString *regionCode, NSString *regionName);
@property (nonatomic, assign) BOOL    isHot;
@property (nonatomic, strong) UIFont  *regionTextFont;
@property (nonatomic, strong) UIColor *regionTextColor;
@property (nonatomic, strong) UIFont  *regionCodeFont;
@property (nonatomic, strong) UIColor *regionCodeColor;
@property (nonatomic, strong) UIFont  *sectionHeaderTextFont;
@property (nonatomic, strong) UIColor *sectionHeaderTextColor;
@property (nonatomic, strong) UIColor *sectionHeaderBackgroundColor;
@property (nonatomic, strong) UIColor *sectionIndexBackgroundColor;
@property (nonatomic, strong) UIColor *sectionIndexColor;

@end
