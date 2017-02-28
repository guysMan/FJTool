//
//  NSString+Hash.h
//  Demo
//
//  Created by Fu Jie on 16/4/28.
//  Copyright © 2016年 Aichen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Hash)

- (NSString *) stringMD5;
- (NSString *) sha1;
- (NSString *) md5;
- (NSString *) sha1_base64;
- (NSString *) md5_base64;
- (NSString *) base64;

@end
