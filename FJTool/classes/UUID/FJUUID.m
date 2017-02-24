//
//  FJUUID.m
//  FJTool
//
//  Created by Jeff on 2017/2/15.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "FJUUID.h"
#import <UIKit/UIKit.h>
#import <AdSupport/AdSupport.h>

@implementation FJUUID

// IDFA UUID
+ (NSString*)idfaUUID {
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
}

// 设备的UUID
+ (NSString*)deviceUUID {
    UIDevice *myDevice = [UIDevice currentDevice];
    NSString *deviceUDID = [[myDevice identifierForVendor] UUIDString];
    return deviceUDID;
}

// 随机UUID
+ (NSString*)randomUUID {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}

// 随机UUID( + TimeStamp )
+ (NSString*)randomUUIDTimestamp {
    NSDate *dateNow = [NSDate date];
    long long now = (long long)[dateNow timeIntervalSince1970];
    return [NSString stringWithFormat:@"%@_%lld", [self randomUUID], now];
}

@end
