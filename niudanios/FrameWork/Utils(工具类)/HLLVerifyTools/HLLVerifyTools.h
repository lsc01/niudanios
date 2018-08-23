//
//  HLLVerifyTools.h
//  HLLCourseLive
//
//  Created by 61_lsc on 2018/8/9.
//  Copyright © 2018年 61_lsc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLLVerifyTools : NSObject
///身份证验证
+(BOOL)hllVerifyIDCard:(NSString *)userID;
/// 判断是否是有效的中文名
+ (BOOL)hllVerifyName:(NSString *)realName;
///验证手机号
+ (BOOL)hllVerifyMobile:(NSString *)mobile;
///验证是否为数字字符串
+ (BOOL)hllIsNum:(NSString *)checkedNumString;


@end
