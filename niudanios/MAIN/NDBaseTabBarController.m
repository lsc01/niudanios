//
//  NDBaseTabBarController.m
//  niudanios
//
//  Created by lsc on 2018/8/23.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDBaseTabBarController.h"
#import "NDBaseNavigationController.h"
#import "NDHomeViewController.h"
#import "NDNiudanViewController.h"
#import "NDPackageViewController.h"
#import "NDMineViewController.h"
@interface NDBaseTabBarController ()

@end

@implementation NDBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self RTSetUpVcs];
    }
    return self;
}


-(void)RTSetUpVcs{
    NDHomeViewController *HomeVC = [[NDHomeViewController alloc]init];
    NDBaseNavigationController *HomeNav = [self ChildVC:HomeVC
                                           WithTitle:@"首页"
                                               image:@"ic_home"
                                       selectedImage:@"ic_home_c"];
    
    NDNiudanViewController * niudanVC = [NDNiudanViewController new];
    NDBaseNavigationController *niudanNav = [self ChildVC:niudanVC
                                           WithTitle:@"扭蛋"
                                               image:@"ic_gashapon"
                                       selectedImage:@"ic_gashapon_c"];
    NDPackageViewController *packVC = [NDPackageViewController new];
    NDBaseNavigationController *packNav = [self ChildVC:packVC
                                              WithTitle:@"背包"
                                                  image:@"ic_knapsack"
                                          selectedImage:@"ic_knapsack_c"];
    NDMineViewController *mineVC = [NDMineViewController new];
    NDBaseNavigationController *mineNav = [self ChildVC:mineVC
                                              WithTitle:@"我的"
                                                  image:@"ic_my"
                                          selectedImage:@"ic_my_c"];
    
    self.tabBar.barTintColor = [UIColor whiteColor];//tabbar 背景色
    self.tabBar.translucent = NO;//tarbar非透明
    self.viewControllers = @[HomeNav,niudanNav,packNav,mineNav];
}


#pragma mark  - 根TabBarController 添加子视图
-(NDBaseNavigationController *)ChildVC:(UIViewController *)VC WithTitle:(NSString *)title image:(NSString *)imagename selectedImage:(NSString *)selectedImageName
{
    VC.title = title;
    UITabBarItem *barItem = [[UITabBarItem alloc]init];
    barItem.title = title;
    barItem.image = [[UIImage imageNamed:imagename]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    barItem.selectedImage = [[UIImage imageNamed:selectedImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [barItem setTitleTextAttributes:@{NSForegroundColorAttributeName: HEXCOLOR(0x333333)} forState:UIControlStateNormal];
    // 选中状态下的文字颜色
    [barItem setTitleTextAttributes:@{NSForegroundColorAttributeName: HEXCOLOR(0xfe7e4b)} forState:UIControlStateSelected];
    NDBaseNavigationController *Nav = [[NDBaseNavigationController alloc]initWithRootViewController:VC];
    Nav.tabBarItem = barItem;
    return Nav;
}


@end
