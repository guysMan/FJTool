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

// 获取字符串Byte数（汉字2byte，英文1byte）
- (NSUInteger)bytesLenght;

// 首字母是否是英文字母
- (BOOL)isLetter;

// 首字母是否小写
- (BOOL)isLowerCaseLetter;

// 首字母是否大写
- (BOOL)isUpperCaseLetter;

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
// 计算限宽行高（字体，宽度）
- (CGFloat)heightWithLabelFont:(UIFont *)font withLabelWidth:(CGFloat)width enableCeil:(BOOL)enableCeil;

// 计算单行宽度（字体）
- (CGFloat)singleWidthWithLabelFont:(UIFont *)font enableCeil:(BOOL)enableCeil;

// 计算单行行高（字体）
- (CGFloat)singleHeightWithLabelFont:(UIFont *)font enableCeil:(BOOL)enableCeil;

// 限制显示行数
- (CGFloat)limitHeight:(UIFont*)font maxLineCount:(int)maxLineCount limitedlineHeight:(CGFloat)limitedlineHeight kern:(CGFloat)kern labelWidth:(CGFloat)labelWidth enableCeil:(BOOL)enableCeil;

// 计算字体渲染宽高（字体，行间距，字间距，换行模式）
- (CGSize)sizeWithFont:(UIFont*)font kern:(CGFloat)kern space:(CGFloat)space linebreakmode:(NSLineBreakMode)linebreakmode limitedlineHeight:(CGFloat)limitedlineHeight renderSize:(CGSize)renderSize;


@end
