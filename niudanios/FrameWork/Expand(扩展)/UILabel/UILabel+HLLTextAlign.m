//
//  UILabel+HLLTextAlign.m
//  HLLCourseLive
//
//  Created by lsc on 2018/8/23.
//  Copyright © 2018年 61_lsc. All rights reserved.
//

#import "UILabel+HLLTextAlign.h"

@implementation UILabel (HLLTextAlign)

-(void)setIsTop:(BOOL)isTop {
    
    if (isTop) {
        
        CGSize fontSize = [self.text sizeWithFont:self.font];
        //控件的高度除以一行文字的高度
        int num = self.frame.size.height/fontSize.height;
        //计算需要添加换行符个数
        int newLinesToPad = num  - self.numberOfLines;
        self.numberOfLines = 0;
        for(int i=0; i<newLinesToPad; i++)
            //在文字后面添加换行符"/n"
            self.text = [self.text stringByAppendingString:@"\n"];
    }
}

-(void)setIsBottom:(BOOL)isBottom {
    
    if (isBottom) {
        CGSize fontSize = [self.text sizeWithFont:self.font];
        //控件的高度除以一行文字的高度
        int num = self.frame.size.height/fontSize.height;
        //计算需要添加换行符个数
        int newLinesToPad = num  - self.numberOfLines;
        self.numberOfLines = 0;
        for(int i=0; i<newLinesToPad; i++)
            //在文字前面添加换行符"/n"
            self.text = [NSString stringWithFormat:@" \n%@",self.text];
    }
}

@end
