//
//  NSData+Helper.m
//  FJTool
//
//  Created by Jeff on 2017/2/14.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "NSData+Helper.h"

@implementation NSData (Helper)

// NSData转NSString（DeviceToken）
- (NSString*)toDeviceTokenString {
    if ([self isKindOfClass:[NSData class]]) {
        const unsigned *bytes = [(NSData *)self bytes];
        return [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x", ntohl(bytes[0]), ntohl(bytes[1]), ntohl(bytes[2]), ntohl(bytes[3]), ntohl(bytes[4]), ntohl(bytes[5]), ntohl(bytes[6]), ntohl(bytes[7])];
    } else {
        return [[[[self description] uppercaseString] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]] stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
}

@end
