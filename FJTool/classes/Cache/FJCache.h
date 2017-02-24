//
//  FJCache.h
//  FJTool
//
//  Created by Jeff on 2017/2/14.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FJCache : NSObject

// 获取沙盒Library的文件目录。
+ (NSString *)libraryDirectory;

// 获取沙盒Document的文件目录。
+ (NSString *)documentDirectory;

// 获取沙盒Preference的文件目录。
+ (NSString *)preferencePanesDirectory;

// 获取沙盒Caches的文件目录。
+ (NSString *)cachesDirectory;

// 返回path路径下文件的文件大小。
+ (double)sizeWithFilePaht:(NSString *)path;

// 删除path路径下的文件。
+ (void)clearCachesWithFilePath:(NSString *)path;

// 获取categoryName的缓存大小
+ (double)getCacheSize:(NSString*)categoryName;

// 删除categoryName的缓存
+ (void)clearCache:(NSString*)categoryName;

// 获取默认缓存大小
+ (double)getCacheSize;

// 删除默认缓存
+ (void)clear;

@end
