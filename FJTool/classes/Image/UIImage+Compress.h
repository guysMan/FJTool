//
//  UIImage+Compress.h
//  FJTool
//
//  Created by Jeff on 2017/2/14.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Compress)

typedef NS_ENUM(NSInteger, NSPUIImageType)
{
    NSPUIImageType_JPEG,
    NSPUIImageType_PNG,
    NSPUIImageType_Unknown
};

// 压缩图片（指定大小）
- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize;

// 判断图片是JPG还是PNG
+ (NSPUIImageType)NSPUIImageTypeFromData:(NSData *)imageData;

@end
