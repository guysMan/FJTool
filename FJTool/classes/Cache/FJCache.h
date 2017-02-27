//
//  FJCache.h
//  FJTool
//
//  Created by Jeff on 2017/2/14.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <Foundation/Foundation.h>

// "应用程序包": 这里面存放的是应用程序的源文件，包括资源文件和可执行文件。
// let path = NSBundle.mainBundle().bundlePath

// Documents: 最常用的目录，iTunes同步该应用时会同步此文件夹中的内容，适合存储重要数据。
// let documentPaths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)let documentPath = documentPaths[0] as! String或者let documentPath = NSHomeDirectory() + "/Documents"

// Library/Caches: iTunes不会同步此文件夹，适合存储体积大，不需要备份的非重要数据。
// let cachePaths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)let CachePath = cachePaths[0] as! String或者let documentPath = NSHomeDirectory() + "/Library"let documentPath = NSHomeDirectory() + "/Library/Caches"

// Library/Preferences: iTunes同步该应用时会同步此文件夹中的内容，通常保存应用的设置信息。

// tmp: iTunes不会同步此文件夹，系统可能在应用没运行时就删除该目录下的文件，所以此目录适合保存应用中的一些临时文件，用完就删除。
// let tmpPath = NSTemporaryDirectory()

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
