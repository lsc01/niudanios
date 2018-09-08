//
//  NDLogisticsDetailHeadView.m
//  niudanios
//
//  Created by lsc on 2018/9/8.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDLogisticsDetailHeadView.h"

@implementation NDLogisticsDetailHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.imageViewGoods.layer.cornerRadius = 4;
    self.imageViewGoods.clipsToBounds = YES;
}

@end
