//
//  AlbumListTableViewCell.h
//  FJTool
//
//  Created by Jeff on 2017/3/2.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumListTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UILabel     *albumNameLabel;
@property (nonatomic, strong) UILabel     *albumDetailLabel;

@end
