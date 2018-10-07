//
//  NDMineDataHeaderView.h
//  niudanios
//
//  Created by lsc on 2018/9/2.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NDMineDataHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIButton *btnImageHead;
- (IBAction)headBtnClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewHead;

@property (nonatomic ,copy) void(^headViewUpdateBlock)(UIImageView * imageView);

@end
