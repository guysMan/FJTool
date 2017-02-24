//
//  NSString+Translator.m
//  FJTool
//
//  Created by Jeff on 2017/2/14.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "NSString+Translator.h"

@implementation NSString (Translator)

// 货币名称转货币符号
- (NSString *)translateToUnitOfCurrency
{
    if ([self isEqualToString:@"USD"]) {
        return @"$";
    }else if ([self isEqualToString:@"CNY"]) {
        return @"￥";
    }else if ([self isEqualToString:@"GBP"]) {
        return @"£";
    }else if ([self isEqualToString:@"JPY"]) {
        return @"JPY";
    }else if ([self isEqualToString:@"EUR"]) {
        return @"€";
    }else if ([self isEqualToString:@"AUD"]) {
        return @"AUD";
    }else if ([self isEqualToString:@"HKD"]) {
        return @"HKD";
    }
    
    return self;
}

// 将国家转成Flag Image名称
- (NSString*)translateToCountryFlagImageName
{
    if ([self isEqualToString:@"美国"] || [self isEqualToString:@"USA"] || [self isEqualToString:@"US"]) {
        return @"USA";
    }else if ([self isEqualToString:@"英国"] || [self isEqualToString:@"UK"]) {
        return @"UK";
    }else if ([self isEqualToString:@"泰国"] || [self isEqualToString:@"TH"]) {
        return @"Thailand";
    }
    else if ([self isEqualToString:@"新加坡"] || [self isEqualToString:@"SG"]) {
        return @"Singapore";
    }
    else if ([self isEqualToString:@"俄罗斯"] || [self isEqualToString:@"RU"]) {
        return @"Russia";
    }
    else if ([self isEqualToString:@"新西兰"] || [self isEqualToString:@"NZ"]) {
        return @"NewZealand";
    }
    else if ([self isEqualToString:@"韩国"] || [self isEqualToString:@"KR"]) {
        return @"Korea";
    }
    else if ([self isEqualToString:@"日本"] || [self isEqualToString:@"JP"]) {
        return @"Japan";
    }
    else if ([self isEqualToString:@"意大利"] || [self isEqualToString:@"IT"]) {
        return @"Italy";
    }
    else if ([self isEqualToString:@"德国"] || [self isEqualToString:@"DE"]) {
        return @"Germany";
    }
    else if ([self isEqualToString:@"法国"] || [self isEqualToString:@"FR"]) {
        return @"France";
    }
    else if ([self isEqualToString:@"中国"] || [self isEqualToString:@"CN"] || [self isEqualToString:@"ZH"]) {
        return @"China";
    }
    else if ([self isEqualToString:@"加拿大"] || [self isEqualToString:@"CA"]) {
        return @"Canada";
    }
    else if ([self isEqualToString:@"澳大利亚"] || [self isEqualToString:@"AU"] || [self isEqualToString:@"AUS"]) {
        return @"Australia";
    }
    
    return self;
}

// 规格英文转中文
- (NSString*)translateToSpec {
    
    NSString *lowerCaseStr = [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] lowercaseString];
    
    if (lowerCaseStr == nil || [lowerCaseStr length] == 0) {
        return @"";
    }
    
    if ([lowerCaseStr containsString:@"color"]) {
        return @"颜色";
    }else if ([lowerCaseStr containsString:@"size"]) {
        return @"尺寸";
    }else if ([lowerCaseStr containsString:@"length"]) {
        return @"长度";
    }else if ([lowerCaseStr containsString:@"width"]) {
        return @"宽度";
    }else if ([lowerCaseStr containsString:@"uk size"]) {
        return @"英码";
    }else if ([lowerCaseStr containsString:@"height"]) {
        return @"高度";
    }else if ([lowerCaseStr containsString:@"chest"]) {
        return @"胸围";
    }else if ([lowerCaseStr containsString:@"inseam"]) {
        return @"裤长";
    }else if ([lowerCaseStr containsString:@"choice_group"]) {
        return @"款式";
    }else if ([lowerCaseStr containsString:@"style"]) {
        return @"式样";
    }else if ([lowerCaseStr containsString:@"shade"]) {
        return @"阴影";
    }else if ([lowerCaseStr containsString:@"waist"]) {
        return @"腰围";
    }else if ([lowerCaseStr containsString:@"band size"]) {
        return @"胸围";
    }else if ([lowerCaseStr containsString:@"cup size"]) {
        return @"罩杯";
    }else if ([lowerCaseStr containsString:@"standard"]) {
        return @"规格";
    }else if ([lowerCaseStr containsString:@"specialsizetype"]) {
        return @"特款";
    }else if ([lowerCaseStr containsString:@"customerpackagetype"]) {
        return @"包装";
    }
    
    // 是否以"_"开头
    int c = [lowerCaseStr characterAtIndex:0];
    if (c == 95) {
        return [self substringFromIndex:1];
    }else{
        return self;
    }
}

@end
