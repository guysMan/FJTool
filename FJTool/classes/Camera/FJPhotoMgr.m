//
//  FJPhotoMgr.m
//  FJTool
//
//  Created by Jeff on 2017/3/2.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "FJPhotoMgr.h"
#import "PHAsset+Select.h"
#import "UIImage+Clip.h"

@implementation FJPhotoMgr

static FJPhotoMgr *SINGLETON = nil;
static bool isFirstAccess = YES;

#pragma mark - Public Method

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        SINGLETON = [[super allocWithZone:NULL] init];
    });
    return SINGLETON;
}

#pragma mark - Life Cycle

+ (id) allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copy
{
    return [[FJPhotoMgr alloc] init];
}

- (id)mutableCopy
{
    return [[FJPhotoMgr alloc] init];
}

- (id) init
{
    if(SINGLETON){
        return SINGLETON;
    }
    if (isFirstAccess) {
        [self doesNotRecognizeSelector:_cmd];
    }
    self = [super init];
    // Load Data At First
    return self;
}

/**
 * 获取相册列表
 */
+ (void)getAlbumListWithAscend:(BOOL)isAscend complete:(void(^)(NSArray<PHFetchResult *> *albumList))complete
{
    PHFetchOptions * allPhotosOptions = [[PHFetchOptions alloc] init];
    allPhotosOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:isAscend]];
    //所有图片的集合
    PHFetchResult * allPhotos = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:allPhotosOptions];
    //自定义的
    PHFetchOptions *option = [[PHFetchOptions alloc] init];
    option.predicate = [NSPredicate predicateWithFormat:@"estimatedAssetCount > 0"];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"startDate" ascending:YES];
    option.sortDescriptors = @[sortDescriptor];
    PHFetchResult *result = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:option];
    NSArray *list = @[allPhotos,result];
    complete ? complete(list) : nil;
}

/**
 * 通过 asset  获取 imageData
 * @param asset asset
 * @param complete image 压缩后的图片 / HDImage 高清图 原图
 */
+ (void)getImageDataWithAsset:(PHAsset *)asset complete:(void (^)(UIImage *,UIImage*))complete
{
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    option.synchronous = YES;
    [[PHImageManager defaultManager] requestImageDataForAsset:asset options:option resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
        UIImage *HDImage = [UIImage imageWithData:imageData];
        UIImage *image = [UIImage clipImage:HDImage];
        complete?complete(image,HDImage):nil;
    }];
}

/**
 * 获取指定大小的图片
 * @param asset asset
 * @param size size
 * @param complete callback
 */
+ (void)getImageWithAsset:(PHAsset*)asset targetSize:(CGSize)size complete:(void (^)(UIImage *))complete{
    PHImageManager *imageManager = [PHImageManager defaultManager];
    [imageManager requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                complete?complete(result):nil;
            });
        });
    }];
}

/**
 * 是否开启相册权限
 * @return yes or no
 */
+ (BOOL)isOpenAuthority
{
    return [PHPhotoLibrary authorizationStatus] != PHAuthorizationStatusDenied;
}

/**
 * 跳转到设置界面
 */
+ (void)jumpToSetting {
#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED) && __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_10_0
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{UIApplicationOpenURLOptionsOpenInPlaceKey:@"1"} completionHandler:nil];
#else
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
#endif
}

/**
 * 弹框
 *
 * @param title 标题
 * @param message 消息
 * @param controller 控制器
 * @param isSingle 是否是单个选择
 */
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message showController:(UIViewController *)controller isSingleAction:(BOOL)isSingle complete:(void (^)(NSInteger))complete {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        complete?complete(0):nil;
    }];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        complete?complete(1):nil;
    }];
    if (!isSingle) {
        [alertController addAction:cancleAction];
    }
    [alertController addAction:confirmAction];
    [controller presentViewController:alertController animated:YES completion:nil];
}

@end
