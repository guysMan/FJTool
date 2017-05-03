//
//  NSArray+JSONModel.m
//  FJTool
//
//  Created by Jeff on 2017/5/3.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "NSArray+JSONModel.h"
#import <JSONModel/JSONModel.h>

@implementation NSArray (JSONModel)

- (NSString*)toJSONString {
    
    if ([self count] == 0) {
        return nil;
    }
    
    NSMutableString *ret = [[NSMutableString alloc] initWithString:@"["];
    for (int i = 0; i < self.count; i++) {
        JSONModel *obj = [self objectAtIndex:i];
        if ([obj respondsToSelector:@selector(toJSONString)]) {
            if (i == self.count - 1) {
                [ret appendFormat:@"%@]",[obj toJSONString]];
            }else{
                [ret appendFormat:@"%@,",[obj toJSONString]];
            }
            
        }else{
            assert(@"Please make sure the array must contain JSONModel-based object");
        }
    }
    return ret;
}

@end
