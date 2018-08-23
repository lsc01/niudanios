//
//  ColorMacros.h
//  HLLCourseLive
//
//  Created by 61_lsc on 2018/6/7.
//  Copyright © 2018年 61_lsc. All rights reserved.
//

#ifndef ColorMacros_h
#define ColorMacros_h


//色值
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)
//HEX
#define HEXCOLOR(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:1]

#define COLOR_RGB(rgbValue,a) [UIColor colorWithRed:((float)(((rgbValue) & 0xFF0000) >> 16))/255.0 green:((float)(((rgbValue) & 0xFF00)>>8))/255.0 blue: ((float)((rgbValue) & 0xFF))/255.0 alpha:(a)]


#define kLineColor 0xeeeeee //线颜色
#define kTitleColor 0x111111 //标题色
#define kitemTitleColor 0x666666  //子标题色
#define kdesribeColor 0x999999    //描述小标题色
#define kbackgroundColor 0xf4f4f4 //背景色
#define kshadowColor 0xBABABA //阴影色
#define kshadowOpacity 0.7f //阴影透明度
#define kblueColor 0x3fabf4 //蓝色
#define kredColor 0xfd664e //红色
#define kborderColor 0xeeeeee //普通边框色
#define kyellowBorderColor 0xFDF086 //黄色边框
#define kblackBorderColor 0x111111 //黑色边框
#define kyellowColor 0xFDF086  //黄色
#define kButtonDisableColor 0xf2f2f2
#define kButtonHighLightColor 0xd0d0d0
#define kyellowBgColor   0xfdfae9//淡黄色
#define kWhiteColor 0xffffff//白色
#define kplaceholderColor 0xbbbbbb//提示颜色
#define kOrangeColor 0xff9802



#endif /* ColorMacros_h */
