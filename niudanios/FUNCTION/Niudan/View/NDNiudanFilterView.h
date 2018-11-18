//
//  NDNiudanFilterView.h
//  niudanios
//
//  Created by lsc on 2018/8/30.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NDNiudanFilterModel.h"
@interface NDNiudanFilterView : UIView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;

@property (nonatomic ,strong) NSArray <NDNiudanFilterModel *> * arrayModel;


@property (nonatomic ,copy) void(^selectRowBlock)(NSInteger row);
-(void)setSelectRowBlock:(void (^)(NSInteger row))selectRowBlock;
@property (nonatomic ,copy) void(^closeFilterViewBlock)(void);
@end
