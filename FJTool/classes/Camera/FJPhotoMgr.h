//
//  FJPhotoMgr.h
//  FJTool
//
//  Created by Jeff on 2017/3/2.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@interface FJPhotoMgr : NSObject

+ (id)sharedInstance;

/**
 * 获取相册列表
 */
+ (void)getAlbumListWithAscend:(BOOL)isAscend complete:(void(^)(NSArray<PHFetchResult *> *albumList))complete;

/**
 * 通过 asset  获取 imageData
 * @param asset asset
 * @param complete image 压缩后的图片 / HDImage 高清图 原图
 */
+ (void)getImageDataWithAsset:(PHAsset*)asset complete:(void(^)(UIImage*image,UIImage *HDImage))complete;

/**
 * 获取指定大小的图片
 * @param asset asset
 * @param size size
 * @param complete callback
 */
+ (void)getImageWithAsset:(PHAsset*)asset targetSize:(CGSize)size complete:(void (^)(UIImage *))complete;

/**
 * 是否开启相册权限
 * @return yes or no
 */
+ (BOOL)isOpenAuthority;

/**
 * 跳转到设置界面
 */
+ (void)jumpToSetting;

/**
 * 弹框
 *
 * @param title 标题
 * @param message 消息
 * @param controller 控制器
 * @param isSingle 是否是单个选择
 */
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message showController:(UIViewController *)controller isSingleAction:(BOOL)isSingle complete:(void (^)(NSInteger))complete;

@end
