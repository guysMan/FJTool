//
//  SelectAlbumButton.h
//  FJTool
//
//  Created by Jeff on 2017/3/2.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectAlbumButton : UIView

- (void)updateUIConfig:(UIFont*)font textColor:(UIColor*)textColor;

- (void)updateAlbumName:(NSString*)name;

@end
