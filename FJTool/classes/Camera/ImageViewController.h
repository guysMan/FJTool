//
//  ImageViewController.h
//  FJTool
//
//  Created by Jeff on 2017/3/2.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *clickedView;    // 最好把imageView传过来
@property (nonatomic, strong) UIImage     *image;          // 要查看的图片

@end
