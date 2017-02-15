//
//  FJUUID.h
//  FJTool
//
//  Created by Jeff on 2017/2/15.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FJUUID : NSObject

// IDFA UUID
+ (NSString*)idfaUUID;

// 设备的UUID
+ (NSString*)deviceUUID;

// 随机UUID
+ (NSString*)randomUUID;

// 随机UUID( + TimeStamp )
+ (NSString*)randomUUIDTimestamp;

@end
