//
//  NDRecodeTableViewCell.h
//  niudanios
//
//  Created by lsc on 2018/9/5.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NDRecodeTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *imageViewGoods;

@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelTime;

@property (weak, nonatomic) IBOutlet UILabel *labelPrice;
@end
