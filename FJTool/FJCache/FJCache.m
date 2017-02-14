//
//  FJCache.m
//  FJTool
//
//  Created by Jeff on 2017/2/14.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "FJCache.h"

#define Cache_Category_Default   @"default"
#define Cache_Category_SnapShots @"Snapshots"

@implementation FJCache

// 获取沙盒Library的文件目录。
+ (NSString *)libraryDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
}

// 获取沙盒Document的文件目录。
+ (NSString *)documentDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

// 获取沙盒Preference的文件目录。
+ (NSString *)preferencePanesDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, YES) lastObject];
}

// 获取沙盒Caches的文件目录。
+ (NSString *)cachesDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

// 返回path路径下文件的文件大小。
+ (double)sizeWithFilePaht:(NSString *)path
{
    // 1.获得文件夹管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 2.检测路径的合理性
    BOOL dir = NO;
    BOOL exits = [mgr fileExistsAtPath:path isDirectory:&dir];
    if (!exits) return 0;
    
    // 3.判断是否为文件夹
    if (dir) { // 文件夹, 遍历文件夹里面的所有文件
        // 这个方法能获得这个文件夹下面的所有子路径(直接\间接子路径)
        NSArray *subpaths = [mgr subpathsAtPath:path];
        int totalSize = 0;
        for (NSString *subpath in subpaths) {
            NSString *fullsubpath = [path stringByAppendingPathComponent:subpath];
            
            BOOL dir = NO;
            [mgr fileExistsAtPath:fullsubpath isDirectory:&dir];
            if (!dir) { // 子路径是个文件
                NSDictionary *attrs = [mgr attributesOfItemAtPath:fullsubpath error:nil];
                totalSize += [attrs[NSFileSize] intValue];
            }
        }
        return totalSize / (1000 * 1000.0);
    } else { // 文件
        NSDictionary *attrs = [mgr attributesOfItemAtPath:path error:nil];
        return [attrs[NSFileSize] intValue] / (1000 * 1000.0);
    }
}

// 删除path路径下的文件。
+ (void)clearCachesWithFilePath:(NSString *)path
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    [mgr removeItemAtPath:path error:nil];
    
}

// 获取categoryName的缓存大小
+ (double)getCacheSize:(NSString*)categoryName {
    double cacheSize = 0.0;
    
    NSString *cachePath = [FJCache cachesDirectory];
    NSString *cleanCachePath = [NSString stringWithFormat:@"%@/%@",cachePath,categoryName];
    
    cacheSize += [FJCache sizeWithFilePaht:cleanCachePath];
    
    return cacheSize;
}

// 删除categoryName的缓存
+ (void)clearCache:(NSString*)categoryName {
    NSString *cachePath = [FJCache cachesDirectory];
    NSString *cleanCachePath = [NSString stringWithFormat:@"%@/%@",cachePath,categoryName];
    [FJCache clearCachesWithFilePath:cleanCachePath];
}

// 获取默认缓存大小
+ (double)getCacheSize {
    double cacheSize = 0.0;
    cacheSize += [FJCache getCacheSize:Cache_Category_Default] + [FJCache getCacheSize:Cache_Category_SnapShots];
    return cacheSize;
}

// 删除默认缓存
+ (void)clear {
    [FJCache clearCache:Cache_Category_Default];
    [FJCache clearCache:Cache_Category_SnapShots];
}

@end
