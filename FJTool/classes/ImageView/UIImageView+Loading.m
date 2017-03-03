//
//  UIImageView+Loading.m
//  FJTool
//
//  Created by Jeff on 2017/2/14.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "UIImageView+Loading.h"
#import <objc/runtime.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIColor+Hex.h"
#import "UIView+Layer.h"
#import "NSString+UpaiYun.h"
#import "NSString+Helper.h"
#import "NSArray+Operation.h"
#import "PodHelper.h"

#define DEFAULT_BACKGROUND_COLOR [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.0]
#define ANIMATION_FADEIN (1.0)
static NSMutableArray *errorUrls;

@implementation UIImageView (Loading)

/**
 *  设置图片[头像]
 *  是否圆形，边框尺寸和颜色，ScaleAspectFit，不支持又拍云Url转码
 */
- (void)setAvatarImage:(NSString*)url enableRound:(BOOL)enableRound borderWidth:(CGFloat)borderWidth borderColor:(UIColor*)borderColor {
    [self setImage:url placeholderImageType:PlaceholderImageType_Avatar backgroudColor:nil enableRound:enableRound borderWidth:borderWidth borderColor:borderColor enableUpaiyunTranslation:NO contentMode:UIViewContentModeScaleAspectFit completion:NULL];
}

/**
 *  设置图片[商品图]
 *  ScaleAspectFit
 */
- (void)setProductImage:(NSString*)url {
    [self setProductImgBase:url placeholderImgType:PlaceholderImageType_Logo_Tiny contentMode:UIViewContentModeScaleAspectFit];
}

/**
 *  设置图片[商品图]
 *  ScaleAspectFill
 */
- (void)setProductImageScaleAspectFill:(NSString *)url {
    [self setProductImgBase:url placeholderImgType:PlaceholderImageType_Logo_Tiny contentMode:UIViewContentModeScaleAspectFill];
}

/**
 *  设置图片[商品图]
 *  占位图
 */
- (void)setProductImage:(NSString*)url placeholderImageType:(PlaceholderImageType)placeholderImageType {
    [self setProductImgBase:url placeholderImgType:placeholderImageType contentMode:UIViewContentModeScaleAspectFit];
}

/**
 *  设置图片[商品图]
 *  占位图，ContentMode
 */
- (void)setProductImgBase:(NSString *)url placeholderImgType:(PlaceholderImageType)placeholderImgType contentMode:(UIViewContentMode)contentMode {
    
    __weak typeof(self) weakSelf = self;
    [self setImage:url placeholderImageType:placeholderImgType backgroudColor:nil enableRound:NO borderWidth:0 borderColor:nil enableUpaiyunTranslation:YES contentMode:contentMode completion:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error) {
            
            [weakSelf updateErrorUrl:imageURL];
            [weakSelf sd_setImageWithURL:imageURL completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (error) {
                    [weakSelf setContentMode:UIViewContentModeCenter];
                    weakSelf.image = PLACEHOLDER_IMG_FAILURE_WEAK;
                }else{
                    [weakSelf setImage:image];
                    weakSelf.backgroundColor = [UIColor clearColor];
                    [weakSelf setContentMode:UIViewContentModeScaleAspectFit];
                }
            }];
        }
    }];
}

/**
 *  设置图片[共通]
 *  占位图，ScaleAspectFit
 */
- (void)setCommonImage:(NSString*)url placeholderImageType:(PlaceholderImageType)placeholderImageType {
    [self setImage:url placeholderImageType:placeholderImageType backgroudColor:nil enableRound:NO borderWidth:0 borderColor:nil enableUpaiyunTranslation:NO contentMode:UIViewContentModeScaleAspectFit completion:NULL];
}

/**
 *  设置图片[共通]
 *  ScaleAspectFit
 *  占位图，ScaleAspectFit，背景色
 */
- (void)setCommonImage:(NSString*)url placeholderImageType:(PlaceholderImageType)placeholderImageType backgroudColor:(UIColor*)backgroudColor {
    [self setImage:url placeholderImageType:placeholderImageType backgroudColor:backgroudColor enableRound:NO borderWidth:0 borderColor:nil enableUpaiyunTranslation:NO contentMode:UIViewContentModeScaleAspectFit completion:NULL];
}

/**
 *  设置图片[共通]
 *  占位图，ScaleAspectFill
 */
