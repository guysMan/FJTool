//
//  FJRegion.h
//  FJTool
//
//  Created by Jeff on 2017/2/28.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RegionModel;

@interface FJRegion : NSObject

// 是否是Chinese Locale
+ (BOOL)isChineseLanguage;

// 所有国家索引
+(NSArray*)countrySections;

// 所有国家代码
+(NSArray*)allCountryCodes;

// 所有国家
+(NSArray*)allCountries;

// 热门国家
+ (NSArray*)hotCountries;

// 热门国家代码
+ (NSArray*)hotCountryCodes;

// 热门国家英文简写
+ (NSArray*)hotCountryCodes_Alpha;

// 国内省市区对象
+ (RegionModel*)domesticDistricts;

@end
