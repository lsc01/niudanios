//
//  NDAboutTableViewCell.h
//  niudanios
//
//  Created by lsc on 2018/9/5.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NDAboutInfoModel.h"
@interface NDAboutTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labeltitle;
@property (weak, nonatomic) IBOutlet UILabel *labelDes;

@property (nonatomic, strong) NDAboutInfoModel * model;

@end
