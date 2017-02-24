//
//  UIImageView+Loading.h
//  FJTool
//
//  Created by Jeff on 2017/2/14.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PlaceholderImageType)
{
    PlaceholderImageType_Null,
    PlaceholderImageType_Logo,
    PlaceholderImageType_Middle_Logo,
    PlaceholderImageType_Tiny_Logo,
    PlaceholderImageType_Avatar,
    PlaceholderImageType_Loading_WO_Txt,
    PlaceholderImageType_Loading_W_Txt,
    PlaceholderImageType_Loading_W_IDCard,
    
};

@interface UIImageView (Loading)

/**
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
