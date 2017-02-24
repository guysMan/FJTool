//
//  UIColor+Hex.h
//  Demo
//
//  Created by JIEFU on 16/4/28.
//  Copyright © 2016年 Aichen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

+ (UIColor *)colorWithHexString: (NSString *) stringToConvert;

+ (UIColor *)colorWithHexString: (NSString *) stringToConvert withAlpha:(float)alpha;

@end
