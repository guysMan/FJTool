//
//  NSString+Helper.m
//  FJTool
//
//  Created by Jeff on 2017/2/14.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "NSString+Helper.h"

#define Second_PerMinute 60
#define Second_PerHour   3600
#define Second_PerDay    86400

@implementation NSString (Helper)

// 去除空格字符
- (NSString*)trimString:(TrimType)trimType
{
    NSString *newStr = nil;
    switch (trimType) {
        case TrimType_Default:
        case TrimType_WhiteSpace:
        {
            newStr = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        }
            break;
            
        case TrimType_WhiteSpaneAndNewline:
        {
            newStr = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }
            break;
            
        case TrimType_AllSpace:
        {
            newStr = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
        }
            break;
            
        default:
        {
            newStr = self;
        }
            break;
    }
    return newStr;
}

// 是否包含相同的字符串（大小写敏感）
- (BOOL)containsStringMatchCase:(NSString *)aString
{
    NSRange range = [self rangeOfString:aString];
    return (range.length > 0);
}

// 是否包含相同的字符串（大小写不敏感）
- (BOOL)containsStringIgnoreCase:(NSString *)aString
{
    NSRange range = [[self lowercaseString] rangeOfString:[aString lowercaseString]];
    return (range.length > 0);
}

// 字符串是否相同（空格去除可控，大小写敏感）
- (BOOL)isEqualToString:(NSString *)aString trimType:(TrimType)trimType
{
    NSString *strSelf = [self trimString:trimType];
    NSString *strCompare = [aString trimString:trimType];
    if ([strSelf isEqualToString:strCompare]) {
        return YES;
    }else{
        return NO;
    }
}

// 字符串是否相同（空格不可去除，大小写敏感可控）
- (BOOL)isEqualToString:(NSString *)aString ignorecase:(BOOL)ignorecase
{
    if (ignorecase) {
        return ([self caseInsensitiveCompare:aString] == NSOrderedSame);
    }else{
        return [self isEqualToString:aString];
    }
}

// 字符串是否相同（空格去除可控，大小写敏感可控）
- (BOOL)isEqualToString:(NSString *)aString trimType:(TrimType)trimType ignorecase:(BOOL)ignorecase
{
    NSString *strSelf = [self trimString:trimType];
    NSString *strCompare = [aString trimString:trimType];
    if (ignorecase) {
        return ([strSelf caseInsensitiveCompare:strCompare] == NSOrderedSame);
    }else{
        return [strSelf isEqualToString:strCompare];
    }
}

// 去除所有空格，是否为空
- (BOOL)isEmptyTrimmingAllSpace
{
    NSString *string = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    return string == nil || string.length == 0;
}

// 截取两段字符串之间的子字符串
- (NSString *)substringWithFromSting:(NSString *)fromString toString:(NSString *)toString {
    
    NSRange startRange = [self rangeOfString:fromString];
    NSRange endRange = [self rangeOfString:toString];
    NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
    return [self substringWithRange:range];
}

// 是否包含Emoji
- (BOOL)containsEmoji
{
    __block BOOL returnValue = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                              const unichar hs = [substring characterAtIndex:0];
                              if (0xd800 <= hs && hs <= 0xdbff) {
                                  if (substring.length > 1) {
                                      const unichar ls = [substring characterAtIndex:1];
                                      const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                      if (0x1d000 <= uc && uc <= 0x1f77f) {
                                          returnValue = YES;
                                      }
                                  }
                              } else if (substring.length > 1) {
                                  const unichar ls = [substring characterAtIndex:1];
                                  if (ls == 0x20e3) {
                                      returnValue = YES;
                                  }
                              } else {
                                  if (0x2100 <= hs && hs <= 0x27ff) {
                                      returnValue = YES;
                                  } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                      returnValue = YES;
                                  } else if (0x2934 <= hs && hs <= 0x2935) {
                                      returnValue = YES;
                                  } else if (0x3297 <= hs && hs <= 0x3299) {
                                      returnValue = YES;
                                  } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                      returnValue = YES;
                                  }
                              }
                          }];
    return returnValue;
}

// 去除某个字符
- (NSString*)trimCharacter:(NSString*)character {
    
    if (![self length]) {
        return nil;
    }
    
    NSMutableString *strr = [[NSMutableString alloc] init];
    NSArray *arr = [self componentsSeparatedByString:@"-"];
    for (NSString *str in arr) {
        [strr appendString:str];
    }
    return strr;
}

