//
//  NSString+Helper.h
//  FJTool
//
//  Created by Jeff on 2017/2/14.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TrimType)
{
    TrimType_Null,
    TrimType_WhiteSpace,
    TrimType_WhiteSpaneAndNewline
};

typedef NS_ENUM(NSInteger, TFJudgeType) {
    TFJudgeType_All,
    TFJudgeType_OnlyPhone,                      // 只判断 手机
    TFJudgeType_PhoneAndCode,                   // 只判断 手机&验证码
    TFJudgeType_PhoneAndPwd                     // 只判断 手机&密码
};

@interface NSString (Helper)

/** 
 * Basic
 */
 // 去除空格字符
- (NSString*)trimString:(TrimType)trimType;

// 是否包含相同的字符串（大小写敏感）
- (BOOL)containsStringMatchCase:(NSString *)aString;

// 是否包含相同的字符串（大小写不敏感）
- (BOOL)containsStringIgnoreCase:(NSString *)aString;

// 字符串是否相同（空格去除可控，大小写敏感）
- (BOOL)isEqualToString:(NSString *)aString trimType:(TrimType)trimType;

// 字符串是否相同（空格不可去除，大小写敏感可控）
- (BOOL)isEqualToString:(NSString *)aString ignorecase:(BOOL)ignorecase;

// 字符串是否相同（空格去除可控，大小写敏感可控）
- (BOOL)isEqualToString:(NSString *)aString trimType:(TrimType)trimType ignorecase:(BOOL)ignorecase;

// 去除所有空格，是否为空
- (BOOL)isEmptyTrimmingAllSpace;

// 截取两端字符串之间的子字符串
- (NSString *)subStringFromString:(NSString *)fromString toString:(NSString *)toString;

// 是否包含Emoji
- (BOOL)containsEmoji;

// 去除某个字符
- (NSString*)trimCharacter:(NSString*)character;

// str1是否小于str2
+ (BOOL)compareLessStr1:(NSString*)str1 thanStr2:(NSString*)str2;


/**
 * Validation
 */
// 中国固定电话
- (BOOL)validateChineseLandLine;

// 中国移动电话
- (BOOL)validateChineseMobile;

// 邮件合法性校验
- (BOOL)validateEmailAddress;

// 用户名合法性校验,允许输入1-20位字母、数字、下划线,不能为纯数字或纯下划线
- (BOOL)validateUsername;

// 两次密码的合法性校验
- (BOOL)validatePassword:(NSString *)pwd identityToAnotherPassword:(NSString *)anotherPwd;


/**
 * Attributed String
 */
// String转NSMutableAttributedString
- (NSMutableAttributedString*)attributedStringWithFont:(UIFont*)font lineHeight:(CGFloat)lineHeight kern:(CGFloat)kern color:(UIColor*)color underline:(BOOL)underline;

// String转NSMutableAttributedString(将str中匹配self或者self.capitalizedString的字体高亮显示)
- (NSMutableAttributedString*)attributedStringWithString:(NSString*)str color:(UIColor*)color highlightedcolor:(UIColor*)highlightedcolor;


/**
 * String Height
 */
// 计算宽高（字体）
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

// 计算宽高（字体、字间距）
- (CGSize)sizeWithKern:(CGFloat)kern font:(UIFont *)font maxSize:(CGSize)maxSize;

// 计算行高（字体、字间距、行间距）
- (CGFloat)heightWithLineSpace:(CGFloat)lineSpace kern:(CGFloat)kernValue font:(UIFont*)font maxSize:(CGSize)maxSize;

// 计算宽高（字体、字间距、限定行高）
- (CGSize)textSizeWithFont:(UIFont*)font lineHeight:(CGFloat)lineHeight kern:(CGFloat)kern maxWidth:(CGFloat)maxWidth;

// 限制显示行数
- (CGFloat)validHeightWithFont:(UIFont*)font maxLine:(int)lineCount lineHeight:(CGFloat)lineHeight kern:(CGFloat)kern maxWidth:(CGFloat)maxWidth;

// 计算行高（字体，限宽）
- (CGFloat)heightWithLabelFont:(UIFont *)font withLabelWidth:(CGFloat)width;

// 计算宽度（字体）
- (CGFloat)widthWithLabelFont:(UIFont *)font;


@end
