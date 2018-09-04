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
#import "NDMineTableViewCell.h"
#import "NDMineFunctionCell.h"
#import "NDSettingViewController.h"
#import "NDLoginViewController.h"
#import "NDMineOrderViewController.h"
#import "NDMyWalletViewController.h"


#define Head_H (kScreenWidth*(360.0/750))
#define KheadViewH(x) ((x)*(kScreenWidth/375.0))
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
        make.height.mas_equalTo(Head_H+(isIPhoneX?24:0));
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
        make.height.width.mas_equalTo(23);
        make.right.mas_equalTo(self.headView).offset(-15);
    }];
    
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"ic_set"] forState:UIControlStateNormal];
    [leftBtn.imageView setContentMode:UIViewContentModeCenter];
    [leftBtn addTarget:self action:@selector(navLeftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(viewNav);
        make.height.width.mas_equalTo(25);
        make.left.mas_equalTo(self.headView).offset(15);
    }];
    
    
    
    UIImageView * imageHead = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"head_placehold"]];
    imageHead.layer.cornerRadius = KheadViewH(60)/2.0;
    imageHead.layer.masksToBounds = YES;
    [self.headView addSubview:imageHead];
    [imageHead mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(KheadViewH(60));
        make.centerX.mas_equalTo(self.headView);
        make.top.mas_equalTo(viewNav.mas_bottom).offset(KheadViewH(8));
    }];
    
    
    UILabel * labelName = [[UILabel alloc] init];
    labelName.text = @"姓名";
    labelName.textColor = [UIColor whiteColor];
    labelName.textAlignment = NSTextAlignmentCenter;
    labelName.font = [UIFont systemFontOfSize:16.0];
    [self.headView addSubview:labelName];
    [labelName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.headView);
        make.left.mas_equalTo(self.headView).offset(10);
        make.bottom.mas_equalTo(self.headView).offset(KheadViewH(-20));
    }];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.sectionFooterHeight = 10.0f;
    
    self.tableView.bounces = YES;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NDMineTableViewCell" bundle:nil] forCellReuseIdentifier:@"NDMineTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"NDMineFunctionCell" bundle:nil] forCellReuseIdentifier:@"NDMineFunctionCell"];
    
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
        return (kScreenWidth*177.0/375);
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
    
    if (indexPath.section == 0) {
        NDMineTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NDMineTableViewCell"	 forIndexPath:indexPath];
        cell.viewLine.hidden = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            cell.imageViewHead.image = [UIImage imageNamed:@"ic_ads"];
            cell.labelName.text = @"全部订单";
        }else if (indexPath.row == 1){
            cell.imageViewHead.image = [UIImage imageNamed:@"ic_pd"];
            cell.labelName.text = @"待发货";
        }else if (indexPath.row == 2){
            cell.imageViewHead.image = [UIImage imageNamed:@"ic_logistics"];
            cell.labelName.text = @"待收货";
        }else if (indexPath.row == 3){
            cell.imageViewHead.image = [UIImage imageNamed:@"ic_rg"];
            cell.labelName.text = @"已收货";
            cell.viewLine.hidden = YES;
        }
        
        
        return cell;
    }else if (indexPath.section == 2){
        NDMineTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NDMineTableViewCell" forIndexPath:indexPath];
        cell.viewLine.hidden = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            cell.imageViewHead.image = [UIImage imageNamed:@"ic_callservice"];
            cell.labelName.text = @"联系客服";
        }else if (indexPath.row == 1){
            cell.imageViewHead.image = [UIImage imageNamed:@"ic_au"];
            cell.labelName.text = @"关于我们";
            cell.viewLine.hidden = YES;
        }
        
        
        return cell;
    }else{
        NDMineFunctionCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NDMineFunctionCell" forIndexPath:indexPath];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setFunctionSelectedBlock:^(NSInteger tag) {
            NSLog(@"tag:%d",tag);
            NDLoginViewController * loginVC = [[NDLoginViewController alloc] init];
            [self.navigationController pushViewController:loginVC animated:YES];
        }];
        return cell;
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        NDMineOrderViewController * orderVC = [[NDMineOrderViewController alloc] init];
        [self.navigationController pushViewController:orderVC animated:YES];
    }else if (indexPath.section == 2){
        if (indexPath.row == 1) {
            NDMyWalletViewController * vc = [[NDMyWalletViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
    
}

#pragma mark - 导航栏左右按钮点击
-(void)navLeftBtnClick{
    NDSettingViewController * settingVC = [[NDSettingViewController alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
    
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
