//
//  FJStorage.h
//  FJTool
//
//  Created by Jeff on 2017/2/15.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FJStorage : NSObject

// 存储JSONModel对象到plist
+ (void)save_jsonmodel:(id)object key:(NSString *)key;

// plist中加载JSONModel对象
+ (id)value_jsonmodel:(NSString *)objectClassName key:(NSString *)key;

// 存储NSString、NSNumber等对象到plist
+ (void)save_nsobject:(id)object key:(NSString*)key;

// plist中加载NSString、NSNumber等对象
+ (id)value_nsobject:(NSString*)key;

// plist是否存在某个key
+ (BOOL)isExistKey:(NSString*)key;

// plist中删除某个key
+ (void)clearObject:(NSString *)key;

// 清空全部plist
+ (void)clearPlist;

// 清空除[excepts]以外plist
+ (void)clearPlistExcept:(NSArray*)excepts;

// 存储NSData对象到文件
+ (void)writeData:(NSData *)data name:(NSString *)name;

// 获取文件的NSData
+ (id)readData:(NSString*)name;

@end
