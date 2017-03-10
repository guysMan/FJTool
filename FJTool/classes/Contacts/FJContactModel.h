//
//  FJContactModel.h
//  FJTool
//
//  Created by Jeff on 2017/3/10.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FJContactModel;
@protocol FJContactModel;
@class FJPhoneModel;
@protocol FJPhoneModel;
@class FJEmailModel;
@protocol FJEmailModel;

@interface FJContactList : NSObject

@property (nonatomic, strong) NSMutableArray<FJContactModel> *contactList;

@end


@interface FJContactModel : NSObject
@property (nonatomic, copy)   NSString *firstName;
@property (nonatomic, copy)   NSString *middleName;
@property (nonatomic, copy)   NSString *lastName;
@property (nonatomic, copy)   NSString *companyName;
@property (nonatomic, strong) NSMutableArray<FJPhoneModel> *phones;
@property (nonatomic, strong) NSMutableArray<FJEmailModel> *emails;
@end

@protocol FJContactModel

@end


@interface FJPhoneModel : NSObject
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *label;
@end

@protocol FJPhoneModel

@end

@interface FJEmailModel : NSObject
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *label;
@end

@protocol FJEmailModel

@end
