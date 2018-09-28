//
//  NDMineDownTableViewCell.h
//  niudanios
//
//  Created by lsc on 2018/9/4.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NDMineDownInfoModel.h"
@interface NDMineDownTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageviewHead;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *labelDate;
@property (weak, nonatomic) IBOutlet UILabel *labelCount;


@property (nonatomic ,strong) NDMineDownInfoModel * model;
@end
