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
    TrimType_Default,                  // 默认（去除两端的空格）
    TrimType_WhiteSpace,               // 去除两端的空格
    TrimType_WhiteSpaneAndNewline,     // 去除两端的空格和回车
    TrimType_AllSpace                  // 去除所有的空格
};

typedef NS_ENUM(NSInteger, FJCompareResult) {
    FJCompareResult_Equal,   // 相等
    FJCompareResult_Larger,  // 左边比右边大
    FJCompareResult_Smaller  // 左边比右边小
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

// 截取两段字符串之间的子字符串
- (NSString *)substringWithFromSting:(NSString *)fromString toString:(NSString *)toString;

// 是否包含Emoji
- (BOOL)containsEmoji;

// 去除某个字符
- (NSString*)trimCharacter:(NSString*)character;

// 用户比较APP版本大小(类似1.1.1<2.0等)
+ (FJCompareResult)compare:(NSString*)str1 than:(NSString*)str2;


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
