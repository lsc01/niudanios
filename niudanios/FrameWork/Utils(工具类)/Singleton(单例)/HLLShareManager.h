//
//  HLLShareManager.h
//  HLLCourseLive
//
//  Created by 61_lsc on 2018/6/7.
//  Copyright © 2018年 61_lsc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworkReachabilityManager.h>
@interface HLLShareManager : NSObject
+(instancetype)shareMannager;
//网络连接状态
@property(nonatomic,assign) AFNetworkReachabilityStatus NetworkStatus;

@property (nonatomic ,assign ,getter=isRegisterDevice) BOOL registerDevice;
///记录从第三方进入应用的登录码
@property (nonatomic ,copy) NSString * loginCode;
///记录是否需要检查更新 1已检查需要强制更新 0 为检查更新  -1 已检查不需要强制更新
@property (nonatomic ,assign) NSInteger updateAppFlag;
@end
