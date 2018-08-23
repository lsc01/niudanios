//
//  NDMineViewController.m
//  niudanios
//
//  Created by lsc on 2018/8/23.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDMineViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "UINavigationBar+Awesome.h"

#define Head_H (kScreenWidth*(360.0/750))

@interface NDMineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UIView * headView;

@property(nonatomic,strong)UITableView *tableView;
@end

@implementation NDMineViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.fd_prefersNavigationBarHidden = YES;//隐藏导航栏
    self.title = @"个人中心";
    [self setUI];
}


-(void)setUI{
    
    [self.view addSubview:self.headView];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(Head_H);
    }];
    
    UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_a"]];
    [self.headView addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.headView);
    }];
    
    
    UIView * viewNav = [[UIView alloc] init];
    viewNav.backgroundColor = HEXCOLOR(0x000000);
    viewNav.alpha = 0.1;
    [self.headView addSubview:viewNav];
    CGFloat top = isIPhoneX?44:20;
    [viewNav mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.headView);
        make.top.mas_equalTo(top);
        make.height.mas_equalTo(44);
    }];
    
    
    UILabel * labelTitle = [[UILabel alloc] init];
    labelTitle.text = @"个人中心";
    labelTitle.textColor = [UIColor whiteColor];
    labelTitle.textAlignment = NSTextAlignmentCenter;
    labelTitle.font = [UIFont systemFontOfSize:18.0];
    [self.headView addSubview:labelTitle];
    [labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(viewNav);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(viewNav);
    }];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"ic_share"] forState:UIControlStateNormal];
    [rightBtn.imageView setContentMode:UIViewContentModeCenter];
    [rightBtn addTarget:self action:@selector(navRightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:rightBtn];
    
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(viewNav);
        make.height.with.mas_equalTo(25);
        make.right.mas_equalTo(self.headView).offset(-15);
    }];
    
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"ic_set"] forState:UIControlStateNormal];
    [leftBtn.imageView setContentMode:UIViewContentModeCenter];
    [leftBtn addTarget:self action:@selector(navLeftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(viewNav);
        make.height.with.mas_equalTo(25);
        make.left.mas_equalTo(self.headView).offset(15);
    }];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.sectionFooterHeight = 10.0f;
    
    self.tableView.bounces = YES;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.headView.mas_bottom);
    }];
}


#pragma mark - tableview

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
 
    return 3;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 1) {
        return 194.0f;
    }
    
    return 44.0f;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
    if(section == 0){
        return 4;
    }else if(section == 1){
        return 1;
    }else if(section == 2){
        return 2;
    }else{
        return 0;
    }
  
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.backgroundColor = [UIColor redColor];
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - 导航栏左右按钮点击
-(void)navLeftBtnClick{
    
}
-(void)navRightBtnClick{
   
}



-(UIView *)headView{
    if(_headView == nil){
        _headView = [[UIView alloc] init];
        _headView.backgroundColor = [UIColor clearColor];
    }
    return _headView;
}

@end
