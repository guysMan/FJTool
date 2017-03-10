//
//  FJContacts.m
//  FJTool
//
//  Created by Jeff on 2017/3/9.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "FJContacts.h"
#import "FJContactModel.h"

@implementation FJContacts

// 是否第一次启动通讯录
+ (BOOL)isNotDetermined {
#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED) && __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_9_0
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
#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED) && __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_9_0
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
+ (void)getContacts:(void(^)(id contact))callback {
#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED) && __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_9_0
    // 1.获取授权状态
    // 2.如果是已经授权,才能获取联系人
    if (![self hasContactsAccessRight] && ![self isNotDetermined]) return;
    
    // 3.创建通信录对象
    ABAddressBookRef addressBook = ABAddressBookCreate();
    
    // 4.获取所有的联系人
    CFArrayRef peopleArray = ABAddressBookCopyArrayOfAllPeople(addressBook);
    CFIndex peopleCount = CFArrayGetCount(peopleArray);
    
    FJContactList *result = nil;
    if (peopleCount > 0) {
        result = [[FJContactList alloc] init];
        result.contactList = (NSMutableArray<FJContactModel> *)[[NSMutableArray alloc] init];
    }
    // 5.遍历所有的联系人
    for (int i = 0; i < peopleCount; i++) {
        
        FJContactModel *onePerson = [[FJContactModel alloc] init];
        // 5.1.获取某一个联系人
        ABRecordRef person = CFArrayGetValueAtIndex(peopleArray, i);
        // 5.2.获取联系人的姓名
        NSString *lastName = (__bridge_transfer NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
        NSString *firstName = (__bridge_transfer NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
        NSString *middleName = (__bridge_transfer NSString *)ABRecordCopyValue(person, kABPersonMiddleNameProperty);
        onePerson.lastName = lastName;
        onePerson.firstName = firstName;
        onePerson.middleName = middleName;
        // 5.3.获取电话号码
        // 5.3.1.获取所有的电话号码
        ABMultiValueRef phones = ABRecordCopyValue(person, kABPersonPhoneProperty);
        CFIndex phoneCount = ABMultiValueGetCount(phones);
        
        // 5.3.2.遍历拿到每一个电话号码
        NSMutableArray *onePersonsPhones = nil;
        if (phoneCount > 0) {
            onePersonsPhones = [[NSMutableArray alloc] init];
            for (int i = 0; i < phoneCount; i++) {
                // 1.获取电话对应的key
                NSString *phoneLabel = (__bridge_transfer NSString *)ABMultiValueCopyLabelAtIndex(phones, i);
                // 2.获取电话号码
                NSString *phoneValue = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(phones, i);
                FJPhoneModel *onePhone = [[FJPhoneModel alloc] init];
                onePhone.mobile = phoneValue;
                onePhone.label = phoneLabel;
                [onePersonsPhones addObject:onePhone];
            }
            onePerson.phones = (NSMutableArray<FJPhoneModel> *)onePersonsPhones;
        }
        CFRelease(phones);
        
        // 5.4公司名称
        NSString *companyName = (__bridge_transfer NSString *)ABRecordCopyValue(person, kABPersonOrganizationProperty);
        onePerson.companyName = companyName;
        
        // 5.5. 获取邮件
        // 5.5.1. 获取所有的邮件名称
        ABMultiValueRef emails = ABRecordCopyValue(person, kABPersonEmailProperty);
        CFIndex emailCount = ABMultiValueGetCount(emails);
        
        // 5.5.2.遍历拿到每一个邮箱名称
        NSMutableArray *onePersonsEmails = [[NSMutableArray alloc] init];
        if (emailCount > 0) {
            onePersonsEmails = [[NSMutableArray alloc] init];
            for (int i = 0; i < emailCount; i++) {
                // 1.获取邮箱名称对应的key
                NSString *emailLabel = (__bridge_transfer NSString *)ABMultiValueCopyLabelAtIndex(emails, i);
                // 2.获取邮箱名称
                NSString *emailValue = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(emails, i);
                FJEmailModel *oneEmail = [[FJEmailModel alloc] init];
                oneEmail.email = emailValue;
                oneEmail.label = emailLabel;
                [onePersonsEmails addObject:oneEmail];
            }
            onePerson.emails = (NSMutableArray<FJEmailModel> *)onePersonsEmails;
        }
        
        CFRelease(emails);
        
        [result.contactList addObject:onePerson];
    }
    CFRelease(addressBook);
    CFRelease(peopleArray);
    callback == nil ? : callback(result);
#else
    // 1.获取授权状态
    // 2.判断授权状态,如果不是已经授权,则直接返回
    if (![self hasContactsAccessRight] && ![self isNotDetermined]) return;
    
    // 3.创建通信录对象
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    
    // 4.创建获取通信录的请求对象
    // 4.1.拿到所有打算获取的属性对应的key
    NSArray *keys = @[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactMiddleNameKey, CNContactPhoneNumbersKey, CNContactOrganizationNameKey, CNContactEmailAddressesKey];
    
    // 4.2.创建CNContactFetchRequest对象
    CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:keys];
    
    FJContactList *result = [[FJContactList alloc] init];
    result.contactList = (NSMutableArray<FJContactModel> *)[[NSMutableArray alloc] init];
    
    /* 线程等待
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_semaphore_signal(semaphore);
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    dispatch_release(semaphore);
    semaphore = nil;
    */
    // 5.遍历所有的联系人
    //    [contactStore enumerateContactsWithFetchRequest:request error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
    //    }];
    NSArray *fetchResults = [contactStore unifiedContactsMatchingPredicate:[CNContact predicateForContactsInContainerWithIdentifier:[contactStore defaultContainerIdentifier]] keysToFetch:keys error:nil];
    for (CNContact *contact in fetchResults) {
        FJContactModel *onePerson = [[FJContactModel alloc] init];
        // 1.获取联系人的姓名
        NSString *lastname = contact.familyName;
        NSString *firstname = contact.givenName;
        NSString *middleName = contact.middleName;
        onePerson.lastName = lastname;
        onePerson.firstName = firstname;
        onePerson.middleName = middleName;
        
        // 2.获取联系人的电话号码
        NSMutableArray *onePersonsPhones = nil;
        NSArray *phoneNums = contact.phoneNumbers;
        if ([phoneNums count] > 0) {
            onePersonsPhones = [[NSMutableArray alloc] init];
            for (CNLabeledValue *labeledValue in phoneNums) {
                // 2.1.获取电话号码的KEY
                NSString *phoneLabel = labeledValue.label;
                
                // 2.2.获取电话号码
                CNPhoneNumber *phoneNumer = labeledValue.value;
                NSString *phoneValue = phoneNumer.stringValue;
                FJPhoneModel *onePhone = [[FJPhoneModel alloc] init];
                onePhone.mobile = phoneValue;
                onePhone.label = phoneLabel;
                [onePersonsPhones addObject:onePhone];
            }
            onePerson.phones = (NSMutableArray<FJPhoneModel> *)onePersonsPhones;
        }
        
        // 5.4公司名称
        onePerson.companyName = contact.organizationName;
        
        // 5.5. 获取邮件
        NSMutableArray *onePersonsEmails = nil;
        NSArray *emailAddrs = contact.emailAddresses;
        if ([emailAddrs count] > 0) {
            onePersonsEmails = [[NSMutableArray alloc] init];
            for (CNLabeledValue *labeledValue in emailAddrs) {
                // 2.1.获取邮件的KEY
                NSString *emailLabel = labeledValue.label;
                
                // 2.2.获取邮件
                NSString *emailValue = labeledValue.value;
                FJEmailModel *oneEmail = [[FJEmailModel alloc] init];
                oneEmail.email = emailValue;
                oneEmail.label = emailLabel;
                [onePersonsEmails addObject:oneEmail];
            }
            onePerson.emails = (NSMutableArray<FJEmailModel> *)onePersonsEmails;
        }
        [result.contactList addObject:onePerson];
    }
    callback == nil ? : callback(result);
#endif
}


@end
