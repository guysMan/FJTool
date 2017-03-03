//
//  SolidLine.m
//  baijie
//
//  Created by Fu Jie on 16/3/24.
//  Copyright © 2016年 Aichen. All rights reserved.
//

#import "SolidLine.h"

#define COLOR_SOLID_LINE_204 [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.69]
#define COLOR_SOLID_LINE_230 [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.25]

@interface SolidLine()

@property (strong, nonatomic) CAGradientLayer *gradientLayer;

@end

@implementation SolidLine

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        LineOrientForXib orientXib = self.tag;
        
        UIColor *color = COLOR_SOLID_LINE_204;
        if (orientXib == LineOrientForXib_Up_Light || orientXib == LineOrientForXib_Left_Light || orientXib == LineOrientForXib_Down_Light || orientXib == LineOrientForXib_Right_Light) {
            color = COLOR_SOLID_LINE_230;
        }
        
        //初始化渐变层
        self.gradientLayer = [CAGradientLayer layer];
        self.gradientLayer.frame = self.bounds;
        [self.layer addSublayer:self.gradientLayer];
        
        switch (orientXib) {
            case LineOrientForXib_Up_Light:
            case LineOrientForXib_Up_Dark:
            {
                //设定颜色组
                self.gradientLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor,
                                              (__bridge id)color.CGColor
                                              ];
                //设置渐变颜色方向
                self.gradientLayer.startPoint = CGPointMake(0, 0);
                self.gradientLayer.endPoint =   CGPointMake(0, 1);
                //设定颜色分割点
                self.gradientLayer.locations = @[@(0.5) ,@(1.0f)];
            }
                break;
                
            case LineOrientForXib_Down_Light:
            case LineOrientForXib_Down_Dark:
            {
                //设定颜色组
                self.gradientLayer.colors = @[(__bridge id)color.CGColor,
                                              (__bridge id)[UIColor clearColor].CGColor
                                              ];
                //设置渐变颜色方向
                self.gradientLayer.startPoint = CGPointMake(0, 0);
                self.gradientLayer.endPoint =   CGPointMake(0, 1);
                //设定颜色分割点
                self.gradientLayer.locations = @[@(0.0) ,@(0.5f)];
            }
                break;
                
            case LineOrientForXib_Left_Light:
            case LineOrientForXib_Left_Dark:
            {
                //设定颜色组
                self.gradientLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor,
                                              (__bridge id)color.CGColor
                                              ];
                //设置渐变颜色方向
                self.gradientLayer.startPoint = CGPointMake(0, 0);
                self.gradientLayer.endPoint =   CGPointMake(1, 0);
                //设定颜色分割点
                self.gradientLayer.locations = @[@(0.5) ,@(1.0f)];
            }
                break;
                
            case LineOrientForXib_Right_Light:
            case LineOrientForXib_Right_Dark:
            {
                //设定颜色组
                self.gradientLayer.colors = @[(__bridge id)color.CGColor,
                                              (__bridge id)[UIColor clearColor].CGColor,
                                              ];
                //设置渐变颜色方向
                self.gradientLayer.startPoint = CGPointMake(0, 0);
                self.gradientLayer.endPoint =   CGPointMake(1, 0);
                //设定颜色分割点
                self.gradientLayer.locations = @[@(0.0) ,@(0.5f)];
            }
                break;
                
            default:
                break;
        }
        
        
        self.backgroundColor = [UIColor clearColor];
        self.tintColor = [UIColor clearColor];
        
    }
    return self;
}

- (void)layoutSubviews {
    self.gradientLayer.frame = self.bounds;
}

+ (SolidLine*)line:(CGRect)frame orient:(LineOrient)orient color:(UIColor*)color{
    SolidLine *line = [[SolidLine alloc] initWithFrame:frame];
    line.backgroundColor = [UIColor clearColor];
    
    //初始化渐变层
    line.gradientLayer = [CAGradientLayer layer];
    line.gradientLayer.frame = line.bounds;
    [line.layer addSublayer:line.gradientLayer];
    
    switch (orient) {
        case LineOrient_RectUp:
        {
            //设定颜色组
            line.gradientLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor,
                                          (__bridge id)color.CGColor
                                          ];
            //设置渐变颜色方向
            line.gradientLayer.startPoint = CGPointMake(0, 0);
            line.gradientLayer.endPoint =   CGPointMake(0, 1);
            //设定颜色分割点
            line.gradientLayer.locations = @[@(0.5) ,@(1.0f)];
        }
            break;
            
        case LineOrient_RectDown:
        {
            //设定颜色组
            line.gradientLayer.colors = @[(__bridge id)color.CGColor,
                                          (__bridge id)[UIColor clearColor].CGColor
                                          ];
            //设置渐变颜色方向
            line.gradientLayer.startPoint = CGPointMake(0, 0);
            line.gradientLayer.endPoint =   CGPointMake(0, 1);
            //设定颜色分割点
            line.gradientLayer.locations = @[@(0.0) ,@(0.5f)];
        }
            break;
            
        case LineOrient_RectLeft:
        {
            //设定颜色组
            line.gradientLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor,
                                          (__bridge id)color.CGColor
                                          ];
            //设置渐变颜色方向
            line.gradientLayer.startPoint = CGPointMake(0, 0);
            line.gradientLayer.endPoint =   CGPointMake(1, 0);
            //设定颜色分割点
            line.gradientLayer.locations = @[@(0.5) ,@(1.0f)];
        }
            break;
            
        case LineOrient_RectRight:
        {
            //设定颜色组
            line.gradientLayer.colors = @[(__bridge id)color.CGColor,
                                          (__bridge id)[UIColor clearColor].CGColor,
                                          ];
            //设置渐变颜色方向
            line.gradientLayer.startPoint = CGPointMake(0, 0);
            line.gradientLayer.endPoint =   CGPointMake(1, 0);
            //设定颜色分割点
            line.gradientLayer.locations = @[@(0.0) ,@(0.5f)];
        }
            break;
            
        default:
            break;
    }
    
    return line;
}

@end

