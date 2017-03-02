//
//  PHAsset+Select.m
//  FJTool
//
//  Created by Jeff on 2017/3/2.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "PHAsset+Select.h"
#import <objc/runtime.h>

@implementation PHAsset (Select)
static void * PHAssetSelectedKey    = (void *)@"PHAssetSelectedKey";
static void * PHAssetThumbImageKey  = (void *)@"PHAssetThumbImageKey";

- (void)setSelected:(BOOL)selected
{
    objc_setAssociatedObject(self, PHAssetSelectedKey, @(selected), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)selected
{
    return [objc_getAssociatedObject(self, PHAssetSelectedKey) boolValue];
}


- (void)setThumbImage:(UIImage*)thumbImage
{
    objc_setAssociatedObject(self, PHAssetThumbImageKey, thumbImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)thumbImage
{
    return objc_getAssociatedObject(self, PHAssetThumbImageKey);
}

@end
