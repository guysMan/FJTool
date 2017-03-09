//
//  FJContacts.m
//  FJTool
//
//  Created by Jeff on 2017/3/9.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "FJContacts.h"

@implementation FJContacts

// 是否第一次启动通讯录
+ (BOOL)isNotDetermined {
#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_9_0
    ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
    if (status == kABAuthorizationStatusNotDetermined)
        return YES;
    else
        return NO;
#else
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    if (status == CNAuthorizationStatusNotDetermined)
        return YES;
    else
        return NO;
#endif
}

// 是否有权限
+ (BOOL)hasContactsAccessRight {
#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_9_0
    ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
    if (status == kABAuthorizationStatusAuthorized)
        return YES;
    else
        return NO;
#else
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    if (status == CNAuthorizationStatusAuthorized)
        return YES;
    else
        return NO;
#endif
}


// 获取用户通讯录
+ (void)getContacts:(void(^)(NSMutableArray * contacts))callback {
#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_9_0
    // 1.获取授权状态
    // 2.如果是已经授权,才能获取联系人
    if (![self hasContactsAccessRight] && ![self isNotDetermined]) return;
    
    // 3.创建通信录对象
    ABAddressBookRef addressBook = ABAddressBookCreate();
    
    // 4.获取所有的联系人
    CFArrayRef peopleArray = ABAddressBookCopyArrayOfAllPeople(addressBook);
    CFIndex peopleCount = CFArrayGetCount(peopleArray);
    
    // 5.遍历所有的联系人
    for (int i = 0; i < peopleCount; i++) {
        // 5.1.获取某一个联系人
        ABRecordRef person = CFArrayGetValueAtIndex(peopleArray, i);
        // 5.2.获取联系人的姓名
        NSString *lastName = (__bridge_transfer NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
        NSString *firstName = (__bridge_transfer NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
        NSLog(@"%@ %@", lastName, firstName);
        
        // 5.3.获取电话号码
        // 5.3.1.获取所有的电话号码
        ABMultiValueRef phones = ABRecordCopyValue(person, kABPersonPhoneProperty);
        CFIndex phoneCount = ABMultiValueGetCount(phones);
        
        // 5.3.2.遍历拿到每一个电话号码
        NSMutableArray *ret = nil;
        if (phoneCount > 0) {
            ret = [[NSMutableArray alloc] init];
            for (int i = 0; i < phoneCount; i++) {
                // 1.获取电话对应的key
                NSString *phoneLabel = (__bridge_transfer NSString *)ABMultiValueCopyLabelAtIndex(phones, i);
                // 2.获取电话号码
                NSString *phoneValue = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(phones, i);
                [ret addObject:[NSString stringWithFormat:@"%@ %@",phoneLabel, phoneValue]];
            }
            callback == nil ? : callback(ret);
        }else{
            callback == nil ? : callback(nil);
        }
        CFRelease(phones);
    }
    
    CFRelease(addressBook);
    CFRelease(peopleArray);
#else
    // 1.获取授权状态
    // 2.判断授权状态,如果不是已经授权,则直接返回
    if (![self hasContactsAccessRight] && ![self isNotDetermined]) return;
    
    // 3.创建通信录对象
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    
    // 4.创建获取通信录的请求对象
    // 4.1.拿到所有打算获取的属性对应的key
    NSArray *keys = @[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey];
    
    // 4.2.创建CNContactFetchRequest对象
    CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:keys];
    
    // 5.遍历所有的联系人
    [contactStore enumerateContactsWithFetchRequest:request error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
        // 1.获取联系人的姓名
        NSString *lastname = contact.familyName;
        NSString *firstname = contact.givenName;
        NSLog(@"%@ %@", lastname, firstname);
        
        // 2.获取联系人的电话号码
        NSArray *phoneNums = contact.phoneNumbers;
        NSMutableArray *ret = nil;
        if (phoneNums > 0) {
            ret = [[NSMutableArray alloc] init];
            for (CNLabeledValue *labeledValue in phoneNums) {
                // 2.1.获取电话号码的KEY
                NSString *phoneLabel = labeledValue.label;
                
                // 2.2.获取电话号码
                CNPhoneNumber *phoneNumer = labeledValue.value;
                NSString *phoneValue = phoneNumer.stringValue;
                [ret addObject:[NSString stringWithFormat:@"%@ %@",phoneLabel, phoneValue]];
            }
            callback == nil ? : callback(ret);
        }else{
            callback == nil ? : callback(nil);
        }
        
    }];
#endif
}


@end
