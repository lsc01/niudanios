//  github: https://github.com/MakeZL/MLSelectPhoto
//  author: @email <120886865@qq.com>
//
//  MLNavigationViewController.m
//  MLSelectPhoto
//
//  Created by 张磊 on 15/4/22.
//  Copyright (c) 2015年 com.zixue101.www. All rights reserved.
//

#import "MLSelectPhotoNavigationViewController.h"
#import "MLSelectPhotoCommon.h"

@interface MLSelectPhotoNavigationViewController ()

@end

@implementation MLSelectPhotoNavigationViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    
    UINavigationController *rootVc = (UINavigationController *)[[UIApplication sharedApplication].keyWindow rootViewController];
    
    if ([rootVc isKindOfClass:[UINavigationController class]]) {
        [self.navigationBar setValue:[rootVc.navigationBar valueForKeyPath:@"barTintColor"] forKeyPath:@"barTintColor"];
        [self.navigationBar setTintColor:rootVc.navigationBar.tintColor];
        [self.navigationBar setTitleTextAttributes:rootVc.navigationBar.titleTextAttributes];
        
    }else{
        
        //设置全局navBar字体颜色与背景颜色
        UINavigationBar *navBar = [UINavigationBar appearance];
        //设置字体颜色
        NSDictionary *attrNavBar = @{NSFontAttributeName : [UIFont systemFontOfSize:18.0f], NSForegroundColorAttributeName : HEXCOLOR(0x333333)};
        [navBar setTitleTextAttributes:attrNavBar];
        //设置背景颜色 首页导航透明
//        [navBar lt_setBackgroundColor:[UIColor whiteColor]];
        
//        [self.navigationBar setValue:DefaultNavbarTintColor forKeyPath:@"barTintColor"];
//        [self.navigationBar setTintColor:DefaultNavTintColor];
//        [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:DefaultNavTitleColor}];
    }

}
@end
