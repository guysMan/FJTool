//
//  UIFont+Utility.m
//  baijie
//
//  Created by Fu Jie on 15/11/9.
//  Copyright © 2015年 Aichen. All rights reserved.
//

#import "UIFont+Utility.h"
#import <objc/runtime.h>

@implementation UIFont (Utility)

// 系统自带字体
+ (UIFont *)systemFontOfSize:(CGFloat)fontSize style:(FontStyle)fontStyle {
    
    Method method = class_getClassMethod([UIFont class], @selector(systemFontOfSize:weight:));
    
    if (method != NULL) {
        // iOS 8.2 & above
        if (fontStyle == FontStyle_UltraLight) {
            return [UIFont systemFontOfSize:fontSize weight:UIFontWeightUltraLight];
        }else if (fontStyle == FontStyle_Thin) {
            return [UIFont systemFontOfSize:fontSize weight:UIFontWeightThin];
        }else if (fontStyle == FontStyle_Light) {
            return [UIFont systemFontOfSize:fontSize weight:UIFontWeightLight];
        }else if (fontStyle == FontStyle_Regular) {
            return [UIFont systemFontOfSize:fontSize weight:UIFontWeightRegular];
        }else if (fontStyle == FontStyle_Medium) {
            return [UIFont systemFontOfSize:fontSize weight:UIFontWeightMedium];
        }else if (fontStyle == FontStyle_Semibold) {
            return [UIFont systemFontOfSize:fontSize weight:UIFontWeightSemibold];
        }else if (fontSize == FontStyle_Bold) {
            return [UIFont systemFontOfSize:fontSize weight:UIFontWeightBold];
        }else if (fontSize == FontStyle_Heavy) {
            return [UIFont systemFontOfSize:fontSize weight:UIFontWeightHeavy];
        }else if (fontSize == FontStyle_Black) {
            return [UIFont systemFontOfSize:fontSize weight:UIFontWeightBlack];
        }
        
    }else{
        
        // iOS 8.1 & below
        if (fontStyle == FontStyle_UltraLight ||
            fontStyle == FontStyle_Thin ||
            fontStyle == FontStyle_Light) {
            return [UIFont systemFontOfSize:fontSize];
            
        }else if (fontStyle == FontStyle_Regular ||
                  fontStyle == FontStyle_Medium) {
            return [UIFont systemFontOfSize:fontSize];
            
        }else if (fontStyle == FontStyle_Semibold ||
                  fontSize == FontStyle_Bold ||
                  fontSize == FontStyle_Heavy ||
                  fontSize == FontStyle_Black) {
            return [UIFont boldSystemFontOfSize:fontSize];
        
        }
    }
    
    return [UIFont systemFontOfSize:fontSize];
}

// 苹方字体（iOS9.0以上）
+ (UIFont *)pingfang_light:(CGFloat)fontSize {
    return [UIFont fontWithName:PINGFANG_LIGHT size:fontSize];
}

+ (UIFont *)pingfang_regular:(CGFloat)fontSize {
    return [UIFont fontWithName:PINGFANG_REGULAR size:fontSize];
}

+ (UIFont *)pingfang_semibold:(CGFloat)fontSize {
    return [UIFont fontWithName:PINGFANG_SEMIBOLD size:fontSize];
}

// 方正兰亭黑（自定义）
+ (UIFont *)fzlth_regular:(CGFloat)fontSize {
    return [UIFont fontWithName:FZLTH_REGULAR size:fontSize];
}

// 方正兰亭细黑（自定义）
+ (UIFont *)fzlth_light:(CGFloat)fontSize {
    return [UIFont fontWithName:FZLTH_LIGHT size:fontSize];
}

// Gotham_Book（自定义）
+ (UIFont *)gothambook:(CGFloat)fontSize {
    return [UIFont fontWithName:GOTHAM_BOOK size:fontSize];
}

@end
