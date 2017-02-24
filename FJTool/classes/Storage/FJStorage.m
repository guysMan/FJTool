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

// plist中删除某个key
+ (void)clearObject:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
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

// 存储JSONModel对象到plist
+ (void)saveJSONModel:(id)jsonModel key:(NSString *)key {
    if (key == nil) {
        return;
    }
    
    if (jsonModel == nil) {
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
        
    }else{
        
        NSString *_data = [jsonModel toJSONString];
        [[NSUserDefaults standardUserDefaults] setObject:_data forKey:key];
        
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// plist中加载JSONModel对象
+ (id)loadJSONModel:(NSString *)jsonModelClassName key:(NSString *)key {
    
    NSError *jserror;
    id object;
    NSString *_dataStr = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (!_dataStr) {
        object = [[NSClassFromString(jsonModelClassName) alloc] init];
        return object;
    }
    object = [[NSClassFromString(jsonModelClassName) alloc] initWithString:_dataStr error:&jserror];
    if (!object) {
        object = [[NSClassFromString(jsonModelClassName) alloc] init];
    }
    return object;
}

// 存储NSString、NSNumber等对象到plist
+ (void)saveNSObject:(id)nsObject key:(NSString*)key {
    [[NSUserDefaults standardUserDefaults] setObject:nsObject forKey:key];
}

// plist中加载NSString、NSNumber等对象
+ (id)loadNSObject:(NSString*)key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

// 存储NSData对象到文件
+ (void)writeData:(NSData *)data filename:(NSString *)filename
{
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,  NSUserDomainMask,YES)[0];
    NSString *FileName=[documentPath stringByAppendingPathComponent:filename];
    [data writeToFile:FileName atomically:YES];
}

// 获取文件的NSData
+ (id)getDataFromFile:(NSString*)filename
{
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,  NSUserDomainMask,YES)[0];
    NSString *FileName=[documentPath stringByAppendingPathComponent:filename];
    NSData *objData =[NSData dataWithContentsOfFile:FileName options:0 error:NULL];
    return objData;
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

@end
