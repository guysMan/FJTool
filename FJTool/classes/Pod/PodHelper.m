//
//  PodHelper.m
//  FJTool
//
//  Created by Jeff on 2017/3/1.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "PodHelper.h"
#import "Macro.h"

@implementation PodHelper

// 获取Pod库Bundle
+ (NSBundle*)getPodBundle:(Class)class
{
    NSBundle *bundle = [NSBundle bundleForClass:class];
    return bundle;
}

// 获取Pod库的图片资源
+ (UIImage*)getPodImage:(NSString*)name class:(Class)class
{
    UIImage *image = [[UIImage imageWithContentsOfFile:[[self getPodBundle:class] pathForResource:name ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAutomatic];
    
    if (image == nil) {
        NSString *resourceName = nil;
        if ([[UIScreen mainScreen] bounds].size.width == 414) {
            
            // 3倍图
            resourceName = [NSString stringWithFormat:@"%@@3x",name];
            if (image == nil) {
                resourceName = [NSString stringWithFormat:@"%@@2x",name];
            }
        }else{
            
            // 2倍图
            resourceName = [NSString stringWithFormat:@"%@@2x",name];
        }
        
        image = [[UIImage imageWithContentsOfFile:[[self getPodBundle:class] pathForResource:resourceName ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAutomatic];
        
    }
    
    return image;
}

// 获取Pod库的Bundle资源
+ (NSBundle*)getPodBundleFile:(NSString*)name class:(Class)class {
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:class] pathForResource:name ofType:@"bundle"]];
    return bundle;
}

// 获取Pod库的资源完整路径
+ (NSString*)getOtherResourcePath:(NSString*)name type:(NSString*)type class:(Class)class {
    return [[self getPodBundle:class] pathForResource:name ofType:type];
}

@end
