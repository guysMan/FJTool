//
//  FJNetworkMgr.h
//  FJTool
//
//  Created by Jeff on 2017/2/15.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 网络状态发生变化
 **/
#define FJ_NOTIFY_NETWORK_AVAILABLE                 @"FJ_NOTIFY_NETWORK_AVAILABLE"
#define FJ_NOTIFY_NETWORK_UNAVAILABLE               @"FJ_NOTIFY_NETWORK_UNAVAILABLE"

typedef NS_ENUM(NSInteger, FJNetworkStatus){
    FJNetworkStatus_Unknown,
    FJNetworkStatus_Disconnect,
    FJNetworkStatus_Services,
    FJNetworkStatus_WiFi
};

@interface FJNetworkMgr : NSObject

// 单例
+ (id)sharedInstance;

// 开启监视网络
- (void)startNetworkMonitoring;

// 是否有网络(带block)
+ (void)networkAvailableSuccess:(void(^)(void))success failure:(void(^)(void))failure;

// 是否有网络
+ (BOOL)networkAvailable;

// 网络状态
+ (FJNetworkStatus)networkStatus;

// 获取WIFI的名称
+ (NSString *)WiFiName;

@end
