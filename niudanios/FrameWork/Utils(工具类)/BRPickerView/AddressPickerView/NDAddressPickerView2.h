//
//  NDAddressPickerView2.h
//  niudanios
//
//  Created by lsc on 2018/10/2.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "BRBaseView.h"
typedef void(^BRAddressResultBlock)(NSArray *selectAddressArr,NSArray * selectIdArr);
@interface NDAddressPickerView2 : BRBaseView
/**
 *  显示地址选择器
 *
 *  @param defaultSelectedArr       默认选中的值(传数组，元素为对应的索引值。如：@[@10, @1, @1])
 *  @param isAutoSelect             是否自动选择，即选择完(滚动完)执行结果回调，传选择的结果值
 *  @param resultBlock              选择后的回调
 *
 */
+ (instancetype)showAddressPickerWithDefaultSelected:(NSArray *)defaultSelectedArr andArrData:(NSArray *)arrayData isAutoSelect:(BOOL)isAutoSelect resultBlock:(BRAddressResultBlock)resultBlock;
@end
