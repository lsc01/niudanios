//
//  NDUserInfoModel.h
//  niudanios
//
//  Created by lsc on 2018/9/28.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NDUserInfoModel : NSObject

/*
 createTime    String    创建时间
 sex    String    1男，0女
 id    String    用户id
 msg    String    返回的中文提示
 birthdayTime    String    出生日期
 loginMobile    String    手机号码
 flag    String    0隐藏，1显示
 money    String    余额
 nickName    String    用户名
 parentId    String    上线id
 headPortrait    String    用户头像地址
 code    String    0成功，成功还返回用户信息，1账号密码不匹配，2不可以为空
 
 
 */

@property (nonatomic ,copy) NSString * Id;
@property (nonatomic ,copy) NSString * createTime;
@property (nonatomic ,copy) NSString * sex;
@property (nonatomic ,copy) NSString * birthdayTime;
@property (nonatomic ,copy) NSString * loginMobile;
@property (nonatomic ,copy) NSString * flag;
@property (nonatomic ,copy) NSString * money;
@property (nonatomic ,copy) NSString * nickName;
@property (nonatomic ,copy) NSString * parentId;
@property (nonatomic ,copy) NSString * headPortrait;

@end
