//
//  FJStorage.m
//  FJTool
//
//  Created by Jeff on 2017/2/15.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "FJStorage.h"
#import <JSONModel/JSONModel.h>

@implementation FJStorage

// 存储JSONModel对象到plist
+ (void)save_jsonmodel:(id)object key:(NSString *)key {
    if (key == nil) {
        return;
    }
    
    if (object == nil) {
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
        
    }else{
        
        NSString *_data = [object toJSONString];
        [[NSUserDefaults standardUserDefaults] setObject:_data forKey:key];
        
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// plist中加载JSONModel对象
+ (id)value_jsonmodel:(NSString *)objectClassName key:(NSString *)key {
    
    NSError *jserror;
    id object;
    NSString *_dataStr = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (!_dataStr) {
        object = [[NSClassFromString(objectClassName) alloc] init];
        return object;
    }
    object = [[NSClassFromString(objectClassName) alloc] initWithString:_dataStr error:&jserror];
    if (!object) {
        object = [[NSClassFromString(objectClassName) alloc] init];
    }
    return object;
}

// 存储NSString、NSNumber等对象到plist
+ (void)save_nsobject:(id)object key:(NSString*)key {
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// plist中加载NSString、NSNumber等对象
+ (id)value_nsobject:(NSString*)key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

// plist是否存在某个key
+ (BOOL)isExistKey:(NSString*)key {
    id object = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (object) {
        return YES;
    }else{
        return NO;
    }
}

// plist中删除某个key
+ (void)clearObject:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// 清空全部plist
+ (void)clearPlist {
    
    NSUserDefaults *userDefatluts = [NSUserDefaults standardUserDefaults];
    NSDictionary *dictionary = [userDefatluts dictionaryRepresentation];
    for(NSString* key in [dictionary allKeys]){
        [userDefatluts removeObjectForKey:key];
        [userDefatluts synchronize];
    }
}

// 清空除[excepts]以外plist
+ (void)clearPlistExcept:(NSArray*)excepts {
    
    NSUserDefaults *userDefatluts = [NSUserDefaults standardUserDefaults];
    NSDictionary *dictionary = [userDefatluts dictionaryRepresentation];
    for(NSString* key in [dictionary allKeys]){
        if (![excepts containsObject:key]) {
            [userDefatluts removeObjectForKey:key];
            [userDefatluts synchronize];
        }
    }
}

// 存储NSData对象到文件
+ (void)writeData:(NSData *)data name:(NSString *)name
{
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,  NSUserDomainMask,YES)[0];
    NSString *fileName = [documentPath stringByAppendingPathComponent:name];
    [data writeToFile:fileName atomically:YES];
}

// 获取文件的NSData
+ (id)readData:(NSString*)name
{
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,  NSUserDomainMask,YES)[0];
    NSString *fileName = [documentPath stringByAppendingPathComponent:name];
    NSData *data = [NSData dataWithContentsOfFile:fileName options:0 error:NULL];
    return data;
}

@end
