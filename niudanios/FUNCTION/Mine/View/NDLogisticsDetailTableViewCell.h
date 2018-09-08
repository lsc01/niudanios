//
//  NDLogisticsDetailTableViewCell.h
//  niudanios
//
//  Created by lsc on 2018/9/8.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NDLogisticsDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *viewLineTop;
@property (weak, nonatomic) IBOutlet UIView *viewLineCenter;
@property (weak, nonatomic) IBOutlet UIView *viewLineBottom;
@property (weak, nonatomic) IBOutlet UILabel *labelDes;

@property (weak, nonatomic) IBOutlet UILabel *labelTime;
@end
