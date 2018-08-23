//
//  NDBaseViewController.m
//  niudanios
//
//  Created by lsc on 2018/8/23.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDBaseViewController.h"

@interface NDBaseViewController ()

@end

@implementation NDBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = HEXCOLOR(0xeeeeee);
    
}

//监听返回按钮点击事件，在这个方法里面移除通知、移除监听，记得调用父类此方法，父类也需要移除这些东西
//不想返回也可以实现这个方法，return no，就不要调用父类的这个方法了
///返回值为NO，则不会返回到上一个页面
-(BOOL)navigationShouldPopOnBackButtonClick{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
