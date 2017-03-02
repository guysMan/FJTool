//
//  FJImageModel.h
//  FJTool
//
//  Created by Jeff on 2017/3/2.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

typedef NS_ENUM(NSInteger, AlbumType) {
    AlbumTypeDefault   = 0, // 默认
    AlbumTypeCumstom   = 1  // 自定义
};

@interface FJImageModel : NSObject

// 缩略图
@property (nonatomic, strong) UIImage *thumbImage;
@property (nonatomic, strong) PHAsset *asset;

@end
