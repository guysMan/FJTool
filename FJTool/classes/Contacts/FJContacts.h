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

@class FJContactList;

typedef NS_ENUM(NSInteger, ContactAuthorizationStatus) {
    ContactAuthorizationStatusNotDetermined = 0,    // kABAuthorizationStatusNotDetermined, CNAuthorizationStatusNotDetermined
    ContactAuthorizationStatusRestricted,           // kABAuthorizationStatusRestricted, CNAuthorizationStatusRestricted
    ContactAuthorizationStatusDenied,               // kABAuthorizationStatusDenied, CNAuthorizationStatusDenied
    ContactAuthorizationStatusAuthorized            // kABAuthorizationStatusAuthorized, CNAuthorizationStatusAuthorized
};



@interface FJContacts : NSObject

// 通讯录权限状态
+ (ContactAuthorizationStatus)getContactAuthorizationStatus;
// 通讯录权限状态[iOS9废弃]
+ (ContactAuthorizationStatus)getContactAuthorizationStatusWAddressBook;
// 通讯录权限状态[iOS9启用]
+ (ContactAuthorizationStatus)getContactAuthorizationStatusWContacts;


// 请求通讯录权限
+ (BOOL)requestPrivacyRight;
// 请求通讯录权限[iOS9废弃]
+ (BOOL)requestPrivacyRightWAddressBook;
// 请求通讯录权限[iOS9启用]
+ (BOOL)requestPrivacyRightWContacts;

// 获取用户通讯录
+ (void)getContacts:(void(^)(FJContactList *contact))callback;
// 获取用户通讯录[iOS9废弃]
+ (void)getContactsWAddressBook:(void(^)(FJContactList *contact))callback;
// 获取用户通讯录[iOS9启用]
+ (void)getContactsWContacts:(void(^)(FJContactList *contact))callback;

@end
