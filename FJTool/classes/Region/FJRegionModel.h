//
//  FJRegionModel.h
//  FJTool
//
//  Created by Jeff on 2017/2/28.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@protocol FJProvinceModel;
@protocol FJCityModel;

@interface FJRegionModel : JSONModel

@property (nonatomic, strong) NSMutableArray<FJProvinceModel, Optional> *provinces;   // 省份[直辖市]集合

@end


@interface FJProvinceModel : JSONModel

@property (nonatomic, copy)   NSString<Optional> *name;                     // 省份[直辖市]名称
@property (nonatomic, strong) NSMutableArray<FJCityModel, Optional> *list;    // 省份[直辖市]下属地区

@end

@protocol FJProvinceModel

@end


@interface FJCityModel : JSONModel

@property (nonatomic, copy)   NSString<Optional> *name;        // 城市[地区]名称
@property (nonatomic, strong) NSMutableArray<Optional> *list;  // 城市[地区]下属地区

@end

@protocol FJCityModel

@end
