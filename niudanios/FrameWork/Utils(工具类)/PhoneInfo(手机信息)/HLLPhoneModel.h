//
//  HLLPhoneModel.h
//  HLLCourseLive
//
//  Created by 61_lsc on 2018/6/22.
//  Copyright © 2018年 61_lsc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLLPhoneModel : NSObject

@property (strong,nonatomic,readonly) NSString *PhoneType;
@property (strong,nonatomic,readonly) NSString *SystemVersion;
@property (strong,nonatomic,readonly) NSString *UUIDString;
@property (strong,nonatomic,readonly) NSString *AppVersion;

/*设备名称*/
+(const NSString *)getPhoneName;
/*设备类型*/
+(const NSString *)getDeviceType;
/*系统版本*/
+(const NSString *)getSystemVersion;
/*UUID*/
+(const NSString *)getUUIDString;
/*APP名字*/
+(const NSString *)getAPPName;
/*APP版本*/
+(NSString *)getAppVersion;
/** 获取设备类型名称 */
+ (const NSString *)getDiviceTypeName;
/** 获取设备ip */
+ (const NSString *)getDeviceIPAddresses;
/*WIFI*/
+ (const NSString *)getIpAddressWIFI;
/*蜂窝*/
+ (const NSString *)getIpAddressCell;
/*获取当前网络类型*/
+ (const NSString *)getCurrNetType;

///获取设备总内存
+ (int64_t)getTotalMemory;
///获取设备总内存
+ (NSString *)getTotalMemoryString;
///获取当前任务所占用内存
+ (int64_t)getUsedMemory;
///获取当前任务所占用内存
+ (NSString *)getUsedMemoryString;
@end
