//
//  NDHomeViewController.m
//  niudanios
//
//  Created by lsc on 2018/8/23.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDHomeViewController.h"
#import "NDHomeHeadView.h"
#import "NDHomeSetionHeadView.h"
#import "NDHomeLikeCell.h"
#import "NDHomeGoodsCell.h"
@interface NDHomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) NDHomeHeadView * headView;

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation NDHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNav];
    [self setUI];
    
}

-(void)setNav{
    UIButton * btnNav = [UIButton buttonWithType:UIButtonTypeCustom];
    btnNav.frame = CGRectMake(0, 0, 25, 25);
    [btnNav setBackgroundImage:[UIImage imageNamed:@"ic_can"] forState:UIControlStateNormal];
    [btnNav addTarget:self action:@selector(scanBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:btnNav];
    self.navigationItem.rightBarButtonItem = item;
}

-(void)scanBtnClick{
    
}

-(void)setUI{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTabbarHeight-kNavigationBarAndStateBarHeight) style:UITableViewStyleGrouped];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.sectionHeaderHeight = 52.0f;
    self.tableView.sectionFooterHeight = 0.0f;
    self.tableView.tableHeaderView = self.headView;
    
    self.tableView.bounces = YES;

    [self.tableView registerNib:[UINib nibWithNibName:@"NDHomeGoodsCell" bundle:nil] forCellReuseIdentifier:@"NDHomeGoodsCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"NDHomeLikeCell" bundle:nil] forCellReuseIdentifier:@"NDHomeLikeCell"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}
#pragma mark - tableview

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 || indexPath.section == 1) {
        return 170;
    }else{
        
        CGFloat H =kScreenWidth * 180.0 / (kScreenWidth - 24) + 44;
        
        return H;
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0 || section == 1) {
        return 1;
    }else{
        return 3;
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NDHomeSetionHeadView * headView = [[NSBundle mainBundle] loadNibNamed:@"NDHomeSetionHeadView" owner:self options:nil].firstObject;
    headView.frame = CGRectMake(0, 0, kScreenWidth, 52);
    if (section == 0) {
        headView.labelDes.text = @"最新商品";
    }else if (section == 1){
        headView.labelDes.text = @"人气商品";
        headView.viewLeftLine.backgroundColor = HEXCOLOR(0xfc6d35);
    }else if (section == 2){
        headView.labelDes.text = @"猜你喜欢";
        [headView hideRightView];
    }
    
    return headView;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0 || indexPath.section == 1) {
        NDHomeGoodsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NDHomeGoodsCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        NDHomeLikeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NDHomeLikeCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(NDHomeHeadView *)headView{
    if (_headView == nil) {
        _headView = [[NDHomeHeadView alloc] init];
        _headView.frame = CGRectMake(0, 0, kScreenWidth, cycleView_H+44);
    }
    return _headView;
}

@end
