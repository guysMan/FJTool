//
//  NSString+UpaiYun.h
//  Demo
//
//  Created by Jeff on 2016/12/22.
//  Copyright © 2016年 Aichen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, PictureMetaDataType) {
    PictureMetaDataType_UNKNOWN,
    PictureMetaDataType_JPG,
    PictureMetaDataType_PNG
};

@interface NSString (UpaiYun)

/**
 *  将图片转成又拍云URL格式（特殊处理）
 */
- (NSString *)productImageUrl:(int)viewWidth;

/**
 *  根据UIImageView的宽度获取又拍云ThumbNail
 */
- (NSString*)upaiyunThumbnail:(int)width quality:(int)quality pictureMetaDataType:(PictureMetaDataType)pictureMetaDataType;

/**
 *  是否是加了format格式化的又拍云URL
 */
- (BOOL)isFormattedUpaiyunUrl;

/**
 *  获取又拍云图片URL的图片属性
 */
- (PictureMetaDataType)getPictureMetaDataType;

/**
 *  是否又拍云图片URL
 */
- (BOOL)isUpaiyunUrl;

/**
 *  原网图片转又拍云图片URL规则
 */
- (NSString *)_normalizeHost:(NSString*)harf;

@end
