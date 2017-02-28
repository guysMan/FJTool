//
//  RegionModel.h
//  FJTool
//
//  Created by Jeff on 2017/2/28.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@protocol ProvinceModel;
@protocol CityModel;

@interface RegionModel : JSONModel

@property (nonatomic, strong) NSMutableArray<ProvinceModel, Optional> *provinces;   // 省份[直辖市]集合

@end


@interface ProvinceModel : JSONModel

@property (nonatomic, copy)   NSString<Optional> *name;                     // 省份[直辖市]名称
@property (nonatomic, strong) NSMutableArray<CityModel, Optional> *list;    // 省份[直辖市]下属地区

@end

@protocol ProvinceModel
@end


@interface CityModel : JSONModel

@property (nonatomic, copy)   NSString<Optional> *name;        // 城市[地区]名称
@property (nonatomic, strong) NSMutableArray<Optional> *list;  // 城市[地区]下属地区

@end

@protocol CityModel
@end
