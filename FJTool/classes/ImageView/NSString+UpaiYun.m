//
//  NSString+UpaiYun.m
//  Demo
//
//  Created by Jeff on 2016/12/22.
//  Copyright © 2016年 Aichen. All rights reserved.
//

#import "NSString+UpaiYun.h"
#import <CocoaSecurity/CocoaSecurity.h>
#import "NSString+Helper.h"

#define UPAIYUN_HOST @"upaiyun.com"
#define HTTP         @"http://"
#define HTTPS        @"https://"

#define ST_PROD_PRODIMAGE_URL @"https://st-prod.b0.upaiyun.com/prodimage/"
#define FORMAT_JPG @"format/jpg"
#define FORMAT_PNG @"format/png"


@implementation NSString (UpaiYun)

/**
 *  商品图片转成又拍云URL
 */
- (NSString *)productImageUrl:(int)viewWidth {
    
    if (![self isUpaiyunUrl]) {
        
        // 原官网图片地址
        NSString *md5Str = [CocoaSecurity md5:self].hex;
        NSString *harfStr = [self _normalizeHost:[md5Str substringToIndex:md5Str.length/2]];
        NSString *thumbNail = [self upaiyunThumbnail:viewWidth quality:75 pictureMetaDataType:PictureMetaDataType_JPG];
        NSString *resultStr = [NSString stringWithFormat:@"%@%@.jpg%@", ST_PROD_PRODIMAGE_URL, harfStr, thumbNail];
        return resultStr;
    
    }else{
        // 又拍云图片地址
        if ([self isFormattedUpaiyunUrl]) {
            // Formatted Already
            return self;
        }else{
            // Need Format
            NSString *thumbNail = [self upaiyunThumbnail:viewWidth quality:75 pictureMetaDataType:[self getPictureMetaDataType]];
            return [NSString stringWithFormat:@"%@%@",self,thumbNail];
        }
    }
}

/**
 *  根据UIImageView的宽度获取又拍云ThumbNail
 */
- (NSString*)upaiyunThumbnail:(int)width quality:(int)quality pictureMetaDataType:(PictureMetaDataType)pictureMetaDataType {
    
    NSString *type = @"jpg";
    if (pictureMetaDataType == PictureMetaDataType_PNG) {
        type = @"png";
    }
    return [NSString stringWithFormat:@"!/fw/%d/quality/%d/format/%@", width, quality, type];
}

/**
 *  是否是加了format格式化的又拍云URL
 */
- (BOOL)isFormattedUpaiyunUrl {
    
    return [self containsStringIgnoreCase:FORMAT_JPG] || [self containsStringIgnoreCase:FORMAT_PNG];
}

/**
 *  获取又拍云图片URL的图片属性
 */
- (PictureMetaDataType)getPictureMetaDataType {

    if ([self containsStringIgnoreCase:FORMAT_PNG]) {
        return PictureMetaDataType_PNG;
    }else if ([self containsStringIgnoreCase:FORMAT_JPG]) {
        return PictureMetaDataType_JPG;
    }
    return PictureMetaDataType_UNKNOWN;
}

/**
 *  是否又拍云图片URL
 */
- (BOOL)isUpaiyunUrl {
    return [self containsStringIgnoreCase:UPAIYUN_HOST];
}

/**
 *  原网图片转又拍云图片URL规则
 */
- (NSString *)_normalizeHost:(NSString*)harf {
    
    const char *c = [harf UTF8String];
    if (strlen(c) >= 2) {
        NSString *replaceChar = nil;
        if (c[0] == '8') {
            replaceChar = @"0";
        }else if (c[0] == '9') {
            replaceChar = @"1";
        }else if (c[0] == 'a' || c[0] == 'A') {
            replaceChar = @"2";
        }else if (c[0] == 'b' || c[0] == 'B') {
            replaceChar = @"3";
        }else if (c[0] == 'c' || c[0] == 'C') {
            replaceChar = @"4";
        }else if (c[0] == 'd' || c[0] == 'D') {
            replaceChar = @"5";
        }else if (c[0] == 'e' || c[0] == 'E') {
            replaceChar = @"6";
        }else if (c[0] == 'f' || c[0] == 'F') {
            replaceChar = @"7";
        }
        
        if (replaceChar) {
            NSString *ret = [NSString stringWithFormat:@"%@%@",replaceChar,[NSString stringWithUTF8String:(c + 1)]];
            return ret;
        }
    }
    return harf;
}

@end
