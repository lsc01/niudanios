//
//  HLLSysAuthorityManager.m
//  HLLCourseLive
//
//  Created by 61_lsc on 2018/6/7.
//  Copyright © 2018年 61_lsc. All rights reserved.
//

#import "HLLSysAuthorityManager.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <CoreLocation/CoreLocation.h>
#import <Photos/PHPhotoLibrary.h>
@import CoreTelephony;
#import "HLLGetCurrentVC.h"
@implementation HLLSysAuthorityManager


+ (SysPermissionType)isAllowCamera
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authStatus == AVAuthorizationStatusNotDetermined){
        return SYS_NotDetermined;
    }else if (authStatus == AVAuthorizationStatusAuthorized){
        return SYS_Authorized;
    }else{
        return SYS_Denied;
    }
    
}

+ (SysPermissionType)isAllowPhotoAlbum
{
    ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
    if(authStatus == PHAuthorizationStatusNotDetermined){
        return SYS_NotDetermined;
    }else if (authStatus == PHAuthorizationStatusAuthorized){
        return SYS_Authorized;
    }else{
        return SYS_Denied;
    }
}

+ (SysPermissionType)isAllowMicophone
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    if(authStatus == AVAuthorizationStatusNotDetermined){
        return SYS_NotDetermined;
    }else if (authStatus == AVAuthorizationStatusAuthorized){
        return SYS_Authorized;
    }else{
        return SYS_Denied;
    }
}


+ (BOOL)isAllowRemoteNotification:(IsAllowComplated)isAllowComplated{
    if (isIOS8) {
        // 设置里的通知总开关是否打开
        BOOL settingEnabled = [[UIApplication sharedApplication] isRegisteredForRemoteNotifications];
        // 设置里的通知各子项是否都打开
        BOOL subsettingEnabled = [[UIApplication sharedApplication] currentUserNotificationSettings].types != UIUserNotificationTypeNone;
        if (settingEnabled&&subsettingEnabled) {
            isAllowComplated?isAllowComplated(YES):nil;
            
            return YES;
        }else{
            isAllowComplated?isAllowComplated(NO):nil;
//            [self alertWithTitle:@"设置推送通知权限" message:@"请在系统的“设置”选项中，允许通知"];
            return NO;
        }
    }
    return YES;
}


+ (BOOL)isAllowLocaiton:(IsAllowComplated)isAllowComplated
{
    if ([CLLocationManager locationServicesEnabled]) {
        //
        isAllowComplated?isAllowComplated(YES):nil;
        return YES;
    }else{
        isAllowComplated?isAllowComplated(NO):nil;
//        [self alertWithTitle:@"设置位置访问权限" message:@"请在系统的“设置”选项中，允许使用位置信息"];
        return NO;
    }
}



/**
 *  获取通知权限
 */
+ (void)getNotificationPermissions:(NotificationFinish)NotificationFinish{
    
}
+ (void)notificationResult:(NSString *)deviceToken error:(NSError *)error{
    
}

/**
 *  获取位置权限
 */
+ (void)getLoactionPermissions:(IsAllowComplated)isAllowComplated{
    
}

/**
 *  获取相机权限
 */
+ (void)getCameraPermissions:(IsAllowComplated)isAllowComplated{
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        NSLog(@"%@",granted ? @"相机准许":@"相机不准许");
        dispatch_async(dispatch_get_main_queue(), ^{
            isAllowComplated?isAllowComplated(granted):nil;
            if (!granted) {
//                [HLLSysAuthorityManager alertWithTitle:@"设置相机访问权限" message:@"请在系统的“设置”选项中，允许访问相机"];
            }
        });
        
    }];
}


/**
 * 获取相册权限
 */
+ (void)getPhotoPermissions:(IsAllowComplated)isAllowComplated{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        BOOL isAllow = NO;
        if (status == PHAuthorizationStatusAuthorized || status ==PHAuthorizationStatusNotDetermined){
            isAllow = YES;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            isAllowComplated?isAllowComplated(isAllow):nil;
            if (!isAllow) {
//                 [HLLSysAuthorityManager alertWithTitle:@"设置相册访问权限" message:@"请在系统的“设置”选项中，允许访问相册"];
            }
        });
    }];
}

/**
 *  获取麦克风权限
 */
+ (void)getMicophonePermissions:(IsAllowComplated)isAllowComplated{
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
        NSLog(@"%@",granted ? @"麦克风准许":@"麦克风不准许");
        dispatch_async(dispatch_get_main_queue(), ^{
            isAllowComplated?isAllowComplated(granted):nil;
            if (!granted) {
//                [HLLSysAuthorityManager alertWithTitle:@"设置麦克风访问权限" message:@"请在系统的“设置”选项中，允许访问麦克风"];
            }
        });
    }];
}

//系统弹窗
+(void)alertWithTitle:(NSString *)title message:(NSString *)message{
    UIAlertController * alter = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    
//    [alter addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//    }]];
    
    [alter addAction:[UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *settingUrl = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:settingUrl]) {
            [[UIApplication sharedApplication] openURL:settingUrl];
        }
    }]];
    
    [[HLLGetCurrentVC getCurrentVC] presentViewController:alter animated:YES completion:^{
        
    }];
}

/**
 *  检测网络权限
 *
 */
+(void)isAllowNetWorkPermission:(IsAllowComplated)isAllowComplated{
    if (@available(iOS 9.0, *)) {
        CTCellularData *cellularData = [[CTCellularData alloc] init];
    
        cellularData.cellularDataRestrictionDidUpdateNotifier = ^(CTCellularDataRestrictedState state){
            switch (state) {
                case kCTCellularDataRestrictedStateUnknown:
                    // app网络权限不确定
                    // 各种操作
                    NSLog(@"app网络权限不确定");
                    switch ([HLLShareManager shareMannager].NetworkStatus) {
                        case AFNetworkReachabilityStatusUnknown:
                        case AFNetworkReachabilityStatusNotReachable:
                        {
                            isAllowComplated?isAllowComplated(NO):nil;
                            NSLog(@"app网络权限受限——");
                        }
                            break;
                        case AFNetworkReachabilityStatusReachableViaWiFi:
                        case AFNetworkReachabilityStatusReachableViaWWAN:
                        {
                            isAllowComplated?isAllowComplated(YES):nil;
                            NSLog(@"app网络权限不受限——");
                        }
                            break;
                            
                        default:
                            break;
                    }
                    
                    break;
                case kCTCellularDataRestricted:
                    // app网络权限受限
                    //各种操作
                    
                    switch ([HLLShareManager shareMannager].NetworkStatus) {
                        case AFNetworkReachabilityStatusUnknown:
                        case AFNetworkReachabilityStatusNotReachable:
                        {
                            isAllowComplated?isAllowComplated(NO):nil;
                            NSLog(@"app网络权限受限");
                        }
                            break;
                        case AFNetworkReachabilityStatusReachableViaWiFi:
                        case AFNetworkReachabilityStatusReachableViaWWAN:
                        {
                            isAllowComplated?isAllowComplated(YES):nil;
                            NSLog(@"app只允许使用wifi");
                        }
                            break;
                            
                        default:
                            break;
                    }
                    
                    break;
                case kCTCellularDataNotRestricted:
                    // app网络权限不受限
                    // 各种操作
                    isAllowComplated?isAllowComplated(YES):nil;
                    NSLog(@"app网络权限不受限");
                    break;
                    
                default:
                    break;
            }
        };
    } else {
        // Fallback on earlier versions
        isAllowComplated?isAllowComplated(YES):nil;
    }
    
}

@end
