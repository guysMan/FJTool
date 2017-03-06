//
//  FJProgressView.m
//  FJTool
//
//  Created by Jeff on 2017/3/3.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "FJProgressView.h"
#import <QuartzCore/QuartzCore.h>

#define Progress_Background_Color  [UIColor whiteColor]
#define Progress_TintColor         [UIColor blackColor]
#define Border_TintColor           [UIColor blackColor]
#define BorderStrokeWidth          @1

static const CGFloat kBorderWidth = 0.0f;

@interface ProgressLayer : CALayer
@property (nonatomic, strong) UIColor* progressTintColor;
@property (nonatomic, strong) UIColor* borderTintColor;
@property (nonatomic, strong) UIColor* progressBackgroundColor;
@property (nonatomic) CGFloat progress;
@property (nonatomic, strong) NSNumber* kWidth;

@end

@implementation ProgressLayer

@dynamic progressTintColor;
@dynamic borderTintColor;
@dynamic progressBackgroundColor;
@dynamic kWidth;

+ (BOOL)needsDisplayForKey:(NSString *)key
{
    return [key isEqualToString:@"progress"] ? YES : [super needsDisplayForKey:key];
}

- (void)drawInContext:(CGContextRef)context
{
    CGFloat borderW = kBorderWidth;
    if (self.kWidth) {
        borderW = [[self kWidth] floatValue];
    }
    CGRect rect = CGRectInset(self.bounds, borderW, borderW);
    CGFloat radius = CGRectGetHeight(rect) / 2.0f;
    CGContextSetLineWidth(context, borderW);
    CGContextSetStrokeColorWithColor(context, self.borderTintColor.CGColor);
    [self drawRectangleInContext:context inRect:rect withRadius:radius];
    CGContextStrokePath(context);
    
    CGContextSetFillColorWithColor(context, self.progressTintColor.CGColor);
    CGRect progressRect = CGRectInset(rect, 2 * borderW, 2 * borderW);
    CGFloat progressRadius = CGRectGetHeight(progressRect) / 2.0f;
    progressRect.size.width = fmaxf(self.progress * progressRect.size.width, 2.0f * progressRadius);
    [self drawRectangleInContext:context inRect:progressRect withRadius:progressRadius];
    CGContextFillPath(context);
    
    CGContextSetFillColorWithColor(context, self.progressBackgroundColor.CGColor);
    CGRect progressBackgroundRect = progressRect;
    progressBackgroundRect.size.width = rect.size.width - 4 * borderW - progressRect.size.width;
    progressBackgroundRect.origin.x = progressRect.origin.x + progressRect.size.width;
    [self drawProgressBackgroundRectangleInContext:context inRect:progressBackgroundRect withRadius:progressRadius];
    CGContextFillPath(context);
}

- (void)drawRectangleInContext:(CGContextRef)context inRect:(CGRect)rect withRadius:(CGFloat)radius
{
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, rect.origin.x, rect.origin.y + radius);
    CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y + rect.size.height - radius);
    CGContextAddArc(context, rect.origin.x + radius, rect.origin.y + rect.size.height - radius, radius, M_PI, M_PI / 2, 1);
    
    CGContextAddLineToPoint(context, rect.origin.x + rect.size.width - radius, rect.origin.y + rect.size.height);
    CGContextAddArc(context, rect.origin.x + rect.size.width - radius, rect.origin.y + rect.size.height - radius, radius, M_PI / 2, 0.0f, 1);
    
    CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + radius);
    CGContextAddArc(context, rect.origin.x + rect.size.width - radius, rect.origin.y + radius, radius, 0.0f, -M_PI / 2, 1);
    
    CGContextAddLineToPoint(context, rect.origin.x + radius, rect.origin.y);
    CGContextAddArc(context, rect.origin.x + radius, rect.origin.y + radius, radius, -M_PI / 2, -M_PI, 1);
    CGContextClosePath(context);
}

