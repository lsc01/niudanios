//
//  HLLAlertCustomVC.h
//  HLLCourseLive
//
//  Created by 61_lsc on 2018/6/21.
//  Copyright © 2018年 61_lsc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLLAlertCustomVC : UIViewController

@property (nonatomic ,assign,getter=isTouchBgClose) BOOL touchBgClose;//点击背景可关闭，默认NO不可关闭
@property (nonatomic ,assign,getter=isOneBtnClose) BOOL oneBtnClose;//点击按钮可关闭 默认NO不可关闭,只有单个按钮的有效

+(instancetype)alertWithMessage:(NSString *)message left:(NSString *)leftString right:(NSString *)rightString completed:(void(^)(int index))completed;

+(instancetype)alertWithMessage:(NSString *)message button:(NSString *)btnString completed:(void(^)(void))completed;
-(void)showAlert;


@end