- (void)setCommonImageScaleAspectFill:(NSString*)url placeholderImageType:(PlaceholderImageType)placeholderImageType {
    [self setImage:url placeholderImageType:placeholderImageType backgroudColor:nil enableRound:NO borderWidth:0 borderColor:nil enableUpaiyunTranslation:NO contentMode:UIViewContentModeScaleAspectFill completion:NULL];
}

/**
 *  设置图片[Base]
 *  占位图，ContentMode，背景色，是否圆形，边框尺寸，边框颜色，是否支持又拍云Url转码，ContentMode，回调
 */
- (void)setImage:(NSString*)url placeholderImageType:(PlaceholderImageType)placeholderImageType backgroudColor:(UIColor*)backgroudColor enableRound:(BOOL)enableRound borderWidth:(CGFloat)borderWidth borderColor:(UIColor*)borderColor enableUpaiyunTranslation:(BOOL)enableUpaiyunTranslation contentMode:(UIViewContentMode)contentMode completion:(SDExternalCompletionBlock)completion {
    
    __weak typeof(self) weakSelf = self;
    if (url == nil || url.length == 0) {
        return;
    }
    
    // 停止动画
    // [self.layer removeAllAnimations];
    
    // 保存Url
    [self setUrl:url];
    
    // Enable Round
    if (enableRound) {
        
        if (borderWidth > 0) {
            [self roundWithBorderWidth:borderWidth borderColor:borderColor];
        }else{
            [self round];
        }
    }
    
    // URL转化
    NSURL *formattedUrl = [self getFinallyUrlWith:url enableTranslate:enableUpaiyunTranslation];
    
    // Background
    [self setClipsToBounds:YES];
    [self.layer setMasksToBounds:YES];
    
    if (backgroudColor) {
        [self setBackgroundColor:backgroudColor];
    }else{
        [self setBackgroundColor:DEFAULT_BACKGROUND_COLOR];
    }
    // Placeholder
    [self setPlaceholder:placeholderImageType];
    
    [self sd_setImageWithURL:formattedUrl placeholderImage:[self getPlaceholderImage:placeholderImageType] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        // ContentMode
        [weakSelf setContentMode:contentMode];
        
        if (![weakSelf isActive:url]) {
            return;
        }
        
        if (error) {
            
            // 失败回调
            if (completion) {
                NSURL *orgImageUrl = [NSURL URLWithString:url];
                completion(image,error,cacheType,orgImageUrl);
            }else{
                // [weakSelf setContentMode:UIViewContentModeCenter];
                // weakSelf.image = PLACEHOLDER_IMG_FAILURE;
            }
            
        }else {
            
            weakSelf.backgroundColor = [UIColor clearColor];
            if (cacheType == SDImageCacheTypeNone) {
                
                // 清空Placeholder
                //[weakSelf setImage:nil];
                [weakSelf setImage:image];
                // 淡入淡出
                weakSelf.alpha = 0.5;
                [weakSelf.layer removeAllAnimations];
                [UIView transitionWithView:weakSelf
                                  duration:ANIMATION_FADEIN
                                   options:UIViewAnimationOptionTransitionCrossDissolve
                                animations:^{
                                    
                                    weakSelf.alpha = 1.0;
                                    
                                } completion:^(BOOL finished) {
                                    
                                }];
            }else{
                
                // 设置图片
                [weakSelf setImage:image];
            }
            
            // 成功回调
            if (completion) {
                completion(image,error,cacheType,imageURL);
            }
        }
        
    }];
}

/** 设置网络图片(Please Use SDWebImage Directly)
 * image : NSString (local, url), UIImage
 * placeholder : placeholder image
 * color : background color
 * rounded : enable/disable round
 * borderwidth : border width (0 disappeared)
 * bordercolor : border color (when borderwidth > 0 enabled)
 * contentmode : content mode
 * completion : calling block after picture loads
 */
- (void)setImage:(id)image placeholder:(PlaceholderImageType)placeholder color:(UIColor*)color rounded:(BOOL)rounded borderwidth:(CGFloat)borderwidth bordercolor:(UIColor*)bordercolor contentmode:(UIViewContentMode)contentmode completion:(void(^)(void))completion {
    
    // TODO
    
}

