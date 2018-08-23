//
//  HLLNetworkSpeed.h
//  HLLCourseLive
//
//  Created by 61_lsc on 2018/7/18.
//  Copyright © 2018年 61_lsc. All rights reserved.
//
//链接：https://www.jianshu.com/p/92cdf01c291a
//來源：简书

#import <Foundation/Foundation.h>
// 88kB/s
extern NSString * const GSDownloadNetworkSpeedNotificationKey;
// 2MB/s
extern NSString * const GSUploadNetworkSpeedNotificationKey;

typedef void(^NetworkSpeedStringCompleted)(NSString * uploadNetworkSpeed ,NSString * downloadNetworkSpeed);
typedef void(^NetworkSpeedIntergeCompleted)(long long uploadNetworkSpeed, long long downloadNetworkSpeed);

@interface HLLNetworkSpeed : NSObject

@property (nonatomic, copy, readonly) NSString * downloadNetworkSpeed;
@property (nonatomic, copy, readonly) NSString * uploadNetworkSpeed;

+ (instancetype)shareNetworkSpeed;

///使用计时器监听网速，ti 时间间隔
- (void)startWithTimeInterval:(NSTimeInterval)ti;
///使用计时器监听网速，默认1秒间隔
- (void)start;
///停止计时器监听
- (void)stop;


#pragma mark - 下面获取方法与计时器监听最好不要同时使用
///获取网速 上行/下行 字符串格式
-(void)getNetworkStringSpeed:(NetworkSpeedStringCompleted)completed;
///获取网速 上行/下行 整型格式
-(void)getNetworkIntergeSpeed:(NetworkSpeedIntergeCompleted)completed;
@end
