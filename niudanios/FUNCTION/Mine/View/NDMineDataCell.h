//
//  NDMineDataCell.h
//  niudanios
//
//  Created by lsc on 2018/9/2.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NDMineDataCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *textFieldName;

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnSelect;
- (IBAction)selectBtnClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *viewLine;

@property (nonatomic ,copy) void(^selectBtnBlock)(UIButton * btnSelect);
-(void)setSelectBtnBlock:(void (^)(UIButton * btnSelect))selectBtnBlock;


@end
