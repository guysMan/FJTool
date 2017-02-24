//
//  Macro.h
//  FJTool
//
//  Created by Jeff on 2017/2/20.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

#import "UIColor+Hex.h"

/**
 * Block Helper
 */
#if NS_BLOCKS_AVAILABLE

#define MF_BLOCK_CALL_NO_P(b) (b == nil ?: b())
#define MF_BLOCK_CALL(b, p) (b == nil ? : b(p) )
#define MF_BLOCK_CALL_2_P(b, p1, p2) (b == nil ? : b(p1, p2))
#define MF_BLOCK_CALL_3_P(b, p1, p2 , p3) (b == nil ? : b(p1, p2, p3))
#define MF_BLOCK_CALL_4_P(b, p1, p2 , p3, p4) (b == nil ? : b(p1, p2, p3, p4))

#endif


/**
 * String Helper
 */
#define MF_TRIM(x) [x stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]

#define MF_STRING_FORMAT(FORMAT, ...) [NSString stringWithFormat:FORMAT, __VA_ARGS__]

#define MF_REPLACE(raw,f,r) [raw stringByReplacingOccurrencesOfString:f withString:r]

#define MF_NULL_STR_TO_DEFAULT(str, default) (str ?: default)

#define MF_EMPTY_STR_TO_DEFAULT(str, default) (str ? (str.length == 0 ? default : str ) : default)

#define MF_NULL_STR_DEFAULT_TO_EMPTY(str) NULL_STR(str, @"")

#define MF_NULL_ARRAY_TO_DEFAULT(o, default) (o ? o : default)

#define MF_NULL_ARRAY_DEFAULT_TO_EMPTY(o) (o ? o : [NSArray array])

#define MF_SI(i) [NSString stringWithFormat:@"%d", i]

#define MF_SNI(ni) [NSString stringWithFormat:@"%d", [ni intValue]]

#define MF_S_A_T(a,t) [NSString stringWithFormat:@"%d/%d", a,t]

#define MF_JOIN_STRING( s, ... ) [NSString stringWithFormat:(s), ##__VA_ARGS__]

#define MF_NULL_OR_EMPTY(str) (str == nil || str.length == 0)

#define MF_NULL_OR_EMPTY_TRIMSPACE(str) (str == nil || str.length == 0 || [str stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]].length == 0)


/**
 * Color Helper
 */
#define MF_COLOR_HEX(h)             [UIColor colorWithHexString:h]
#define MF_COLOR_HEX_ALPHA(h,a)     [UIColor colorWithHexString:h withAlpha:a]
#define MF_COLOR_RGB(r,g,b)         [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define MF_COLOR_RGB_ALPHA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

/**
 * Resource Helper
 */
#define MF_PNG_FROM_MAINBUNDLE(name) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:@"png"]]

#define MF_JSON_FROM_MAINBUNDLE(name) [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:@"json"] encoding:NSUTF8StringEncoding error:nil]

#define MF_DOCUMENTS_FROM_MAINBUNDLE() [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Documents"]

#define MF_HTML_FROM_MAINBUNDLE(name) [[NSBundle mainBundle] URLForResource:name withExtension:@"html"]

#define MF_DOCUMENTS_FOLDER() [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]

#define MF_FILE_EXIST(fullPath) [[NSFileManager defaultManager] fileExistsAtPath:fullPath]

#define MF_LOAD_NIB(x) [[[NSBundle mainBundle] loadNibNamed:x owner:nil options:nil] lastObject]

#define MF_LOAD_NIB_SELF(x) [[[NSBundle mainBundle] loadNibNamed:x owner:self options:nil] objectAtIndex:0]

/**
 * Notification Helper
 */
#define MF_AddN(_selector,_name)\
([[NSNotificationCenter defaultCenter] addObserver:self selector:_selector name:_name object:nil])

#define MF_AddN_Block(_name, _block)\
[[NSNotificationCenter defaultCenter] addObserverForName:_name object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {\
if (_block) {\
_block();\
}\
}];

#define MF_RemoveNObserverWithName(_name)\
([[NSNotificationCenter defaultCenter] removeObserver:self name:_name object:nil])

#define MF_RemoveNObserver() ([[NSNotificationCenter defaultCenter] removeObserver:self])

#define MF_PostN(_name)\
([[NSNotificationCenter defaultCenter] postNotificationName:_name object:nil userInfo:nil])

#define MF_PostNWithObj(_name,_obj)\
([[NSNotificationCenter defaultCenter] postNotificationName:_name object:_obj userInfo:nil])

#define MF_PostNWithInfos(_name,_obj,_infos)\
([[NSNotificationCenter defaultCenter] postNotificationName:_name object:_obj userInfo:_infos])


/**
 * 判断iOS系统版本
 */
#define MF_VERSION_OVER_OR_EQUAL(a) ([[[UIDevice currentDevice] systemVersion] floatValue] >= a)

#define MF_VERSION_OVER(a) ([[[UIDevice currentDevice] systemVersion] floatValue] > a)


/**
 * Logger Helper
 */
#define MF_LOG_FUNC_ENTER  NSLog(@"CALL BEGIN:%s---%s\n",__func__,__FILE__);

#define MF_LOG_FUNC_LEAVE    NSLog(@"CALL END  :%s---%s\n",__func__,__FILE__);

#define MF_LOG_FUNC_START  do{}while(0);

#define MF_LOG_FUNC_END    do{}while(0);

