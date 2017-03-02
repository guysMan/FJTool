//
//  ImageCollectionViewCell.m
//  FJTool
//
//  Created by Jeff on 2017/3/2.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "ImageCollectionViewCell.h"
#import <Masonry/Masonry.h>
#import "PHAsset+Select.h"
#import "FJImageModel.h"
#import "PodHelper.h"

#define  ITEMWIDTH 2 * ([UIScreen mainScreen].bounds.size.width - 4)/3.0

@implementation ImageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    // 图片
    self.imageView = [[UIImageView alloc] init];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    // 选中的背景
    self.selectImageView = [[UIImageView alloc] init];
    self.selectImageView.backgroundColor = [UIColor clearColor];
    UIImage *ch_selectbg_photo = [UIImage imageNamed:@"ch_selectbg_photo"];
    if (ch_selectbg_photo == nil) {
        ch_selectbg_photo = [PodHelper getPodImage:@"ch_selectbg_photo" class:[self class]];
    }
    self.selectImageView.image = ch_selectbg_photo;
    [self.imageView addSubview: self.selectImageView];
    [ self.selectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    // 选中的索引
    self.indexLabel = [[UILabel alloc] init];
    self.indexLabel.textColor = [UIColor blackColor];
    self.indexLabel.font = [UIFont systemFontOfSize:14];
    self.indexLabel.textAlignment = NSTextAlignmentCenter;
    [self.imageView addSubview:self.indexLabel];
    [self.indexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    self.selectImageView.hidden = YES;
    self.indexLabel.hidden = YES;
}

- (void)updteImageIsSelected:(BOOL)imageIsSelected complete:(void(^)(BOOL isFinish))complete;
{
    NSTimeInterval timeIntercal = 0.1;
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:timeIntercal animations:^{
        
        weakSelf.transform = CGAffineTransformMakeScale(1.03, 1.03);
        
    } completion:^(BOOL finished) {
        
        if (finished) {
            [UIView animateWithDuration:timeIntercal animations:^{
                
                weakSelf.transform = CGAffineTransformIdentity;
                
            } completion:complete];
        }
        
    }];
}

- (void)setAsset:(PHAsset *)asset
{
    _asset = asset;
    if (_asset.selected) {
        self.selectImageView.hidden = NO;
        self.indexLabel.hidden = NO;
    }
    else{
        self.selectImageView.hidden = YES;
        self.indexLabel.hidden = YES;
    }
    int count = 0;
    for (FJImageModel *item in self.selectArray) {
        count ++;
        if ([item.asset.localIdentifier isEqualToString:_asset.localIdentifier]) {
            self.indexLabel.text = [NSString stringWithFormat:@"%d",count];
            break;
        }
    }
    if (!_asset.thumbImage) {
        
        __weak typeof(self) weakSelf = self;
        [FJPhotoMgr getImageWithAsset:_asset targetSize:CGSizeMake(ITEMWIDTH,ITEMWIDTH) complete:^(UIImage * image) {
            weakSelf.imageView.image = image;
            _asset.thumbImage = image;
        }];
    }
    else{
        self.imageView.image = _asset.thumbImage;
    }
    
}

@end
