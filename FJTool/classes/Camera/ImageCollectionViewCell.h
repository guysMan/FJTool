//
//  ImageCollectionViewCell.h
//  FJTool
//
//  Created by Jeff on 2017/3/2.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FJPhotoMgr.h"

@interface ImageCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *selectImageView;
@property (nonatomic, strong) UILabel *indexLabel;
@property (nonatomic, strong) PHAsset *asset;
@property (nonatomic, strong) NSMutableArray *selectArray;

- (void)updteImageIsSelected:(BOOL)imageIsSelected complete:(void(^)(BOOL isFinish))complete;

@end
