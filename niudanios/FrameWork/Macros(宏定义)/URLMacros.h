//
//  URLMacros.h
//  HLLCourseLive
//
//  Created by 61_lsc on 2018/6/7.
//  Copyright © 2018年 61_lsc. All rights reserved.
//

#ifndef URLMacros_h
#define URLMacros_h
//#define BsemURL_PREFIX  @"http://lijiapengx.xicp.io/niudan/"//个人的
//#define BsemURL_PREFIX  @"http://49.4.70.94:8660/niudan/"//测试
#define BsemURL_PREFIX  @"https://www.kandoc.com.cn/"


#define HTTP(x) [BsemURL_PREFIX stringByAppendingString:x]

#pragma mark - 登录注册相关
///手机注册
#define URL_Register HTTP(@"app/customer/register.mvc")
///手机登录
#define URL_LoginPwd HTTP(@"app/customer/login.mvc")
///手机验证码发送
#define URL_identifyingCode HTTP(@"app/customer/identifyingCode.mvc")
///重置手机号 新手机号验证
#define URL_resetMobile HTTP(@"app/customer/resetMobile.mvc")
///重置手机号 验证原来手机号号码
#define URL_confirmMobile HTTP(@"/app/customer/confirmMobile.mvc")
///修改密码
#define URL_updatePwd HTTP(@"app/customer/updatePwd.mvc")
///重置密码
#define URL_resetPwd HTTP(@"app/customer/resetPwd.mvc")
///修改用户信息
#define URL_updateCustomerInfo HTTP(@"app/customer/updateCustomerInfo.mvc")
///查询用户信息
#define URL_findCustomerInfo HTTP(@"app/customer/one.mvc")


///app第三方登陆登陆 请求用户信息
#define URL_thirdParty HTTP(@"app/customer/thirdParty.mvc")
///openid和机型绑定手机号
#define URL_bundlingPhone HTTP(@"app/customer/bundling.mvc")

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
///首页的所有数据
#define URL_homeAllData HTTP(@"app/home/coalition.mvc")



#pragma mark - 扭蛋
///条件查询过滤扭蛋机
#define URL_qrequirementAll HTTP(@"app/gashaponMachine/requirementAll.mvc")
///扭蛋机查询扭蛋
#define URL_queryByMachineId HTTP(@"app/gashaponMachine/queryByMachineId.mvc")//没接
///启动扭蛋机
#define URL_beginTwistedEgg HTTP(@"app/gashaponMachine/beginTwistedEgg.mvc")//没接
///扭蛋机金额条件
#define URL_qmoneyCompare HTTP(@"app/moneyCompare/list.mvc")
///扭蛋机分类
#define URL_classify HTTP(@"app/classify/list.mvc")
///扭蛋机分类+扭蛋机金额条件接口合并
#define URL_classifycoalition HTTP(@"app/classify/coalition.mvc")

#pragma mark - 背包
///背包信息查询
#define URL_queryBackpack HTTP(@"app/selfitem/queryBackpack.mvc")
///背包选中商品信息
#define URL_selectBackpack HTTP(@"app/selfitem/selectBackpack.mvc")
///更新扭蛋的到期时间
#define URL_selfitemreplace HTTP(@"app/selfitem/replace.mvc")
///扭蛋记录
#define URL_niudanqueryRecord HTTP(@"app/selfitem/queryRecord.mvc")

#pragma mark 快递
///查询运费金额
#define URL_squeryDistinguish HTTP(@"app/expressCost/queryDistinguish.mvc")

#pragma mark ----- 我的
#pragma mark 订单相关
///查询全部订单
#define URL_stotalOrder HTTP(@"app/order/totalOrder.mvc")
///查询订单详情
#define URL_detailOrder HTTP(@"app/order/detailOrder.mvc")
///删除订单
#define URL_deleteOrder HTTP(@"app/order/deleteOrder.mvc")
///提醒发货
#define URL_remindOrder HTTP(@"app/order/remindOrder.mvc")
///查询订单中扭蛋信息
#define URL_ordertwistedEgg HTTP(@"app/order/twistedEgg.mvc")//没接
///确认订单
#define URL_order_confirm HTTP(@"app/order/confirm.mvc")


