//
//  PodHelper.h
//  FJTool
//
//  Created by Jeff on 2017/3/1.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PodHelper : NSObject

// 获取Pod库Bundle
+ (NSBundle*)getPodBundle:(Class)class;

// 获取Pod库的图片资源
+ (UIImage*)getPodImage:(NSString*)name class:(Class)class;

// 获取Pod库的Bundle资源
+ (NSBundle*)getPodBundleFile:(NSString*)name class:(Class)class;

// 获取Pod库的资源完整路径
+ (NSString*)getOtherResourcePath:(NSString*)name type:(NSString*)type class:(Class)class;

@end
