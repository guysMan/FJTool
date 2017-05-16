//
//  CountryTableViewCell.m
//  FJTool
//

#import "CountryTableViewCell.h"

@implementation CountryTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    [self layoutIfNeeded];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

