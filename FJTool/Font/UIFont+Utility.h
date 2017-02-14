//
//  UIFont+Utility.h
//  baijie
//
//  Created by Fu Jie on 15/11/9.
//  Copyright © 2015年 Aichen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,FontStyle) {
    FontStyle_UltraLight,
    FontStyle_Thin,
    FontStyle_Light,
    FontStyle_Regular,
    FontStyle_Medium,
    FontStyle_Semibold,
    FontStyle_Bold,
    FontStyle_Heavy,
    FontStyle_Black
};

// 苹方字体名称
#define PINGFANG_REGULAR      @"PingFangSC-Regular"
#define PINGFANG_LIGHT        @"PingFangSC-Light"
#define PINGFANG_SEMIBOLD     @"PingFangSC-Semibold"
// 自定义字体名称
#define FZLTH_REGULAR         @"FZLTHJW--GB1-0"     // 方正兰亭黑
#define FZLTH_LIGHT           @"FZLTXIHJW--GB1-0"   // 方正兰亭细黑
#define GOTHAM_BOOK           @"GothamBook"         // 数字

@interface UIFont (Utility)

// 系统自带字体
+ (UIFont *)systemFontOfSize:(CGFloat)fontSize style:(FontStyle)fontStyle;

// 苹方字体（iOS9.0以上）
+ (UIFont *)pingfang_light:(CGFloat)fontSize;
+ (UIFont *)pingfang_regular:(CGFloat)fontSize;
+ (UIFont *)pingfang_semibold:(CGFloat)fontSize;

// 方正兰亭黑（自定义）
+ (UIFont *)fzlth_regular:(CGFloat)fontSize;
// 方正兰亭细黑（自定义）
+ (UIFont *)fzlth_light:(CGFloat)fontSize;

// Gotham_Book（自定义）
+ (UIFont *)gothambook:(CGFloat)fontSize;


@end
