//
//  UIImageView+Loading.h
//  FJTool
//
//  Created by Jeff on 2017/2/14.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/SDWebImageManager.h>

typedef NS_ENUM(NSInteger, PlaceholderImageType)
{
    PlaceholderImageType_Null,
    PlaceholderImageType_Avatar,
    PlaceholderImageType_Logo_Large,
    PlaceholderImageType_Logo_Middle,
    PlaceholderImageType_Logo_Tiny,
    PlaceholderImageType_Loading_WO_Txt,
    PlaceholderImageType_Loading_W_Txt,
    PlaceholderImageType_Loading_W_IDCard,
};

#define PLACEHOLDER_IMG_AVATAR             [PodHelper getPodImage:@"placeholder_avatar" class:[self class]]
#define PLACEHOLDER_IMG_LOGO_LARGE         [PodHelper getPodImage:@"placeholder_logo_large" class:[self class]]
#define PLACEHOLDER_IMG_LOGO_MIDDLE        [PodHelper getPodImage:@"placeholder_logo_middle" class:[self class]]
#define PLACEHOLDER_IMG_LOGO_TINY          [PodHelper getPodImage:@"placeholder_logo_tiny" class:[self class]]
#define PLACEHOLDER_IMG_LOADING_WO_TXT     [PodHelper getPodImage:@"placeholder_loading_wo_txt" class:[self class]]
#define PLACEHOLDER_IMG_LOADING_W_TXT      [PodHelper getPodImage:@"placeholder_loading_w_txt" class:[self class]]
#define PLACEHOLDER_IMG_LOADING_W_IDCARD   [PodHelper getPodImage:@"placeholder_loading_w_idcard" class:[self class]]
#define PLACEHOLDER_IMG_FAILURE            [PodHelper getPodImage:@"placeholder_failure" class:[self class]]

#define PLACEHOLDER_IMG_AVATAR_WEAK             [PodHelper getPodImage:@"placeholder_avatar" class:[weakSelf class]]
#define PLACEHOLDER_IMG_LOGO_LARGE_WEAK         [PodHelper getPodImage:@"placeholder_logo_large" class:[weakSelf class]]
#define PLACEHOLDER_IMG_LOGO_MIDDLE_WEAK        [PodHelper getPodImage:@"placeholder_logo_middle" class:[weakSelf class]]
#define PLACEHOLDER_IMG_LOGO_TINY_WEAK          [PodHelper getPodImage:@"placeholder_logo_tiny" class:[weakSelf class]]
#define PLACEHOLDER_IMG_LOADING_WO_TXT_WEAK     [PodHelper getPodImage:@"placeholder_loading_wo_txt" class:[weakSelf class]]
#define PLACEHOLDER_IMG_LOADING_W_TXT_WEAK      [PodHelper getPodImage:@"placeholder_loading_w_txt" class:[weakSelf class]]
#define PLACEHOLDER_IMG_LOADING_W_IDCARD_WEAK   [PodHelper getPodImage:@"placeholder_loading_w_idcard" class:[weakSelf class]]
#define PLACEHOLDER_IMG_FAILURE_WEAK            [PodHelper getPodImage:@"placeholder_failure" class:[weakSelf class]]

@interface UIImageView (Loading)

/**
 *  设置图片[头像]
 *  是否圆形，边框尺寸和颜色，ScaleAspectFit，不支持又拍云Url转码
 */
- (void)setAvatarImage:(NSString*)url enableRound:(BOOL)enableRound borderWidth:(CGFloat)borderWidth borderColor:(UIColor*)borderColor;

/**
 *  设置图片[商品图]
 *  ScaleAspectFit
 */
- (void)setProductImage:(NSString*)url;

/**
 *  设置图片[商品图]
 *  ScaleAspectFill
 */
- (void)setProductImageScaleAspectFill:(NSString *)url;

/**
 *  设置图片[商品图]
 *  占位图
 */
- (void)setProductImage:(NSString*)url placeholderImageType:(PlaceholderImageType)placeholderImageType;

/**
 *  设置图片[商品图]
 *  占位图，ContentMode
 */
- (void)setProductImgBase:(NSString *)url placeholderImgType:(PlaceholderImageType)placeholderImgType contentMode:(UIViewContentMode)contentMode;

/**
 *  设置图片[共通]
 *  占位图，ScaleAspectFit
 */
- (void)setCommonImage:(NSString*)url placeholderImageType:(PlaceholderImageType)placeholderImageType;

/**
 *  设置图片[共通]
 *  ScaleAspectFit
 *  占位图，ScaleAspectFit，背景色
 */
- (void)setCommonImage:(NSString*)url placeholderImageType:(PlaceholderImageType)placeholderImageType backgroudColor:(UIColor*)backgroudColor;

/**
 *  设置图片[共通]
 *  占位图，ScaleAspectFill
 */
- (void)setCommonImageScaleAspectFill:(NSString*)url placeholderImageType:(PlaceholderImageType)placeholderImageType;

/**
 *  设置图片[Base]
 *  占位图，ContentMode，背景色，是否圆形，边框尺寸，边框颜色，是否支持又拍云Url转码，ContentMode，回调
 */
- (void)setImage:(NSString*)url placeholderImageType:(PlaceholderImageType)placeholderImageType backgroudColor:(UIColor*)backgroudColor enableRound:(BOOL)enableRound borderWidth:(CGFloat)borderWidth borderColor:(UIColor*)borderColor enableUpaiyunTranslation:(BOOL)enableUpaiyunTranslation contentMode:(UIViewContentMode)contentMode completion:(SDExternalCompletionBlock)completion;

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
- (void)setImage:(id)image placeholder:(PlaceholderImageType)placeholder color:(UIColor*)color rounded:(BOOL)rounded borderwidth:(CGFloat)borderwidth bordercolor:(UIColor*)bordercolor contentmode:(UIViewContentMode)contentmode completion:(void(^)(void))completion;

@end
