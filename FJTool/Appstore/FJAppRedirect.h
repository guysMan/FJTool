//
//  FJAppRedirect.h
//  FJTool
//
//  Created by Jeff on 2017/2/15.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,FJAppRedirectName) {
    FJAppRedirectName_WWHT_GWZG,
    FJAppRedirectName_Wechat,
    FJAppRedirectName_QQ,
    FJAppRedirectName_SinaWeibo,
    FJAppRedirectName_Alipay
};

@interface FJAppRedirect : NSObject

// 跳转到某个app
+ (void)redirectToApp:(FJAppRedirectName)name success:(void(^)(void))sucess failure:(void(^)(void))failure;

// 是否安装了某个app
+ (BOOL)isClientInstalled:(FJAppRedirectName)name;

@end
