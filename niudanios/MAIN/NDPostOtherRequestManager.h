//
//  NDPostOtherRequestManager.h
//  niudanios
//
//  Created by lsc on 2018/12/10.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NDPostOtherRequestManager : NSObject
///记录APP启动次数
+(void)recordAPPLaunchCount;
///记录浏览次数
+(void)recordBrowseCountWithGashaponId:(NSString *)gashaponId;

@end
