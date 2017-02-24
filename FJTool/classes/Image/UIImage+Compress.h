//
//  UIImage+Compress.h
//  FJTool
//
//  Created by Jeff on 2017/2/14.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Compress)

// 压缩图片（指定大小）
- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize;

@end
