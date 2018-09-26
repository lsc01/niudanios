//
//  URLMacros.h
//  HLLCourseLive
//
//  Created by 61_lsc on 2018/6/7.
//  Copyright © 2018年 61_lsc. All rights reserved.
//

#ifndef URLMacros_h
#define URLMacros_h



#define BsemURL_PREFIX  @"https://www.7qiandao.com/niudan/"


#define HTTP(x) [BsemURL_PREFIX stringByAppendingString:x]


#pragma mark - 登录注册相关
///注册
#define URL_Register HTTP(@"app/customer/register.mvc")
///密码登录
#define URL_LoginPwd HTTP(@"app/customer/login.mvc")


#pragma mark - 首页
///首页轮播
#define URL_Banner HTTP(@"app/commonImage/Rotation.mvc")
///轮播消息
#define URL_NewMgs HTTP(@"app/messageRotation/queryNewMessage.mvc")
//人气商品
#define URL_HumanGoods HTTP(@"app/home/queryHuman.mvc")
///猜你喜欢
#define URL_likeGoods HTTP(@"app/home/queryLike.mvc")
///最新商品
#define URL_newGoods HTTP(@"app/home/queryNew.mvc")
///最新商品展开
#define URL_newGoodsDetail HTTP(@"app/gashaponMachine/queryBycustomerIdNew.mvc")
///人气商品展开
#define URL_HumanGoodsDetail HTTP(@"app/gashaponMachine/queryBycustomerIdHuman.mvc")


#pragma mark - 扭蛋
//条件查询过滤扭蛋机/a
#define URL_qrequirementAll HTTP(@"app/gashaponMachine/requirementAll.mvc")
//扭蛋机查询扭蛋
#define URL_queryByMachineId HTTP(@"app/gashaponMachine/queryByMachineId.mvc")
//扭蛋机金额条件
#define URL_qmoneyCompare HTTP(@"app/moneyCompare/list.mvc")
//扭蛋机分类
#define URL_classify HTTP(@"app/classify/list.mvc")

#pragma mark - 背包

//背包信息查询
#define URL_queryBackpack HTTP(@"app/selfitem/queryBackpack.mvc")
//背包选中信息
#define URL_selectBackpack HTTP(@"app/selfitem/selectBackpack.mvc")
//查询用户默认地址
#define URL_selectDefaultAddr HTTP(@"app/ShippingAddress/selectDefault.mvc")



#endif /* URLMacros_h */
