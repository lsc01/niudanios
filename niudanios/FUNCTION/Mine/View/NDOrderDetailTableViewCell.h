//
//  NDOrderDetailTableViewCell.h
//  niudanios
//
//  Created by lsc on 2018/9/2.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NDOrderDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageViewOrder;
@property (weak, nonatomic) IBOutlet UILabel *labelGoodsName;
@property (weak, nonatomic) IBOutlet UILabel *labelOrderId;
@property (weak, nonatomic) IBOutlet UILabel *labelMoney;

@end