- (void)drawProgressBackgroundRectangleInContext:(CGContextRef)context inRect:(CGRect)rect withRadius:(CGFloat)radius
{
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, rect.origin.x - radius, rect.origin.y);
    CGContextAddArc(context, rect.origin.x - radius, rect.origin.y + radius, radius, 3 * M_PI / 2, 2 * M_PI, 0);
    CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y + rect.size.height - radius);
    
    CGContextAddArc(context, rect.origin.x - radius, rect.origin.y + rect.size.height - radius, radius, 0.0f, M_PI / 2, 0);
    CGContextMoveToPoint(context, rect.origin.x - radius, rect.origin.y + rect.size.height);
    CGContextAddLineToPoint(context, rect.origin.x + rect.size.width - radius, rect.origin.y + rect.size.height);
    
    CGContextAddArc(context, rect.origin.x + rect.size.width - radius, rect.origin.y + rect.size.height - radius, radius, M_PI / 2, 0.0f, 1);
    CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y + radius);
    
    CGContextAddArc(context, rect.origin.x + rect.size.width - radius, rect.origin.y + radius, radius, 2 * M_PI, 3 * M_PI / 2, 1);
    CGContextAddLineToPoint(context, rect.origin.x - radius, rect.origin.y);
    CGContextClosePath(context);
}

@end

@interface FJProgressView()

@property (nonatomic) CGFloat progress;

@property (nonatomic, strong) UIColor* progressBackgroundColor;
@property (nonatomic, strong) UIColor* progressTintColor;
@property (nonatomic, strong) UIColor* borderTintColor;
@property (nonatomic, strong) NSNumber *borderStrokeWidth;

@end

@implementation FJProgressView

- (id)initWithFrame:(CGRect)frame backgroundColor:(UIColor*)backgroundColor progressTintColor:(UIColor*)progressTintColor borderTintColor:(UIColor*)borderTintColor borderStrokeWidth:(NSNumber*)borderStrokeWidth
{
    if (self = [super initWithFrame:frame]) {
        [self initialize];
        [self setProgressBackgroundColor:backgroundColor];
        [self setProgressTintColor:progressTintColor];
        [self setBorderTintColor:borderTintColor];
        [self setBorderStrokeWidth:borderStrokeWidth];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self == [super initWithCoder:aDecoder]) {
        [self initialize];
        [self setProgressBackgroundColor:Progress_Background_Color];
        [self setProgressTintColor:Progress_TintColor];
        [self setBorderTintColor:Border_TintColor];
        [self setBorderStrokeWidth:BorderStrokeWidth];
    }
    return self;
}

- (void)initialize
{
    self.backgroundColor = [UIColor clearColor];
}

- (void)didMoveToWindow
{
    self.progressLayer.contentsScale = self.window.screen.scale;
}

+ (Class)layerClass
{
    return [ProgressLayer class];
}

- (ProgressLayer *)progressLayer
{
    return (ProgressLayer *)self.layer;
}


#pragma mark Getters & Setters

- (CGFloat)progress
{
    return self.progressLayer.progress;
}

- (void)setProgress:(CGFloat)progress
{
    [self setProgress:progress animated:NO];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    [self.progressLayer removeAnimationForKey:@"progress"];
    CGFloat pinnedProgress = MIN(MAX(progress, 0.0f), 1.0f);
    
    if (animated) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"progress"];
        animation.duration = fabsf ( (float)self.progress - (float)pinnedProgress) + 0.1f;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.fromValue = [NSNumber numberWithFloat:self.progress];
        animation.toValue = [NSNumber numberWithFloat:pinnedProgress];
        [self.progressLayer addAnimation:animation forKey:@"progress"];
    }
    else {
        [self.progressLayer setNeedsDisplay];
    }
    
    self.progressLayer.progress = pinnedProgress;
}

- (UIColor *)progressTintColor
{
    return self.progressLayer.progressTintColor;
}

- (void)setProgressTintColor:(UIColor *)progressTintColor
{
    self.progressLayer.progressTintColor = progressTintColor;
    [self.progressLayer setNeedsDisplay];
}

- (UIColor *)borderTintColor
{
    return self.progressLayer.borderTintColor;
}

- (void)setBorderTintColor:(UIColor *)borderTintColor
{
    self.progressLayer.borderTintColor = borderTintColor;
    [self.progressLayer setNeedsDisplay];
}

- (UIColor *)progressBackgroundColor
{
    return self.progressLayer.progressBackgroundColor;
}

- (void)setProgressBackgroundColor:(UIColor *)backgroundColor
{
    self.progressLayer.progressBackgroundColor = backgroundColor;
    [self.progressLayer setNeedsDisplay];
}

- (NSNumber *)borderStrokeWidth {
    return self.progressLayer.kWidth;
}

- (void)setBorderStrokeWidth:(NSNumber *)borderStrokeWidth {
    self.progressLayer.kWidth = borderStrokeWidth;
}

@end
