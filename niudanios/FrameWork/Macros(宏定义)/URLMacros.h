//
//  URLMacros.h
//  HLLCourseLive
//
//  Created by 61_lsc on 2018/6/7.
//  Copyright © 2018年 61_lsc. All rights reserved.
//

#ifndef URLMacros_h
#define URLMacros_h



#define BsemURL_PREFIX  @"http://app.61draw.com"//发布


#define HTTP(x) [BsemURL_PREFIX stringByAppendingString:x]

///密码登录
#define URL_LoginWithPwd HTTP(@"")

#endif /* URLMacros_h */
