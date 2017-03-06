//
//  FJImageCollectionViewController.h
//  FJTool
//
//  Created by Jeff on 2017/3/2.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@class FJImageModel;

@interface FJImageCollectionViewController : UIViewController

@property (nonatomic, strong) PHFetchResult *assetResult;                                // 相册集合
@property (nonatomic, copy)   void(^okClickComplete)(NSArray<FJImageModel *> *images);   // 回调
@property (nonatomic, assign) NSUInteger maximumNumberOfSelection;                       // 图片的可选数量，默认为9
@property (nonatomic, copy)   NSString *rightItemTitle;                                  // 导航右侧按钮名称
@property (nonatomic, assign) int albumType;                                       // 相册的类型，用途
@property (nonatomic, assign) BOOL isAscend;                                             // 时间升序

@end
