//
//  Macros.h
//  HLLCourseLive
//
//  Created by 61_lsc on 2018/5/30.
//  Copyright © 2018年 61_lsc. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)

#else
#define NSLog(...) 

#endif

//判断是否是iPhoneX
#define isIPhoneX [UIScreen mainScreen].bounds.size.width == 375.0f && [UIScreen mainScreen].bounds.size.height == 812.0f
// 是否iPad
//#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//弱引用
#define WeakThis(name) __weak typeof(self) name= self
#define WeakSelf() __weak typeof(self) weakself=self
#define StrongSelf() __strong typeof(self) strongself=weakself


// 当前版本
#define SystemVersionF          ([[[UIDevice currentDevice] systemVersion] floatValue])
#define SystemVersionD          ([[[UIDevice currentDevice] systemVersion] doubleValue])
#define SystemVersionS          ([[UIDevice currentDevice] systemVersion])

// 是否IOS6
#define isIOS6                  ([[[UIDevice currentDevice]systemVersion]floatValue] < 7.0)
// 是否IOS7
#define isGreaterIOS7           ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0)
//是否是IOS8
#define isIOS8                  ([[[UIDevice currentDevice]systemVersion]floatValue] >=8.0)
//是否是IOS9
#define isIOS9                  ([[[UIDevice currentDevice]systemVersion]floatValue] >=9.0)
//是否是IOS10
#define isIOS10                  ([[[UIDevice currentDevice]systemVersion]floatValue] >=10.0)
//是否是IOS11
#define isIOS11                 @available(iOS 11.0, *)


// 是否空对象
#define IS_NULL_CLASS(OBJECT) [OBJECT isKindOfClass:[NSNull class]]

//是否空对象或则是nil
#define NotNilAndNull(_ref)  (((_ref) != nil) && (![(_ref) isEqual:[NSNull null]]))
#define IsNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))


//App版本号
#define APPVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]


#define Is_Login ([HLLShareManager shareMannager].userModel!=nil)

#endif /* Macros_h */
