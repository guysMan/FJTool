//
//  FJImage.m
//  FJTool
//
//  Created by Jeff on 2017/2/14.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "FJImage.h"

@implementation FJImage

// 获得图片（指定区域）
+(UIImage *)fetchImage:(UIImage *)image rect:(CGRect)rect
{
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    CGImageRelease(newImageRef);
    return newImage;
}

// 裁剪图片（指定区域）
+ (UIImage*)cropImage:(UIImage*)image rect:(CGRect)rect sameration:(BOOL)sameratio
{
    if (sameratio) {
        
        CGRect myImageRect = rect;
        float cropRatio = rect.size.width / rect.size.height;
        float imageRatio = image.size.width / image.size.height;
        if (cropRatio == imageRatio) {
            return image;
        }else if (cropRatio > imageRatio) {
            // 裁剪高度
            CGFloat width = image.size.width;
            CGFloat height = image.size.width * cropRatio;
            CGFloat x = image.size.width * ( rect.size.width / image.size.width );
            CGFloat y = image.size.height * ( rect.size.width / image.size.width );
            myImageRect = CGRectMake(x, y, width, height);
            
        }else {
            // 裁剪宽度
            CGFloat height = image.size.height;
            CGFloat width = image.size.height / cropRatio;
            CGFloat x = image.size.width * ( rect.size.width / image.size.width );
            CGFloat y = image.size.height * ( rect.size.width / image.size.width );
            myImageRect = CGRectMake(x, y, width, height);
        }
        
        CGImageRef imageRef = image.CGImage;
        CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, myImageRect);
        return [UIImage imageWithCGImage:subImageRef];
        
    }else{
        
        CGRect myImageRect = rect;
        UIImage* bigImage= image;
        CGImageRef imageRef = bigImage.CGImage;
        CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, myImageRect);
        
        CGSize size;
        size.width = rect.size.width;
        size.height = rect.size.height;
        UIGraphicsBeginImageContext(size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextDrawImage(context, myImageRect, subImageRef);
        UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
        UIGraphicsEndImageContext();
        return smallImage;
        
    }
}

// 缩放图片（等比率）
+ (UIImage *)scaleImage:(UIImage *)image scale:(float)scale
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scale, image.size.height * scale));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scale, image.size.height * scale)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

// 调整图片（自定义长宽）
+ (UIImage *)adjustImage:(UIImage *)image size:(CGSize)size
{
    UIGraphicsBeginImageContext(CGSizeMake(size.width, size.height));
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}

// 截图UIView（对每个继承自UIView的对象都适用）
+ (UIImage*)captureView:(UIView *)theView
{
    CGRect rect = theView.frame;
    //UIGraphicsBeginImageContext(rect.size);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

// 截屏（指定UIView，正方形，无损）
+ (UIImage*)captureSquareView:(UIView *)squareView rect:(CGSize)rect
{
    CGRect squareViewrect = squareView.frame;
    CGFloat max = rect.height >= rect.width ? rect.height : rect.width;
    squareViewrect.size.width = max;
    squareViewrect.size.height = max;
    
    //UIGraphicsBeginImageContext(rect.size);
    UIGraphicsBeginImageContextWithOptions(squareViewrect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [squareView.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

// 截屏（全屏）
+ (UIImage*)captureScreen:(UIViewController *)viewController{
    CGRect rect = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    //    UIGraphicsBeginImageContext(rect.size);
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, 2.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [viewController.navigationController.view.layer renderInContext:context];
    //[view.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

// Convert to CGImage
+ (CGImageRef)convertToCGImageFromUIImage:(UIImage*)image
{
    return image.CGImage;
}

// Convert to UIImage
+ (UIImage*)convertToUIImageFrom:(CGImageRef)imageRef
{
    return [UIImage imageWithCGImage:imageRef];
}

// 压缩图片
+ (NSData*)compressImage:(UIImage *)image lessThan:(NSUInteger)mbyte {
    
    if (image == nil) {
        return nil;
    }
    
    NSData *imgData = UIImageJPEGRepresentation(image, 1);
    if (mbyte == 0) {
        return imgData;
    }
    
    CGFloat compressedRate = 0.0;
    NSUInteger mbytes = 1024 * 1024;
    
    if (imgData.length >= 30 * mbytes) {
        compressedRate = 0.05 * mbyte;
        
    }else if (imgData.length >= 20 * mbytes) {
        compressedRate = 0.2 * mbyte;
        
    }else if (imgData.length >= 10 * mbytes) {
        compressedRate = 0.4 * mbyte;
        
    }else if (imgData.length >= 5 * mbytes) {
        compressedRate = 0.5 * mbyte;
        
    }else if (imgData.length >= 4 * mbytes) {
        compressedRate = 0.6 * mbyte;
        
    }else if (imgData.length >= 3 * mbytes) {
        compressedRate = 0.7 * mbyte;
        
    }else if (imgData.length >= 2 * mbytes) {
        compressedRate = 0.9 * mbyte;
        
    }else if (imgData.length > 1 * mbytes) {
        compressedRate = 0.99 * mbyte;
        
    }else {
        
        compressedRate = 1.0;
        
    }
    
    NSData *compressedData = UIImageJPEGRepresentation(image, compressedRate);
    return compressedData;
}

@end
