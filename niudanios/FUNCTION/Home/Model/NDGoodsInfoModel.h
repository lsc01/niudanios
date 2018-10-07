//
//  NDGoodsInfoModel.h
//  niudanios
//
//  Created by lsc on 2018/9/25.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NDGoodsInfoModel : NSObject
@property (nonatomic ,copy) NSString * Id;
@property (nonatomic ,copy) NSString * classifyName;
@property (nonatomic ,copy) NSString * createTime;
@property (nonatomic ,copy) NSString * flag;
@property (nonatomic ,copy) NSString * machineImg;
@property (nonatomic ,copy) NSString * machineName;
@property (nonatomic ,assign) NSInteger machinePrice;
@property (nonatomic ,assign) NSInteger salesVolume;

@property (nonatomic ,assign) NSInteger status;
@end
