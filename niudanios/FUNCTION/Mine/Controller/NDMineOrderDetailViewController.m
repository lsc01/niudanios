//
//  NDMineOrderDetailViewController.m
//  niudanios
//
//  Created by lsc on 2018/9/2.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDMineOrderDetailViewController.h"
#import "NDMineOrderDetailView.h"
#import "NDOrderDetailTableViewCell.h"
#import "NDLogisticsDetailViewController.h"
#import "NDOrderDetailInfoModel.h"
@interface NDMineOrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) NDMineOrderDetailView * headerView;

@property(nonatomic,strong) UITableView *tableView;

@property (nonatomic ,strong) NDOrderDetailInfoModel * modelInfo;

@end

@implementation NDMineOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"订单详情";
    [self setUI];
    [self postRequest];
}

-(void)postRequest{
    [SVProgressHUD show];
    NSMutableDictionary * dictP = [NSMutableDictionary dictionary];
//    [dictP setObject:self.model.Id forKey:@"id"];
    [dictP setObject:@"260029793869096960" forKey:@"id"];
   
    [HLLHttpManager postWithURL:URL_detailOrder params:dictP success:^(NSDictionary *responseObject) {
        [SVProgressHUD dismiss];
        NSArray * arrRows = responseObject[@"rows"];
        if (arrRows.count>0) {
            NSDictionary * dict = arrRows.firstObject;
            self.modelInfo = [NDOrderDetailInfoModel mj_objectWithKeyValues:dict];
        }
        self.headerView.model = self.modelInfo;
        [self.tableView reloadData];
    } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
        [SVProgressHUD dismiss];
    }];
}

-(void)setUI{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavigationBarAndStateBarHeight-kTabbarHeight) style:UITableViewStylePlain];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.sectionHeaderHeight = 10.0f;
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.bounces = YES;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NDOrderDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"NDOrderDetailTableViewCell"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    WeakSelf();
    [self.headerView setLookOrderLogisticsDetailBlock:^{
        StrongSelf();
        NDLogisticsDetailViewController * vc = [[NDLogisticsDetailViewController alloc] init];
        vc.modelInfo = strongself.modelInfo;
        [strongself.navigationController pushViewController:vc animated:YES];
    }];
}


#pragma mark - tableview

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 92.0f;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.modelInfo==nil?0:1;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NDOrderDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NDOrderDetailTableViewCell"     forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    [cell.imageViewOrder sd_setImageWithURL:[NSURL URLWithString:ImageUrl(self.modelInfo.gashaponImg)] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        NSLog(@"error:%@",error);
    }];
    cell.labelOrderId.text = self.modelInfo.Id;
    cell.labelGoodsName.text = self.modelInfo.gashaponName;
    cell.labelMoney.text =[NSString stringWithFormat:@"¥ %d",self.modelInfo.freightMoney];
    
    return cell;
   
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
}




-(NDMineOrderDetailView *)headerView{
    if(_headerView == nil){
        _headerView = [[NSBundle mainBundle] loadNibNamed:@"NDMineOrderDetailView" owner:self options:nil].firstObject;
        _headerView.frame = CGRectMake(0, 0, kScreenWidth, 229);
        _headerView.backgroundColor = [UIColor whiteColor];
    }
    return _headerView;
}



@end
