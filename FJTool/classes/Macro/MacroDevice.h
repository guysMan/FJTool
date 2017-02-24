//
//  MacroDevice.h
//  FJTool
//
//  Created by Jeff on 2017/2/20.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#ifndef MacroDevice_h
#define MacroDevice_h

/**
 * 苹果尺寸
 */
/*
 1.iPhone4,4S   分辨率320x480，像素分别320x480和640x960，@1x，@2x
 2.iPhone5,5S   分辨率320x568，像素640x1136，@2x
 3.iPhone6      分辨率375x667，像素750x1334，@2x
 4.iPhone6 Plus 分辨率414x736，像素1242x2208，@3x
 */
#define UI_STATUS_BAR_HEIGHT      20
#define UI_NAVIGATION_BAR_HEIGHT  44
#define UI_TOP_HEIGHT             64
#define UI_TAB_BAR_HEIGHT         49
#define UI_NAVIGATIONBAR_ICON_LEN 20
#define UI_TAB_ICON_LEN           30

#define UI_I4_WIDTH    (320)
#define UI_I4_HEIGHT   (480)
#define UI_I5_WIDTH    (320)
#define UI_I5_HEIGHT   (568)
#define UI_I6_WIDTH    (375)
#define UI_I6_HEIGHT   (667)
#define UI_I6P_WIDTH   (414)
#define UI_I6P_HEIGHT  (736)

// 屏幕高宽
#define UI_SCREEN_WIDTH     ([[UIScreen mainScreen] bounds].size.width)
#define UI_SCREEN_HEIGHT    ([[UIScreen mainScreen] bounds].size.height)
#define UI_SCREEN_BOUND     ([[UIScreen mainScreen] bounds])

// 2.5是实际3倍屏的物理像素？
#define UI_RESOLUTON_WIDTH  ([[UIScreen mainScreen] bounds].size.width >= 414) ? UI_SCREEN_WIDTH * 2.5 : UI_SCREEN_WIDTH * 2
#define UI_RESOLUTON_HEIGHT ([[UIScreen mainScreen] bounds].size.height >= 736) ? UI_SCREEN_HEIGHT * 2.5 : UI_SCREEN_HEIGHT * 2

// 屏幕中心
#define UI_POINT_CENTER CGPointMake(UI_SCREEN_WIDTH / 2, UI_SCREEN_HEIGHT / 2)
#define UI_POINT_CENTER_OFFSET(x) CGPointMake(UI_SCREEN_WIDTH / 2, UI_SCREEN_HEIGHT + (x) )


#endif /* MacroDevice_h */
