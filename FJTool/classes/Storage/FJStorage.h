//
//  FJStorage.h
//  FJTool
//
//  Created by Jeff on 2017/2/15.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FJStorage : NSObject

// plist中删除某个key
+ (void)clearObject:(NSString *)key;

// plist是否存在某个key
+ (BOOL)isExistKey:(NSString*)key;

// 存储JSONModel对象到plist
+ (void)saveJSONModel:(id)jsonModel key:(NSString *)key;

// plist中加载JSONModel对象
+ (id)loadJSONModel:(NSString *)jsonModelClassName key:(NSString *)key;

// 存储NSString、NSNumber等对象到plist
+ (void)saveNSObject:(id)nsObject key:(NSString*)key;

// plist中加载NSString、NSNumber等对象
+ (id)loadNSObject:(NSString*)key;

// 存储NSData对象到文件
+ (void)writeData:(NSData *)data filename:(NSString *)filename;

// 获取文件的NSData
+ (id)getDataFromFile:(NSString*)filename;

// 清空全部plist
+ (void)clearPlist;

// 清空除[excepts]以外plist
+ (void)clearPlistExcept:(NSArray*)excepts;

@end
