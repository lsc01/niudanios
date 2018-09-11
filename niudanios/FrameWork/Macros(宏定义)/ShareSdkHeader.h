//
//  ShareSdkHeader.h
//  niudanios
//
//  Created by lsc on 2018/9/11.
//  Copyright © 2018年 lsc. All rights reserved.
//

#ifndef ShareSdkHeader_h
#define ShareSdkHeader_h
#import <ShareSDKConnector/ShareSDKConnector.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"

//新浪微博SDK头文件
#import "WeiboSDK.h"
//新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"
#import <ShareSDKUI/ShareSDK+SSUI.h>
#endif /* ShareSdkHeader_h */
