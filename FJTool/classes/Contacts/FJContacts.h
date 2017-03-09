//
//  FJContacts.h
//  FJTool
//
//  Created by Jeff on 2017/3/9.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
#import <Contacts/Contacts.h>

@interface FJContacts : NSObject

// 是否第一次启动通讯录
+ (BOOL)isNotDetermined;

// 是否有权限
+ (BOOL)hasContactsAccessRight;

// 获取用户通讯录
+ (void)getContacts:(void(^)(NSMutableArray * contacts))callback;

@end
