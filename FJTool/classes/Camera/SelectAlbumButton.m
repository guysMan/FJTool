//
//  SelectAlbumButton.m
//  FJTool
//
//  Created by Jeff on 2017/3/2.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "SelectAlbumButton.h"
#import "NSString+Helper.h"

@interface SelectAlbumButton()

@property (nonatomic, weak) IBOutlet UILabel *lb_albumname;

@end

@implementation SelectAlbumButton

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)updateUIConfig:(UIFont*)font textColor:(UIColor*)textColor {
    self.backgroundColor = [UIColor clearColor];
    [self.lb_albumname setTextColor:textColor];
    [self.lb_albumname setFont:font];
}

- (void)updateAlbumName:(NSString*)name {
    self.lb_albumname.text = name;
    [self.lb_albumname sizeToFit];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
