//
//  ImagePreviewtransition.h
//  FJTool
//
//  Created by Jeff on 2017/3/2.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImagePreviewtransition : NSObject<UIViewControllerAnimatedTransitioning>

- (instancetype)initWithClickView:(UIImageView*)imageView;

@end
