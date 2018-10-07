//
//  NDOrderDetailInfoModel.h
//  niudanios
//
//  Created by lsc on 2018/10/2.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NDOrderDetailInfoModel : NSObject
@property (nonatomic ,copy) NSString * shipperCode;
@property (nonatomic ,copy) NSString * companyName;
@property (nonatomic ,copy) NSString * remind;
@property (nonatomic ,copy) NSString * phone;
@property (nonatomic ,copy) NSString * orderNumber;
@property (nonatomic ,copy) NSString * flag;
@property (nonatomic ,copy) NSString * companyId;
@property (nonatomic ,copy) NSString * Id;
@property (nonatomic ,copy) NSString * addressData;
@property (nonatomic ,copy) NSString * gashaponImg;
@property (nonatomic ,assign) NSInteger count;
@property (nonatomic ,copy) NSString * gashaponName;
@property (nonatomic ,copy) NSString * status;
@property (nonatomic ,copy) NSString * name;
@property (nonatomic ,copy) NSString * createTime;
@property (nonatomic ,copy) NSString * freightMoney;
@property (nonatomic ,copy) NSString * customerId;
@property (nonatomic ,strong) NSArray * logisticsDataArray;

@end

@interface NDLogisticsInfoModel : NSObject

@property (nonatomic ,copy) NSString * context;

@property (nonatomic ,copy) NSString * time;

@end

