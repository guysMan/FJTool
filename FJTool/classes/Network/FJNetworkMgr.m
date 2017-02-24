//
//  FJNetworkMgr.m
//  FJTool
//
//  Created by Jeff on 2017/2/15.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "FJNetworkMgr.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import "AFNetworking.h"

@interface FJNetworkMgr()

// 网络状态
@property (nonatomic,assign) FJNetworkStatus networkStatus;

@end

@implementation FJNetworkMgr

static FJNetworkMgr *SINGLETON = nil;
static bool isFirstAccess = YES;

#pragma mark - Public Method

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        SINGLETON = [[super allocWithZone:NULL] init];
    });
    
    return SINGLETON;
}

#pragma mark - Life Cycle

+ (id) allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copy
{
    return [[FJNetworkMgr alloc] init];
}

- (id)mutableCopy
{
    return [[FJNetworkMgr alloc] init];
}

- (id) init
{
    if(SINGLETON){
        return SINGLETON;
    }
    if (isFirstAccess) {
        [self doesNotRecognizeSelector:_cmd];
    }
    self = [super init];
    self.networkStatus = FJNetworkStatus_Services;
    // Load Data At First
    [self startNetworkMonitoring];
    // 网络检查未完成时, 默认网络可用
    // self.networkStatus = NetworkStatus_Services;
    return self;
}

- (void)startNetworkMonitoring {
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                // Unknown
                _networkStatus = FJNetworkStatus_Unknown;
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_NETWORK_UNAVAILABLE object:nil userInfo:nil];
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                // Disconnect
                _networkStatus = FJNetworkStatus_Disconnect;
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_NETWORK_UNAVAILABLE object:nil userInfo:nil];
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                // WIFI
                _networkStatus = FJNetworkStatus_WiFi;
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_NETWORK_AVAILABLE object:nil userInfo:nil];
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                // Services Network
                _networkStatus = FJNetworkStatus_Services;
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFY_NETWORK_AVAILABLE object:nil userInfo:nil];
                break;
            default:
                break;
        }
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

+ (void)networkAvailableSuccess:(void(^)(void))success failed:(void(^)(void))failed;
{
    BOOL ret = [FJNetworkMgr networkAvailable];
    if (ret) {
        if (success) {
            success();
        }
    }else{
        if (failed) {
            failed();
        }
    }
}

+ (BOOL)networkAvailable
{
    FJNetworkMgr *instance = [FJNetworkMgr sharedInstance];
    if (instance.networkStatus == FJNetworkStatus_Services) {
        return YES;
    }
    if (instance.networkStatus == FJNetworkStatus_WiFi) {
        return YES;
    }else{
        return NO;
    }
    //#endif
    return YES;
}

+ (FJNetworkStatus)networkStatus
{
    FJNetworkMgr *instance = [FJNetworkMgr sharedInstance];
    return instance.networkStatus;
}

+ (NSString *)WiFiName
{
    NSString *wifiName = nil;
    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
    
    if (!wifiInterfaces) {
        return nil;
    }
    
    NSArray *interfaces = (__bridge NSArray *)wifiInterfaces;
    
    for (NSString *interfaceName in interfaces) {
        CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
        
        if (dictRef) {
            NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;
            // NSLog(@"network info -> %@", networkInfo);
            wifiName = [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeySSID];
            
            CFRelease(dictRef);
        }
    }
    
    CFRelease(wifiInterfaces);
    return wifiName;
}

@end
