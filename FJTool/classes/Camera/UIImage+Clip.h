//
//  UIImage+Clip.h
//  FJTool
//
//  Created by Jeff on 2017/3/2.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Clip)

//  压缩图片
-(UIImage *) imageCompressForTargetSize:(CGSize)size;
// 压缩到指定大小
+ (UIImage *)clipImage:(UIImage*)image;

@end
