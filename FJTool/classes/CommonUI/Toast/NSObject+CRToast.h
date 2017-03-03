//
//  NSObject+CRToast.h
//  FJDemo
//
//  Created by Jeff on 2017/3/3.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CRToast/CRToast.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CRToastImageType) {
    
    CRToastImageType_Success,
    CRToastImageType_Error,
    CRToastImageType_Warning,
    CRToastImageType_Infomation,
    CRToastImageType_Message,
    CRToastImageType_Service
    
};

@interface NSObject (CRToast)

// CRToast[Basic]
- (void)CRToastTitle:(NSString*)title subTitle:(NSString*)subTitle;


// CRToast[All]
- (void)CRToastTitle:(NSString*)title titleColor:(UIColor*)titleColor titleFont:(UIFont*)titleFont subTitle:(NSString*)subTitle subTitleColor:(UIColor*)subTitleColor subTitleFont:(UIFont*)subTitleFont backgroundColor:(UIColor*)backgroundColor icon:(UIImage*)icon duration:(CGFloat)duration;

@end
