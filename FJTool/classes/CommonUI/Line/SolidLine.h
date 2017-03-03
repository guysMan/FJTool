//
//  SolidLine.h
//  baijie
//
//  Created by Fu Jie on 16/3/24.
//  Copyright © 2016年 Aichen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LineOrientForXib) {
    LineOrientForXib_Up_Light    = 0,     // DOWN Light
    LineOrientForXib_Up_Dark     = 1,     // DOWN Dark
    LineOrientForXib_Left_Light  = 2,     // RIGHT Light
    LineOrientForXib_Left_Dark   = 3,     // RIGHT Dark
    LineOrientForXib_Down_Light  = 4,     // UP Light
    LineOrientForXib_Down_Dark   = 5,     // UP Dark
    LineOrientForXib_Right_Light = 6,     // LEFT Light
    LineOrientForXib_Right_Dark  = 7      // LEFT Dark
};

typedef NS_ENUM(NSInteger,LineOrient) {
    LineOrient_RectUp    = 0,
    LineOrient_RectLeft  = 1,
    LineOrient_RectDown  = 2,
    LineOrient_RectRight = 3
};

@interface SolidLine : UIView

+ (SolidLine*)line:(CGRect)frame orient:(LineOrient)orient color:(UIColor*)color;

@end
