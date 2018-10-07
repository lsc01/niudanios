//
//  NDAddressCityDataModel.h
//  niudanios
//
//  Created by lsc on 2018/10/2.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NDAddressProvinceDataModel : NSObject

@property (nonatomic ,copy) NSString * provinceName;
@property (nonatomic ,copy) NSString * provinceId;
@property (nonatomic ,copy) NSArray * city;

@end


@interface NDAddressCityDataModel : NSObject

@property (nonatomic ,copy) NSString * city_name;
@property (nonatomic ,copy) NSString * province_id;
@property (nonatomic ,copy) NSString * city_id;
@property (nonatomic ,copy) NSArray * area;

@end


@interface NDAddressAreaDataModel : NSObject

@property (nonatomic ,copy) NSString * area_name;
@property (nonatomic ,copy) NSString * area_id;
@property (nonatomic ,copy) NSString * city_id;

@end
