//
//  UIView+DropSheet.m
//  FJTool
//
//  Created by Jeff on 2017/3/6.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "UIView+DropSheet.h"
#import "FJDropSheet.h"

@implementation UIView (DropSheet)

- (void)dropSheet:(NSString*)message {
    [self dropSheet:message tapBlock:nil cancelBlock:nil];
}

- (void)dropSheet:(NSString*)message tapBlock:(void(^)(void))tapBlock cancelBlock:(void(^)(void))cancelBlock {
    FJDropSheet *dropSheet = [[FJDropSheet alloc] initWithMessage:message tapBlock:tapBlock cancelBlock:cancelBlock];
    [dropSheet showInView:self];
}

- (void)dropSheet:(NSString *)message textFont:(UIFont*)textFont textColor:(UIColor*)textColor sheetbackgroundColor:(UIColor*)sheetbackgroundColor closeImageNormal:(UIImage*)closeImageNormal closeImageHighlighted:(UIImage*)closeImageHighlighted stayDuration:(CGFloat)stayDuration tapBlock:(void(^)(void))tapBlock cancelBlock:(void(^)(void))cancelBlock {
    FJDropSheet *dropSheet = [[FJDropSheet alloc] initWithMessage:message
                                                         textFont:textFont
                                                        textColor:textColor
                                             sheetbackgroundColor:sheetbackgroundColor
                                                 closeImageNormal:closeImageNormal
                                            closeImageHighlighted:closeImageHighlighted
                                                     stayDuration:stayDuration
                                                         tapBlock:tapBlock
                                                      cancelBlock:cancelBlock];
    [dropSheet showInView:self];
}

@end
