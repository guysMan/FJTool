//
//  HorizontalDotLine.m
//  FJTool
//
//  Created by Jeff on 2017/3/3.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "HorizontalDotLine.h"
#import <QuartzCore/QuartzCore.h>

#define Line_Color [UIColor colorWithRed:(230.0 / 255.0) green:(230.0 / 255.0) blue:(230.0 / 255.0) alpha:1.0]

@implementation HorizontalDotLine

- (id)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        /* self.lineColor = self.backgroundColor; */
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        /* self.lineColor = self.backgroundColor; */
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    
    CGFloat w = self.bounds.size.width;
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetShouldAntialias(context, NO);
    CGContextSetLineWidth(context, 0.1);
    CGContextSetStrokeColorWithColor(context, Line_Color.CGColor);
    CGFloat lengths[] = {3,2};
    CGContextSetLineDash(context, 0, lengths,2);
    CGContextMoveToPoint(context, 0, 0.9);
    CGContextAddLineToPoint(context, w, 0.9);
    CGContextStrokePath(context);
    
}

@end
