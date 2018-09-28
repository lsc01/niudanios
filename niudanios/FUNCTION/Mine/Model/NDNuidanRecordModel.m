//
//  NDNuidanRecordModel.m
//  niudanios
//
//  Created by lsc on 2018/9/28.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDNuidanRecordModel.h"

@implementation NDNuidanRecordModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"Id": @"id"};
}

-(void)setCreateTime:(NSString *)createTime{
    _createTime = createTime;
    self.timeFormat = [self ConvertStrToTime:createTime];
}

//时间戳变为格式时间
- (NSString *)ConvertStrToTime:(NSString *)timeStr
{
    
    long long time=[timeStr longLongValue]/1000;
    //    如果服务器返回的是13位字符串，需要除以1000，否则显示不正确(13位其实代表的是毫秒，需要除以1000)
    //    long long time=[timeStr longLongValue] / 1000;
    
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:time];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString*timeString=[formatter stringFromDate:date];
    
    return timeString;
    
}

@end