// private : 支持原网图片地址转化成又拍云URL,已经经过ThumbNail压缩处理
- (NSURL *)getFinallyUrlWith:(NSString *)url enableTranslate:(BOOL)enableTranslated {
    
    NSString *formattedUrl = nil;
    if (enableTranslated) {
        
        if ([errorUrls containsObject:[NSURL URLWithString:url]]) {
            formattedUrl = url;
        } else {
            formattedUrl = [url productImageUrl:[self getThumbNailWidth]];
        }
        
    }else {
        
        if ([url containsString:@"//st-prod"]) { // 是upYun地址, 可拼接参数
            NSString *thumbNail = [url upaiyunThumbnail:[self getThumbNailWidth] quality:75 pictureMetaDataType:[url getPictureMetaDataType]];
            
            if ([url containsStringIgnoreCase:@"!/format/png"]) {
                formattedUrl = [url stringByReplacingOccurrencesOfString:@"!/format/png" withString:thumbNail];
            }else if ([url containsStringIgnoreCase:@"!/format/jpg"]){
                formattedUrl = [url stringByReplacingOccurrencesOfString:@"!/format/jpg" withString:thumbNail];
            }else{
                formattedUrl = [NSString stringWithFormat:@"%@%@",url,thumbNail];
            }
        }else {
            formattedUrl = url;
        }
    }
    
    return [NSURL URLWithString:formattedUrl];
}

// private : 获取placeholder图片
- (UIImage*)getPlaceholderImage:(PlaceholderImageType)placeholderImageType {
    
    UIImage *placeholderImage = nil;
    switch (placeholderImageType) {
            
        case PlaceholderImageType_Avatar:
            placeholderImage = PLACEHOLDER_IMG_AVATAR;
            break;
            
        case PlaceholderImageType_Logo_Large:
            placeholderImage = PLACEHOLDER_IMG_LOGO_LARGE;
            break;
            
        case PlaceholderImageType_Logo_Middle:
            placeholderImage = PLACEHOLDER_IMG_LOGO_MIDDLE;
            break;
            
        case PlaceholderImageType_Logo_Tiny:
            placeholderImage = PLACEHOLDER_IMG_LOGO_TINY;
            break;
            
        case PlaceholderImageType_Loading_WO_Txt:
            placeholderImage = PLACEHOLDER_IMG_LOADING_WO_TXT;
            break;
            
        case PlaceholderImageType_Loading_W_Txt:
            placeholderImage = PLACEHOLDER_IMG_LOADING_W_TXT;
            break;
            
        case PlaceholderImageType_Loading_W_IDCard:
            placeholderImage = PLACEHOLDER_IMG_LOADING_W_IDCARD;
            break;
            
        case PlaceholderImageType_Null:
            placeholderImage = self.image;
        default:
            break;
    }
    return placeholderImage;
}

// private : 设置placeholder
- (void)setPlaceholder:(PlaceholderImageType)placeholderImageType {
    // Placeholder Image
    if (placeholderImageType == PlaceholderImageType_Avatar) {
        [self setContentMode:UIViewContentModeScaleAspectFit];
    }else{
        [self setContentMode:UIViewContentModeCenter];
    }
    UIImage *placeholderImage = [self getPlaceholderImage:placeholderImageType];
    if (placeholderImage) {
        [self setImage:placeholderImage];
    }
}

// private : 获取宽度
- (int)getThumbNailWidth {
    CGFloat w = self.bounds.size.width;
    int multiple = [[UIScreen mainScreen] bounds].size.width == 414 ? 3 : 2;
    if (w >= 350) {
        return 400 * multiple;
    }else if (w >= 250) {
        return 300 * multiple;
    }else if (w >= 150) {
        return 200 * multiple;
    }else if (w >= 50) {
        return 100 * multiple;
    }
    return 50 * multiple;
}

// private : 设置当前url
- (void)setUrl:(NSString*)url {
    objc_setAssociatedObject(self, @"url", url, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// private : 判断当前url是否有效
- (BOOL)isActive:(NSString*)url {
    
    NSString *url_org = objc_getAssociatedObject(self, @"url");
    if (url_org == nil || url_org.length == 0) {
        return YES;
    }
    if ([url_org isEqualToString:url]) {
        return YES;
    }
    
    return NO;
}

// private : 商品图对应的又拍云地址不存在, 保存商品图原址
- (void)updateErrorUrl:(NSURL *)url {
    
    if (!errorUrls) {
        errorUrls = [[NSMutableArray alloc] init];
    }
    if ([errorUrls count] == 25) {
        [errorUrls removeFirstObject];
    }
    if (![errorUrls containsObject:url]) {
        [errorUrls addObject:url];
    }
}

@end
