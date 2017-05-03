//
//  FJImage.h
//  FJTool
//
//  Created by Jeff on 2017/2/14.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FJImage : NSObject

// 获得图片（指定区域）
+(UIImage *)fetchImage:(UIImage *)image rect:(CGRect)rect;

// 裁剪图片（指定区域）
+ (UIImage*)cropImage:(UIImage*)image rect:(CGRect)rect sameration:(BOOL)sameratio;

// 缩放图片（等比率）
+ (UIImage *)scaleImage:(UIImage *)image scale:(float)scale;

// 调整图片（自定义长宽）
+ (UIImage *)adjustImage:(UIImage *)image size:(CGSize)size;

// 截图UIView（对每个继承自UIView的对象都适用）
+ (UIImage*)captureView:(UIView *)theView;

// 截屏（指定UIView，正方形，无损）
+ (UIImage*)captureSquareView:(UIView *)squareView rect:(CGSize)rect;

// 截屏（全屏）
+ (UIImage*)captureScreen:(UIViewController *)viewController;

// Convert to CGImage
+ (CGImageRef)convertToCGImageFromUIImage:(UIImage*)image;

// Convert to UIImage
+ (UIImage*)convertToUIImageFrom:(CGImageRef)imageRef;

// 压缩图片
+ (NSData*)compressImage:(UIImage *)image lessThan:(NSUInteger)mbyte;

@end
