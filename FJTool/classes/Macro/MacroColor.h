//
//  MacroColor.h
//  FJTool
//
//  Created by Jeff on 2017/2/20.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#ifndef MacroColor_h
#define MacroColor_h

// Original Color
#define COLOR_PURE_CLEAR               [UIColor clearColor]               // 透明
#define COLOR_PURE_WHITE               [UIColor whiteColor]               // 纯白
#define COLOR_PURE_BLACK               [UIColor blackColor]               // 纯黑

// 通用默认背景色
#define COLOR_COMMON_BG                COLOR_TEXT_PURPLE

// Dark Level
#define COLOR_GRAY_26241F              MF_COLOR_HEX(@"#26241F")         // 最深 [COLOR_GRAY_DARK]
#define COLOR_GRAY_333333              MF_COLOR_HEX(@"#333333")         // 次最深 [COLOR_GRAY_SEMIDARK]
#define COLOR_GRAY_666666              MF_COLOR_HEX(@"#666666")         // 次深 [COLOR_GRAY_DARK_SECONDARY]
#define COLOR_GRAY_999999              MF_COLOR_HEX(@"#999999")         // 中等 [COLOR_GRAY_MODERATE]
#define COLOR_GRAY_CCCCCC              MF_COLOR_HEX(@"#CCCCCC")         // 浅色 [COLOR_GRAY_MODERATE_SECONDARY]
#define COLOR_GRAY_D9D9D9              MF_COLOR_HEX(@"#D9D9D9")         // 灰色：已关注
#define COLOR_GRAY_E6E6E6              MF_COLOR_HEX(@"#E6E6E6")         // 灰色：极淡灰 [COLOR_GRAY_LIGHT]
#define COLOR_GRAY_E5E5E5              MF_COLOR_HEX(@"#E5E5E5")         // 灰色：热门分类分割线
#define COLOR_GRAY_F0F0F0              MF_COLOR_HEX(@"#F0F0F0")
#define COLOR_GRAY_F5F5F5              MF_COLOR_HEX(@"#F5F5F5")         // 灰色：几乎白 [COLOR_GRAY_WHITE]
#define COLOR_GRAY_FAFAFA              MF_COLOR_HEX(@"#FAFAFA")         // 白色 背景 [COLOR_BG_WHITE]
#define COLOR_GRAY_B3B3B3              MF_COLOR_HEX(@"#B3B3B3")         //
#define COLOR_GRAY_SEP                 MF_COLOR_HEX(@"#CCCCCC")         // iPhone的分割线颜色

// Text Color
#define COLOR_TEXT_TITLE               COLOR_GRAY_26241F                // 大标题文字,22
#define COLOR_TEXT_SUBTITLE            COLOR_GRAY_26241F                // 副标题文字,14
#define COLOR_TEXT_MAIN                COLOR_GRAY_666666                // 字体颜色，主文本,14
#define COLOR_TEXT_SECONDARY           COLOR_GRAY_999999                // 字体颜色，次文本,14
#define COLOR_TEXT_HINT                COLOR_GRAY_999999                // 字体颜色，标注文本,12
#define COLOR_TEXT_SUBHINT             COLOR_GRAY_CCCCCC                // 字体颜色，次标注文本,12
#define COLOR_TEXT_ASSISTANT           COLOR_GRAY_999999                // 字体颜色，辅助文本,10
#define COLOR_TEXT_RED                 MF_COLOR_HEX(@"#E63956")         // 红色
#define COLOR_TEXT_PURPLE              MF_COLOR_HEX(@"#F3F3F9")         // 淡淡的紫色
#define COLOR_TEXT_JACINTH             MF_COLOR_HEX(@"#F23524")         // 橘红色
#define COLOR_TEXT_WHITE               MF_COLOR_HEX(@"#FFFFFF")         // 白色
#define COLOR_TEXT_ORANGE              MF_COLOR_HEX(@"#FFAA00")         // 黄，橘黄
#define COLOR_TEXT_BANANA              MF_COLOR_HEX(@"#FFCC40")         // 黄，香蕉黄
#define COLOR_TEXT_LEMON               MF_COLOR_HEX(@"#FFD401")         // 黄，柠檬黄
#define COLOR_TEXT_GREEN               MF_COLOR_HEX(@"#00D76E")         // 绿色   // iOS绿色
#define COLOR_TEXT_BLUE                MF_COLOR_HEX(@"#00BBFB")         // 蓝色


// Blur White
#define COLOR_BLUR_WHITE_90            MF_COLOR_HEX_ALPHA(@"#FFFFFF", 0.9)   // 透明白

// Blur Black
#define COLOR_BLUR_80                  MF_COLOR_HEX_ALPHA(@"#000000",0.8)    // 透明灰
#define COLOR_BLUR_70                  MF_COLOR_HEX_ALPHA(@"#000000",0.7)    // 透明灰
#define COLOR_BLUR_50                  MF_COLOR_RGB_ALPHA(@"#000000",0.5)    // 透明灰
#define COLOR_BLUR_60                  MF_COLOR_HEX_ALPHA(@"#000000",0.6)    // 透明灰
#define COLOR_BLUR_30                  MF_COLOR_HEX_ALPHA(@"#000000",0.3)    // 透明灰(分享页)
#define COLOR_BLUR_25                  MF_COLOR_HEX_ALPHA(@"#000000",0.25)   // 透明灰
#define COLOR_BLUR_20                  MF_COLOR_HEX_ALPHA(@"#000000",0.2)    // 透明灰(PageControl)


#define COLOR_SOLID_LINE_230           MF_COLOR_HEX_ALPHA(@"#FFFFFF",0.25)    // 实线的颜色  @RGB(230,230,230)
#define COLOR_SOLID_LINE_204           MF_COLOR_HEX_ALPHA(@"#FFFFFF",0.69)    // 实线的颜色  @RGB(204,204,204)  CCCCCC
#define COLOR_SOLID_LINE               COLOR_SOLID_LINE_230


#endif /* MacroColor_h */
