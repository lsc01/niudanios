//
//  HLLShareManager.m
//  HLLCourseLive
//
//  Created by 61_lsc on 2018/6/7.
//  Copyright © 2018年 61_lsc. All rights reserved.
//

#import "HLLShareManager.h"

@implementation HLLShareManager
static HLLShareManager *share = nil;
+(instancetype)shareMannager
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[HLLShareManager alloc]init];
        share.NetworkStatus = AFNetworkReachabilityStatusUnknown;
        share.registerDevice = NO;
    });
    return share;
}

@end
