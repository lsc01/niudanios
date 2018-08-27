//
//  NDHomeSetionHeadView.h
//  niudanios
//
//  Created by lsc on 2018/8/27.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NDHomeSetionHeadView : UIView
@property (weak, nonatomic) IBOutlet UILabel *labelDes;
@property (weak, nonatomic) IBOutlet UILabel *labelMore;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewMore;
@property (weak, nonatomic) IBOutlet UIButton *btnMore;
@property (weak, nonatomic) IBOutlet UIView *viewLeftLine;

- (IBAction)btnMore:(UIButton *)sender;

-(void)hideRightView;
@end
