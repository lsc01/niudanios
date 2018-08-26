//
//  NDBaseNavigationController.m
//  niudanios
//
//  Created by lsc on 2018/8/23.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDBaseNavigationController.h"
#import "UINavigationBar+Awesome.h"
@interface NDBaseNavigationController ()<UINavigationControllerDelegate>

@end

@implementation NDBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBarTheme];
    // Do any additional setup after loading the view.
    [self.navigationBar setShadowImage:[self createImageWithColor:[UIColor whiteColor]]];
}

#pragma mark - 利用颜色创建颜色图片
- (UIImage *)createImageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);  //图片尺寸
    UIGraphicsBeginImageContext(rect.size); //填充画笔
    CGContextRef context = UIGraphicsGetCurrentContext(); //根据所传颜色绘制
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect); //联系显示区域
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext(); // 得到图片信息
    UIGraphicsEndImageContext(); //消除画笔
    return image;
}


#pragma mark - 设置navbar的字体和背景
- (void)setupNavigationBarTheme {
    //设置全局navBar字体颜色与背景颜色
    UINavigationBar *navBar = [UINavigationBar appearance];
    //设置字体颜色
    NSDictionary *attrNavBar = @{NSFontAttributeName : [UIFont systemFontOfSize:18.0], NSForegroundColorAttributeName : HEXCOLOR(0xffffff)};
    [navBar setTitleTextAttributes:attrNavBar];
    //设置背景颜色 首页导航透明
    //    [navBar lt_setBackgroundColor:[UIColor whiteColor]];
    //设置背景颜色一般的方法
    [navBar setBarTintColor:HEXCOLOR(0x1dcb7c)];
    if ([UIDevice currentDevice].systemVersion.integerValue >= 8.0) {
        [navBar setTranslucent:NO];
    }
}

#pragma mark -
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(self.childViewControllers.count > 0){
        //设置返回键
        [self setUpBackBtn:viewController];
        //隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

#pragma mark - 返回键样式设置
-(void)setUpBackBtn:(UIViewController *)Controller
{
    UIButton *LeftItem = [UIButton buttonWithType:UIButtonTypeSystem];
    LeftItem.frame = CGRectMake(0, 0, 25, 25);
    [LeftItem setBackgroundImage:[UIImage imageNamed:@"ic_back2"] forState:UIControlStateNormal];
    [LeftItem addTarget:self action:@selector(sup_BackBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customLeftItem = [[UIBarButtonItem alloc] initWithCustomView:LeftItem];
    Controller.navigationItem.leftBarButtonItem = customLeftItem;
}

-(void)sup_BackBtnClick{
    
    //返回按钮点击以后，控制器可实现navigationShouldPopOnBackButtonClick方法，截获返回事件，返回Yes，不返回No
    BOOL shouldPop = YES;
    UIViewController* vc = [self topViewController];
    if([vc respondsToSelector:@selector(navigationShouldPopOnBackButtonClick)]) {
        shouldPop = [vc navigationShouldPopOnBackButtonClick];
    }
    
    if(shouldPop) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self popViewControllerAnimated:YES];
        });
    } else {
        // 取消 pop 后，复原返回按钮的状态
        for(UIView *subview in [self.navigationBar subviews]) {
            if(0. < subview.alpha && subview.alpha < 1.) {
                [UIView animateWithDuration:.25 animations:^{
                    subview.alpha = 1.;
                }];
            }
        }
    }
    
}
@end

@implementation UIViewController (BackButtonHandlerC)

@end
