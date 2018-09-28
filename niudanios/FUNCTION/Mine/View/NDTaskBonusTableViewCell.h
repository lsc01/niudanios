//
//  NDTaskBonusTableViewCell.h
//  niudanios
//
//  Created by lsc on 2018/9/4.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NDTaskBonusModel.h"
#define KScale_C (kScreenWidth/375.0)
#define Kcell_height ((90*kScreenWidth/375.0)+64)
@interface NDTaskBonusTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintLabel1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintBtnRight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ConstraintBgLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ConstraintBgRight;

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelNum;
@property (weak, nonatomic) IBOutlet UIButton *btnGet;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewBg;

@property (weak, nonatomic) IBOutlet UIView *viewBg;

@property (nonatomic ,strong) NDTaskBonusModel * model;

@property (nonatomic ,copy) void(^getTaskBonusBlock)(NDTaskBonusModel * model);
- (IBAction)getBtnClick:(UIButton *)sender;

@end