// 获取字符串Byte数（汉字2byte，英文1byte）
- (NSUInteger)bytesLenght {
    int lenght = 0;
    for(int i=0; i< [self length]; i++){
        int c = [self characterAtIndex:i];
        if( c > 0x4e00 && c < 0x9fff) { // 中文
            lenght += 2;
        }else {
            lenght += 1;
        }
    }
    return lenght;
}

// 首字母是否是英文字母
- (BOOL)isLetter {
    if ([self isLowerCaseLetter] || [self isUpperCaseLetter]) {
        return YES;
    }
    return NO;
}

// 首字母是否小写
- (BOOL)isLowerCaseLetter {
    if ([self characterAtIndex:0] >= 'a' && [self characterAtIndex:0] <= 'z') {
        return YES;
    }
    return NO;
}

// 首字母是否大写
- (BOOL)isUpperCaseLetter {
    if ([self characterAtIndex:0] >= 'A' && [self characterAtIndex:0] <= 'Z') {
        return YES;
    }
    return NO;
}

// 用户比较APP版本大小
+ (FJCompareResult)compare:(NSString*)str1 than:(NSString*)str2 {
    
    if (str1 == nil && str2 == nil) {
        return FJCompareResult_Equal;
    }else if (str1 == nil) {
        return FJCompareResult_Smaller;
    }else if (str2 == nil) {
        return FJCompareResult_Larger;
    }else if ([str1 isEqualToString:str2]){
        return FJCompareResult_Equal;
    }else{
        NSArray *arr1 = [str1 componentsSeparatedByString:@"."];
        NSArray *arr2 = [str2 componentsSeparatedByString:@"."];
        int ret1 = 0;
        int ret2 = 0;
        if ([arr1 count] == [arr2 count]) {
            // 版本格式一致
            for (int i = 0; i < [arr1 count]; i++) {
                ret1 += ([arr1[i] intValue] * pow(10, ([arr1 count] - i)));
                ret2 += ([arr2[i] intValue] * pow(10, ([arr2 count] - i)));
            }
            
            if (ret1 == ret2) {
                return FJCompareResult_Equal;
            }else if (ret1 < ret2) {
                return FJCompareResult_Smaller;
            }else{
                return FJCompareResult_Larger;
            }
            
        }else if ([arr1 count] < [arr2 count]) {
            // 版本格式深度前者小于后者
            for (int i = 0; i < [arr1 count]; i++) {
                ret1 += ([arr1[i] intValue] * pow(10, ([arr1 count] - i)));
                ret2 += ([arr2[i] intValue] * pow(10, ([arr1 count] - i)));
            }
            
            if (ret1 <= ret2) {
                return FJCompareResult_Smaller;
            }else{
                return FJCompareResult_Larger;
            }
            
        }else{
            // 版本格式深度前者大于后者
            for (int i = 0; i < [arr2 count]; i++) {
                ret1 += ([arr1[i] intValue] * pow(10, ([arr2 count] - i)));
                ret2 += ([arr2[i] intValue] * pow(10, ([arr2 count] - i)));
            }
            
            if (ret1 >= ret2) {
                return FJCompareResult_Larger;
            }else{
                return FJCompareResult_Smaller;
            }
        }
    }
    return FJCompareResult_Equal;
}


// 中国固定电话
- (BOOL)validateChineseLandLine
{
    NSString *isPhoneRegex = @"^((\\+86)|(\\(\\+86\\)))?\\W?((((010|021|022|023|024|025|026|027|028|029|852)|(\\(010\\)|\\(021\\)|\\(022\\)|\\(023\\)|\\(024\\)|\\(025\\)|\\(026\\)|\\(027\\)|\\(028\\)|\\(029\\)|\\(852\\)))\\W\\d{8}|((0[3-9][1-9]{2})|(\\(0[3-9][1-9]{2}\\)))\\W\\d{7,8}))(\\W\\d{1,4})?$";
    
    NSPredicate *phoneRegex = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", isPhoneRegex];
    
    if (([phoneRegex evaluateWithObject:self] == YES))
    {
        return YES;
    }else{
        return NO;
    }
}


// 中国移动电话
- (BOOL)validateChineseMobile
{
    NSString *isMobileRegex = @"^((\\+86)|(\\(\\+86\\)))?(((13[0-9]{1})|(15[0-9]{1})|(17[0-9]{1})|(18[0,5-9]{1}))+\\d{8})$";
    
    
    NSPredicate *mobileRegex = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", isMobileRegex];
    
    return [mobileRegex evaluateWithObject:self];
    
}


// 邮件合法性校验
- (BOOL)validateEmailAddress
{
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    if ([emailTest evaluateWithObject:self] == YES) {
        return YES;
    }else {
        return NO;
    }
}

