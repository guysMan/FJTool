//
//  FJAlbumListViewController.h
//  FJTool
//
//  Created by Jeff on 2017/3/2.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FJImageModel.h"

@interface FJAlbumListViewController : UIViewController

@property (nonatomic, copy) void(^okClickComplete)(NSArray<FJImageModel *> *images);    // 回调
@property (nonatomic, copy) NSString *rightTitle;                                       // 导航右侧按钮名称
@property (nonatomic,assign) NSInteger maxSelectCount;                                  // 可选的最大数量
@property (nonatomic,assign) AlbumType albumType;                                       // 相册的类型，用途
@property (nonatomic,assign) BOOL isAscend;                                             // 是否是升序， 相机的位置是顶部还是底部，默认降序 顶部(NO)

@end