// Debug Log
#ifdef DEBUG
#define MF_LOG(...) NSLog(__VA_ARGS__)
#else
#define MF_LOG(...)
#endif

// 时间开始和结束
#define MF_START(n) NSLog(@"[%@]Started @ %f", n, [[NSDate date] timeIntervalSince1970]);
#define MF_END(n)   NSLog(@"[%@]Ended @ %f", n, [[NSDate date] timeIntervalSince1970]);

/**
 * Runtime Helper
 */
#define MF_OBJ_CLASS(a) [NSString stringWithUTF8String:object_getClassName(a)]

/**
 *  weskSelf
 */
#define MF_WEAK_SELF(o)   __weak typeof(o) weakSelf = o;


/**
 *  Money Format Helper
 */
#define MF_ROUND_STR(a)       roundf([a floatValue])

#define MF_ROUND_FLOAT(a)     roundf((float)a)

#define MF_RMB_FEN_STR(a)     [NSString stringWithFormat:@"¥%.0f", (float)roundf( [a floatValue] / 100.0 ) ]

#define MF_RMB_YUAN_STR(a)    [NSString stringWithFormat:@"¥%.0f", MF_ROUND_STR(a)]

#define MF_RMB_FEN_FLOAT(a)   [NSString stringWithFormat:@"¥%.0f", (float) roundf( ((float)a) / 100.0 ) ]

#define MF_RMB_YUAN_FLOAT(a)  [NSString stringWithFormat:@"¥%.0f", MF_ROUND_FLOAT(a)]

// 输入货币单位a($), 值(100)
#define MF_CUR_FEN_FLOAT(a, b)   [NSString stringWithFormat:@"%@%.0f", a, (float) roundf( ((float)b) / 100.0 ) ]

/**
 *  设置StatusBar背景颜色
 */
#define MF_SET_STATUS_BAR_STYLE(a) [UIApplication sharedApplication].statusBarStyle = a;

/**
 *  URL Helper
 */
#define MF_URL(a)   [NSURL URLWithString:a]
#define MF_IF_URL(url) ([url containsString:@"http://"] || [url containsString:@"https://"])

/**
 *  Device Helper
 */
#define MF_IF_IP4   ([[UIScreen mainScreen] bounds].size.width == 320 && [[UIScreen mainScreen] bounds].size.height == 480)
#define MF_IF_IP5   ([[UIScreen mainScreen] bounds].size.width == 320 && [[UIScreen mainScreen] bounds].size.height == 568)
#define MF_IF_IP6   ([[UIScreen mainScreen] bounds].size.width == 375 && [[UIScreen mainScreen] bounds].size.height == 667)
#define MF_IF_IP6P  ([[UIScreen mainScreen] bounds].size.width == 414 && [[UIScreen mainScreen] bounds].size.height == 736)

/**
 *  UIStoryboard
 */
#define MF_Storyboard(storyboard,identifier) [[UIStoryboard storyboardWithName:storyboard bundle:nil] instantiateViewControllerWithIdentifier:identifier]

/**
 *  isKindOfClass / isMemberOfClass
 */
#define MF_IsKind(object,class)   [object isKindOfClass:class]
#define MF_IsMember(object,class) [object isMemberOfClass:class]

/**
 *  info.plist
 */
#define MF_APP_NAME       [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
#define MF_APP_VERSION    [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define MF_BUNDLE_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

/**
 *  Window
 */
#define MF_Key_Window [[UIApplication sharedApplication].delegate window]

/**
 *  Math
 */
#define MF_BELOW_EQUAL_MAX(n,max) (((int)n >= (int)max) ? (int)max-1 : (int)n)
#define MF_BELOW_EQUAL_MAX_TXT(n,max) [NSString stringWithFormat:@"%d", MF_BELOW_EQUAL_MAX(n,max)]

/**
 *  Wrapper / UnWrapper
 */
#define MF_WRAP_BOOLT(b)     [NSNumber numberWithBool:b]
#define MF_WRAP_CHAR(c)      [NSNumber numberWithChar:c]
#define MF_WRAP_INT(n)       [NSNumber numberWithInt:n]
#define MF_WRAP_FLOAT(f)     [NSNumber numberWithFloat:f]
#define MF_WRAP_DOUBLE(d)    [NSNumber numberWithDouble:d]
#define MF_WRAP_SHORT(s)     [NSNumber numberWithShort:s]
#define MF_WRAP_LONG(l)      [NSNumber numberWithLong:l]
#define MF_WRAP_LONGLONG(ll) [NSNumber numberWithLongLong:ll]

#define MF_UNWRAP_BOOLT(b)     [b boolValue]
#define MF_UNWRAP_CHAR(c)      [c charValue]
#define MF_UNWRAP_INT(n)       [n intValue]
#define MF_UNWRAP_FLOAT(f)     [f floatValue]
#define MF_UNWRAP_DOUBLE(d)    [d doubleValue]
#define MF_UNWRAP_SHORT(s)     [s shortValue]
#define MF_UNWRAP_LONG(l)      [l longValue]
#define MF_UNWRAP_LONGLONG(ll) [ll longLongValue]

/**
 *  int switch string each other
 */
#define MF_STR(a)   [NSString stringWithFormat:@"%d",a]
#define MF_INT(x)   [x intValue]
#define MF_FLOAT(x) [x floatValue]


#endif /* Macro_h */
