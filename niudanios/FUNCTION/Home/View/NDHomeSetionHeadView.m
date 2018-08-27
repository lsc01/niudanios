//
//  NDHomeSetionHeadView.m
//  niudanios
//
//  Created by lsc on 2018/8/27.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDHomeSetionHeadView.h"

@implementation NDHomeSetionHeadView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
}

-(void)hideRightView{
    self.btnMore.hidden = YES;
    self.imageViewMore.hidden = YES;
    self.labelMore.hidden = YES;
}

- (IBAction)btnMore:(UIButton *)sender {
}
@end
