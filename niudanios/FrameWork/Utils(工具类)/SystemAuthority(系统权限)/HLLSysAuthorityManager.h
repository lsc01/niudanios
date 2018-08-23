//
//  HLLSysAuthorityManager.h
//  HLLCourseLive
//
//  Created by 61_lsc on 2018/6/7.
//  Copyright © 2018年 61_lsc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,SysPermissionType) {
    SYS_Denied = 0, //不允许
    SYS_Authorized = 1, //授权
    SYS_NotDetermined //未询问
};

typedef NS_ENUM(NSInteger,NetWorkPermission) {
    NetWork_Denied = 0, //不允许
    NetWork_WIFI = 1, //仅WIFI
    NetWork_WIFT_4G_3G //WiFi+流量
};

typedef void(^IsAllowComplated)(BOOL isAllow);
typedef void(^NotificationFinish)(NSString* deviceToken);
@interface HLLSysAuthorityManager : NSObject

/**
 *  检测是否允许访问相机
 *
 */
+ (SysPermissionType)isAllowCamera;

/**
 *  检测是否允许访问手机相册
 *
 */
+ (SysPermissionType)isAllowPhotoAlbum;

/**
 *  检测是否允许访问麦克风
 *
 */
+ (SysPermissionType)isAllowMicophone;

/**
 *  检测网络权限
 *
 */
+(void)isAllowNetWorkPermission:(IsAllowComplated)isAllowComplated;

/*** 判断是否有推送权限 ***/
+ (BOOL)isAllowRemoteNotification:(IsAllowComplated)isAllowComplated;


/**
 *  检测是否允许使用定位服务
 *
 */
+ (BOOL)isAllowLocaiton:(IsAllowComplated)isAllowComplated;


/**
 *  获取通知权限
 */
+ (void)getNotificationPermissions:(NotificationFinish)NotificationFinish;

+ (void)notificationResult:(NSString *)deviceToken error:(NSError *)error;

/**
 *  获取位置权限
 */
+ (void)getLoactionPermissions:(IsAllowComplated)isAllowComplated;

/**
 *  获取相机权限
 */
+ (void)getCameraPermissions:(IsAllowComplated)isAllowComplated;
/**
 * 获取相册权限
 */
+ (void)getPhotoPermissions:(IsAllowComplated)isAllowComplated;
/**
 *  获取麦克风权限
 */
+ (void)getMicophonePermissions:(IsAllowComplated)isAllowComplated;


+(void)alertWithTitle:(NSString *)title message:(NSString *)message;


@end