// 用户名合法性校验,允许输入1-20位字母、数字、下划线,不能为纯数字或纯下划线
- (BOOL)validateUsername
{
    
    NSString *usernameRegEx = @"^(?!((^[0-9]+$)|(^[_]+$)))([a-zA-Z0-9_]{1,20})$";
    NSPredicate *usernameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", usernameRegEx];
    return [usernameTest evaluateWithObject:self];
}

// 两次密码的合法性校验
- (BOOL)validatePassword:(NSString *)pwd identityToAnotherPassword:(NSString *)anotherPwd
{
    if (pwd == nil || pwd.length == 0 || anotherPwd == nil || anotherPwd.length == 0) {
        return NO;
    }
    return [pwd isEqualToString:anotherPwd];
}

// 计算限宽行高（字体，宽度）
- (CGFloat)heightWithLabelFont:(UIFont *)font withLabelWidth:(CGFloat)width enableCeil:(BOOL)enableCeil {
    CGFloat height = [self sizeWithFont:font kern:0 space:0 linebreakmode:NSLineBreakByWordWrapping limitedlineHeight:0 renderSize:CGSizeMake(width, MAXFLOAT)].height;
    if (enableCeil) {
        return ceil(height);
    }
    return height;
}

// 计算单行宽度（字体）
- (CGFloat)singleWidthWithLabelFont:(UIFont *)font enableCeil:(BOOL)enableCeil {
    CGFloat singleWidth = [self sizeWithFont:font kern:0 space:0 linebreakmode:NSLineBreakByWordWrapping limitedlineHeight:0 renderSize:CGSizeMake(MAXFLOAT, 0)].width;
    if (enableCeil) {
        return ceil(singleWidth);
    }
    return singleWidth;
}

// 计算单行行高（字体）
- (CGFloat)singleHeightWithLabelFont:(UIFont *)font enableCeil:(BOOL)enableCeil {
    CGFloat singleHeight = [self sizeWithFont:font kern:0 space:0 linebreakmode:NSLineBreakByWordWrapping limitedlineHeight:0 renderSize:CGSizeMake(MAXFLOAT, 0)].height;
    if (enableCeil) {
        return ceil(singleHeight);
    }
    return  singleHeight;
}

// 限制显示行数
- (CGFloat)limitHeight:(UIFont*)font maxLineCount:(int)maxLineCount limitedlineHeight:(CGFloat)limitedlineHeight kern:(CGFloat)kern labelWidth:(CGFloat)labelWidth enableCeil:(BOOL)enableCeil
{
    CGSize size = [self sizeWithFont:font kern:kern space:0 linebreakmode:NSLineBreakByWordWrapping limitedlineHeight:limitedlineHeight renderSize:CGSizeMake(labelWidth, MAXFLOAT)];
    CGFloat maxHeight = maxLineCount * limitedlineHeight;
    if (enableCeil) {
        return  size.height > maxHeight ? ceil(maxHeight) : ceil(size.height);
    }
    return  size.height > maxHeight ? maxHeight : size.height;
}

// 计算字体渲染宽高（字体，行间距，字间距，换行模式）
- (CGSize)sizeWithFont:(UIFont*)font kern:(CGFloat)kern space:(CGFloat)space linebreakmode:(NSLineBreakMode)linebreakmode limitedlineHeight:(CGFloat)limitedlineHeight renderSize:(CGSize)renderSize {
    if (self.length == 0) {
        return CGSizeZero;
    } else if (font == nil || ![font isKindOfClass:[UIFont class]]) {
        return CGSizeZero;
    } else{
        // 字体
        NSMutableDictionary *attribute = [[NSMutableDictionary alloc] init];
        [attribute setObject:font forKey:NSFontAttributeName];
        
        // 行间距和换行模式
        NSMutableParagraphStyle *style = nil;
        if (space > 0 || linebreakmode > 0 || limitedlineHeight > 0) {
            style = [[NSMutableParagraphStyle alloc] init];
            if (space > 0) {
                style.lineSpacing = space;
            }
            if (linebreakmode > 0) {
                style.lineBreakMode = linebreakmode;
            }
            if (limitedlineHeight > 0) {
                style.minimumLineHeight = limitedlineHeight;
                style.maximumLineHeight = limitedlineHeight;
            }
            [attribute setObject:style forKey:NSParagraphStyleAttributeName];
        }
        
        // 字间距
        if (kern > 0) {
            [attribute setObject:@(kern) forKey:NSKernAttributeName];
        }
        
        // 尺寸
        CGSize size = [self boundingRectWithSize:renderSize
                                         options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                      attributes:attribute
                                         context:nil].size;
        return size;
    }
    return CGSizeZero;
}

@end
