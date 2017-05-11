//
//  FJAppRedirect.m
//  FJTool
//
//  Created by Jeff on 2017/2/15.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "FJAppRedirect.h"
#import <UIKit/UIKit.h>

#define APPSTORE_PREFIX              @"itms-apps://itunes.apple.com/"
#define APPSTORE_MARKET_CN           @"cn"
#define APPSTORE_MARKET_USA          @"us"
#define APPSTORE_SUFFIX(id)          [NSString stringWithFormat:@"/app/id%@?mt=8",id]

#define APPSTORE_ID_WWHT_GWZG        @"1110651940"
#define APPSTORE_ID_WECHAT           @"414478124"
#define APPSTORE_ID_QQ               @"444934666"
#define APPSTORE_ID_SINAWeibo        @"350962117"
#define APPSTORE_ID_Alipay           @"333206289"

#define APPSTORE_APP(market, id)     [NSString stringWithFormat:@"%@%@%@", APPSTORE_PREFIX, market, APPSTORE_SUFFIX(id)]
#define APPSTORE_DEFAULT_URL         @"itms-apps://appsto.re/cn/Geex4.i"

@implementation FJAppRedirect

// 跳转到某个app
+ (void)redirectToApp:(FJAppRedirectName)name success:(void(^)(void))sucess failure:(void(^)(void))failure {
    
    NSString * appURL = nil;
    switch (name) {
            
        case FJAppRedirectName_WWHT_GWZG:
            appURL = APPSTORE_APP(APPSTORE_MARKET_CN, APPSTORE_ID_WWHT_GWZG);
            break;
            
        case FJAppRedirectName_Wechat:
            appURL = APPSTORE_APP(APPSTORE_MARKET_CN, APPSTORE_ID_WECHAT);
            break;
            
        case FJAppRedirectName_QQ:
            appURL = APPSTORE_APP(APPSTORE_MARKET_CN, APPSTORE_ID_QQ);
            break;
            
        case FJAppRedirectName_SinaWeibo:
            appURL = APPSTORE_APP(APPSTORE_MARKET_CN, APPSTORE_ID_SINAWeibo);
            break;
            
        case FJAppRedirectName_Alipay:
            appURL = APPSTORE_APP(APPSTORE_MARKET_CN, APPSTORE_ID_Alipay);
            break;
            
        default:
            appURL = APPSTORE_DEFAULT_URL;
            break;
    }
    
    // Specified App Store Url
    NSURL * url = [NSURL URLWithString:appURL];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        
#if defined(__IPHONE_OS_VERSION_MAX_ALLOWED) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
#else
        [[UIApplication sharedApplication] openURL:url];
#endif
        if (sucess) {
            sucess();
        }
        
    }
    else {
        
        // Default App Store Url
        url = [NSURL URLWithString:APPSTORE_DEFAULT_URL];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            
#if defined(__IPHONE_OS_VERSION_MAX_ALLOWED) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
#else
            [[UIApplication sharedApplication] openURL:url];
#endif
            
            if (sucess) {
                sucess();
            }
            
        }else{
            if (failure) {
                failure();
            }
        }
    }
}

// 是否安装了某个app
+ (BOOL)isClientInstalled:(FJAppRedirectName)name {
    
    NSString *scheme = nil;
    
    switch (name) {
            
        case FJAppRedirectName_WWHT_GWZG:
        {
            scheme = @"new55haitao:";
            break;
        }
            
        case FJAppRedirectName_QQ:
        {
            scheme = @"mqq:";
            break;
        }
            
        case FJAppRedirectName_Wechat:
        {
            scheme = @"wechat:";
            break;
        }
            
        case FJAppRedirectName_Alipay:
        {
            scheme = @"alipay:";
            break;
        }
            
        case FJAppRedirectName_SinaWeibo:
        {
            scheme = @"sinaweibo:";
            break;
        }
    }
    
    NSURL * app_scheme_url = [NSURL URLWithString:scheme];
    if (![[UIApplication sharedApplication] canOpenURL:app_scheme_url]) {
        return NO;
    }
    return YES;
}

@end
