//
//  NSString+Translator.h
//  FJTool
//
//  Created by Jeff on 2017/2/14.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Translator)

// 货币名称转货币符号
- (NSString *)translateToUnitOfCurrency;

// 将国家转成Flag Image名称
- (NSString*)translateToCountryFlagImageName;

// 规格英文转中文
- (NSString*)translateToSpec;

@end
