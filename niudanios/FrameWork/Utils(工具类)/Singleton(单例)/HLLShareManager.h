//
//  HLLShareManager.h
//  HLLCourseLive
//
//  Created by 61_lsc on 2018/6/7.
//  Copyright © 2018年 61_lsc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworkReachabilityManager.h>
#import "NDUserInfoModel.h"
@interface HLLShareManager : NSObject
+(instancetype)shareMannager;
//网络连接状态
@property(nonatomic,assign) AFNetworkReachabilityStatus NetworkStatus;
///用户信息
@property (nonatomic ,strong) NDUserInfoModel * userModel;

@end
