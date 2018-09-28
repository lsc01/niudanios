//
//  NDNuidanRecordModel.h
//  niudanios
//
//  Created by lsc on 2018/9/28.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NDNuidanRecordModel : NSObject
@property (nonatomic ,copy) NSString * Id;
@property (nonatomic ,copy) NSString * gashaponName;
@property (nonatomic ,copy) NSNumber * machinePrice;
@property (nonatomic ,copy) NSString * gashaponImg;
@property (nonatomic ,copy) NSNumber * gashaponPrice;
@property (nonatomic ,copy) NSString * createTime;
@property (nonatomic ,copy) NSString * customerId;
@property (nonatomic ,copy) NSNumber * flag;


@property (nonatomic ,copy) NSString * timeFormat;
@end
