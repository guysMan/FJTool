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
    if (trimType == TrimType_WhiteSpace) {
        newStr = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    }else if (trimType == TrimType_WhiteSpaneAndNewline) {
        newStr = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }else{
        newStr = self;
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

// 截取两端字符串之间的子字符串
- (NSString *)subStringFromString:(NSString *)fromString toString:(NSString *)toString {
    
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

// str1是否小于str2
+ (BOOL)compareLessStr1:(NSString*)str1 thanStr2:(NSString*)str2 {
    NSArray *arr1 = [str1 componentsSeparatedByString:@"."];
    NSArray *arr2 = [str2 componentsSeparatedByString:@"."];
    
    if (arr1 == nil || [arr1 count] == 0 ||
        arr2 == nil || [arr2 count] == 0) {
        return NO;
    }
    
    int ret1 = 0;
    int ret2 = 0;
    if ([arr1 count] == [arr2 count]) {
        
        for (int i = 0; i < [arr1 count]; i++) {
            ret1 += ([arr1[i] intValue] * pow(10, ([arr1 count] - i)));
            ret2 += ([arr2[i] intValue] * pow(10, ([arr2 count] - i)));
        }
        
        return ret1 < ret2;
        
    }else if ([arr1 count] < [arr2 count]) {
        
        for (int i = 0; i < [arr1 count]; i++) {
            ret1 += ([arr1[i] intValue] * pow(10, ([arr1 count] - i)));
            ret2 += ([arr2[i] intValue] * pow(10, ([arr1 count] - i)));
        }
        
        if (ret1 <= ret2) {
            return YES;
        }else{
            return NO;
        }
        
    }else{
        
        for (int i = 0; i < [arr2 count]; i++) {
            ret1 += ([arr1[i] intValue] * pow(10, ([arr2 count] - i)));
            ret2 += ([arr2[i] intValue] * pow(10, ([arr2 count] - i)));
        }
        
        if (ret1 >= ret2) {
            return NO;
        }else{
            return YES;
        }
        
    }
    return NO;
    
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
    return [pwd isEqualToString:anotherPwd];
}

// String转NSMutableAttributedString
- (NSMutableAttributedString*)attributedStringWithFont:(UIFont*)font lineHeight:(CGFloat)lineHeight kern:(CGFloat)kern color:(UIColor*)color underline:(BOOL)underline
{
    NSRange txtRange = NSMakeRange(0, self.length);
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:self];
    
    if (lineHeight > 0) {
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.minimumLineHeight = lineHeight;
        style.maximumLineHeight = lineHeight;
        style.lineBreakMode = NSLineBreakByTruncatingTail;
        [attrStr addAttribute:NSParagraphStyleAttributeName value:style range:txtRange];
    }
    
    [attrStr addAttribute:NSKernAttributeName value:@(kern) range:txtRange];
    if (font) {
        [attrStr addAttribute:NSFontAttributeName value:font range:txtRange];
    }
    if (color) {
        [attrStr addAttribute:NSForegroundColorAttributeName value:color range:txtRange];
    }
    if (underline) {
        [attrStr addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:txtRange];
    }
    
    return attrStr;
}

// String转NSMutableAttributedString(将str中匹配self或者self.capitalizedString的字体高亮显示)
- (NSMutableAttributedString*)attributedStringWithString:(NSString*)str color:(UIColor*)color highlightedcolor:(UIColor*)highlightedcolor
{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attrStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, str.length)];
    
    if ([str containsString:[self capitalizedString]]) {
        
        NSRange range = [str rangeOfString:[self capitalizedString]];
        [attrStr addAttribute:NSForegroundColorAttributeName value:highlightedcolor range:range];
        
    } else if ([str containsString:self]) {
        
        NSRange range = [str rangeOfString:self];
        [attrStr addAttribute:NSForegroundColorAttributeName value:highlightedcolor range:range];
    }
    
    return attrStr;
}

// 计算宽高（字体）
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *attr = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attr context:nil].size;
}

// 计算宽高（字体、字间距）
- (CGSize)sizeWithKern:(CGFloat)kern font:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *attr = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, [NSNumber numberWithFloat:kern], NSKernAttributeName, nil];
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attr context:nil].size;
}

// 计算行高（字体、字间距、行间距）
- (CGFloat)heightWithLineSpace:(CGFloat)lineSpace kern:(CGFloat)kernValue font:(UIFont*)font maxSize:(CGSize)maxSize
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpace;
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    
    NSDictionary *attr = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, paragraphStyle, NSParagraphStyleAttributeName,@(kernValue), NSKernAttributeName, nil];
    CGSize size = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attr context:nil].size;
    
    return size.height + lineSpace;
}

// 计算宽高（字体、字间距、限定行高）
- (CGSize)textSizeWithFont:(UIFont*)font lineHeight:(CGFloat)lineHeight kern:(CGFloat)kern maxWidth:(CGFloat)maxWidth
{
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.minimumLineHeight = lineHeight;
    style.maximumLineHeight = lineHeight;
    style.lineBreakMode = NSLineBreakByCharWrapping;
    
    CGSize maxSize = CGSizeMake(maxWidth, MAXFLOAT);
    
    NSDictionary *attrDict = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, style, NSParagraphStyleAttributeName, @(kern), NSKernAttributeName, nil];
    CGSize txtSize = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrDict context:nil].size;
    
    return txtSize;
}

// 限制显示行数
- (CGFloat)validHeightWithFont:(UIFont*)font maxLine:(int)lineCount lineHeight:(CGFloat)lineHeight kern:(CGFloat)kern maxWidth:(CGFloat)maxWidth
{
    CGSize size = [self textSizeWithFont:font lineHeight:lineHeight kern:kern maxWidth:maxWidth];
    CGFloat maxHeight = lineCount*lineHeight;
    return size.height > maxHeight ? maxHeight : size.height;
}

// 计算行高（字体，限宽）
- (CGFloat)heightWithLabelFont:(UIFont *)font withLabelWidth:(CGFloat)width {
    CGFloat height = 0;
    
    if (self.length == 0) {
        height = 0;
    } else {
        
        // 字体
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:18.f]};
        if (font) {
            attribute = @{NSFontAttributeName: font};
        }
        
        // 尺寸
        CGSize retSize = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                            options:
                          NSStringDrawingTruncatesLastVisibleLine |
                          NSStringDrawingUsesLineFragmentOrigin |
                          NSStringDrawingUsesFontLeading
                                         attributes:attribute
                                            context:nil].size;
        
        height = retSize.height;
    }
    
    return height;
}

// 计算宽度（字体）
- (CGFloat)widthWithLabelFont:(UIFont *)font {
    CGFloat retHeight = 0;
    
    if (self.length == 0) {
        retHeight = 0;
    } else {
        
        // 字体
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:18.f]};
        if (font) {
            attribute = @{NSFontAttributeName: font};
        }
        
        // 尺寸
        CGSize retSize = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, 0)
                                            options:
                          NSStringDrawingTruncatesLastVisibleLine |
                          NSStringDrawingUsesLineFragmentOrigin |
                          NSStringDrawingUsesFontLeading
                                         attributes:attribute
                                            context:nil].size;
        
        retHeight = retSize.width;
    }
    
    return retHeight;
}


@end
