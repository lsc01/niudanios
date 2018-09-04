//
//  UIViewController+toast.m
//  CycleVerticalView
//
//  Created by lsc on 2018/9/4.
//  Copyright © 2018年 EL. All rights reserved.
//

#import "UIViewController+toast.h"

@implementation UIViewController (toast)
#pragma mark - 显示提示信息
- (void)toastTip:(NSString *)toastInfo{
    
    CGRect frameSelf = self.view.bounds;
    CGFloat widthSelf = frameSelf.size.width;
    CGFloat heightSelf = frameSelf.size.height;
    
    __block UIView * viewBackground = [[UIView alloc] init];
    viewBackground.backgroundColor = [UIColor clearColor];
    UIImageView * imageViewBg = [[UIImageView alloc] init];
    [viewBackground addSubview:imageViewBg];
    UILabel * labelToast = [[UILabel alloc] init];
    [viewBackground addSubview:labelToast];
    [self.view addSubview:viewBackground];
    
    
    labelToast.text = toastInfo;
    labelToast.font = [UIFont boldSystemFontOfSize:14];
    labelToast.textAlignment = NSTextAlignmentCenter;
    labelToast.backgroundColor = [UIColor clearColor];
    labelToast.numberOfLines = 0;
    labelToast.textColor = HEXCOLOR(0x1dcb7c);
    
    CGFloat max_width = widthSelf -60;
    CGFloat width = [labelToast sizeThatFits:CGSizeMake(MAXFLOAT, 20)].width;
    width = width > max_width?max_width:width;
    CGFloat height = [labelToast sizeThatFits:CGSizeMake(max_width, MAXFLOAT)].height;
    labelToast.frame = CGRectMake(15, 18, width, height);
    
    //初始图片
    UIImage *initialImage = [UIImage imageNamed:@"jiantou"];
    //拉伸图片右侧
    UIImage *rightStretchImage = [initialImage stretchableImageWithLeftCapWidth:initialImage.size.width *0.8 topCapHeight:initialImage.size.height *0.5];
    //拉伸后的宽度=总宽度/2+初始图片宽度/2
    CGFloat stretchWidth = (width+20)/2+initialImage.size.width/2;
    //获得右侧拉伸过后的图片
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(stretchWidth, height+10), NO, [UIScreen mainScreen].scale);
    [rightStretchImage drawInRect:CGRectMake(0, 0, stretchWidth, height+10)];
    UIImage *firstStretchImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //拉伸图片左侧，获得最终图片
    UIImage *finalImage = [firstStretchImage stretchableImageWithLeftCapWidth:initialImage.size.width *0.2 topCapHeight:initialImage.size.height*0.5];
    imageViewBg.image = finalImage;
    imageViewBg.frame = CGRectMake(5, 5, width+20, height+30);
    
    imageViewBg.layer.shadowColor = [UIColor blackColor].CGColor;//设置阴影的颜色
    imageViewBg.layer.shadowOpacity = 0.5;//设置阴影的透明度
    imageViewBg.layer.shadowOffset = CGSizeMake(0, 2);//设置阴影的偏移量
    imageViewBg.layer.shadowRadius = 2;
    
    viewBackground.frame = CGRectMake((widthSelf-width-20)/2.0, (heightSelf-height-10-50), width+30, height+40);
    
    
    [self.view bringSubviewToFront:viewBackground];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^() {
        [viewBackground removeFromSuperview];
        viewBackground = nil;
    });
}

@end