#pragma mark 收藏相关
///收藏查询
#define URL_findCustomerId HTTP(@"app/collect/findCustomerId.mvc")
///新增收藏
#define URL_AddCollect HTTP(@"app/collect/addCollect.mvc")
///删除收藏
#define URL_modifyCollect HTTP(@"app/collect/modify.mvc")
///取消收藏
#define URL_removeCollert HTTP(@"app/collect/removeCollert.mvc")



#pragma mark 奖励金相关
///奖励金查询
#define URL_queryBounty HTTP(@"app/horation/queryBounty.mvc")
///领取奖励金
#define URL_receiveHortation HTTP(@"app/horation/receiveHortation.mvc")
///我的下线
#define URL_rqueryHeeler HTTP(@"app/customer/queryHeeler.mvc")


#pragma mark 地址相关
///查询省市县三层所有
#define URL_selectProvince HTTP(@"app/addressProvince/selectProvince.mvc")
///详细地址消息
#define URL_ShippingAddressfindId HTTP(@"app/shippingAddress/findId.mvc")//没接
///更新地址信息
#define URL_ShippingAddressmodify HTTP(@"app/shippingAddress/modify.mvc")
///删除地址
#define URL_ShippingAddressdelete HTTP(@"app/shippingAddress/delete.mvc")
///查询地址信息
#define URL_ShippingAddressfind HTTP(@"app/shippingAddress/findCustomerId.mvc")
///修改地址为默认选中的
#define URL_reviseDefault HTTP(@"app/shippingAddress/reviseDefault.mvc")
///地址新增
#define URL_ShippingAddressadd HTTP(@"app/shippingAddress/add.mvc")
///查询用户默认地址
#define URL_selectDefaultAddr HTTP(@"app/shippingAddress/selectDefault.mvc")

#pragma mark 钱包
///查询消费记录
#define URL_queryConsume HTTP(@"app/customerDetail/queryConsume.mvc")
///支付宝充值下单
#define URL_alipay HTTP(@"app/zfb/pay.mvc")
///微信充值下单
#define URL_wxpay HTTP(@"app/wx/pay.mvc")
///支付宝支付同步回调
#define URL_payQueryzfb HTTP(@"app/zfb/payQuery.mvc")
///微信充值同步回调
#define URL_payQuerywx HTTP(@"app/wx/payQuery.mvc")

///获取优惠券的URL
#define URL_getCouponUrl HTTP(@"app/coupon/couponUrl.mvc")

///获取反馈的URL
#define URL_getFeedbackUrl HTTP(@"app/feedback/feedbackUrl.mvc")

///关于我们
#define URL_cqueryAboutUs HTTP(@"app/expressCost/queryAboutUs.mvc")

///客服电话
#define URL_customPhone HTTP(@"app/expressCost/customPhone.mvc")

///分享
#define URL_ShareContent HTTP(@"app/expressCost/sharing.mvc")
///扭蛋H5页面
//#define URL_h5ToTwisted HTTP(@"h5/toTwisted.mvc")
///请求h5地址
#define URL_skipH5 HTTP(@"app/gashaponMachine/skipH5.mvc")

///获取二维码扫描后的H5 URL
#define URL_toAppPay HTTP(@"pay/toAppPay.mvc")

///记录用户打开次数
#define URL_loginRecordAppend HTTP(@"app/loginRecord/append.mvc")
///浏览接口
#define URL_browseRecord HTTP(@"/app/browse/record.mvc")


#define ImageUrl(x) ([(x) hasPrefix:@"https"]||[(x) hasPrefix:@"http"])?(x):(HTTP(x))
#endif /* URLMacros_h */
