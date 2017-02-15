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
#define NOTIFY_NETWORK_AVAILABLE                 @"NOTIFY_NETWORK_AVAILABLE"
#define NOTIFY_NETWORK_UNAVAILABLE               @"NOTIFY_NETWORK_UNAVAILABLE"

typedef NS_ENUM(NSInteger, FJNetworkStatus){
    FJNetworkStatus_Unknown,
    FJNetworkStatus_Disconnect,
    FJNetworkStatus_Services,
    FJNetworkStatus_WiFi
};

@interface FJNetworkMgr : NSObject

@end
