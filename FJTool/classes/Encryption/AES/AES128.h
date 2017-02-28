//
//  AES128.h
//  haitao
//
//  Created by Eric on 15/8/13.
//  Copyright (c) 2015年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AES128 : NSObject


+(NSString *)AES128Encrypt:(NSString *)plainText withKey:(NSString *)key withIV:(NSString *)iv;

+(NSString *)AES128Decrypt:(NSString *)encryptText withKey:(NSString *)key withIV:(NSString *)iv;

@end
