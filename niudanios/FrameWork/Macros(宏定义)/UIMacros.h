//
//  UIMacros.h
//  HLLCourseLive
//
//  Created by 61_lsc on 2018/6/7.
//  Copyright © 2018年 61_lsc. All rights reserved.
//

#ifndef UIMacros_h
#define UIMacros_h

// MainScreen Height&Width
#define kScreenHeight      [[UIScreen mainScreen] bounds].size.height
#define kScreenWidth       [[UIScreen mainScreen] bounds].size.width

// App Frame Height&Width
#define App_Frame_Height        [[UIScreen mainScreen] applicationFrame].size.height
#define App_Frame_Width         [[UIScreen mainScreen] applicationFrame].size.width

//获取View的属性
#define GetViewWidth(view)  view.frame.size.width
#define GetViewHeight(view) view.frame.size.height
#define GetViewX(view)      view.frame.origin.x
#define GetViewY(view)      view.frame.origin.y



// 状态栏和导航栏的高度
#define kNavigationBarAndStateBarHeight (44.0f+kStateBarHeight)
#define kTabbarHeight (49.0f+kBottomHeight)
#define kStateBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
//底部
#define kBottomHeight (isIPhoneX ? 34 : 0)



#endif /* UIMacros_h */
