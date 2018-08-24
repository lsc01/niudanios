//
//  NDMineTableViewCell.h
//  niudanios
//
//  Created by lsc on 2018/8/24.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NDMineTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageViewHead;
@property (weak, nonatomic) IBOutlet UILabel *labelName;

@property (weak, nonatomic) IBOutlet UIImageView *imageViewRight;
@property (weak, nonatomic) IBOutlet UIView *viewLine;

@end
