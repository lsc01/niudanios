//
//  NDGoodsDetailViewController.m
//  niudanios
//
//  Created by lsc on 2018/10/17.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDGoodsDetailViewController.h"
#import "NDVerifyOrderTableViewCell.h"
@interface NDGoodsDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *arrGoodsModel;
@end

@implementation NDGoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"商品详情";
    [self postRequest];
     [self setUI];
    
}

-(void)postRequest{
    NSMutableDictionary * dictP = [NSMutableDictionary dictionary];
    [dictP setObject:self.orderId forKey:@"id"];
    
    [SVProgressHUD show];
    [HLLHttpManager postWithURL:URL_ordertwistedEgg params:dictP success:^(NSDictionary *responseObject) {
        [SVProgressHUD dismiss];
        NSArray * arrayRows = responseObject[@"rows"];
        self.arrGoodsModel = nil;
        for (NSDictionary * dict in arrayRows) {
            NDPackageGoodsModel * model = [NDPackageGoodsModel mj_objectWithKeyValues:dict];
            [self.arrGoodsModel addObject:model];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showToast:@"获取失败"];
    }];
}

-(void)setUI{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavigationBarAndStateBarHeight-44) style:UITableViewStylePlain];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.sectionHeaderHeight = 10.0f;
    self.tableView.bounces = YES;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NDVerifyOrderTableViewCell" bundle:nil] forCellReuseIdentifier:@"NDVerifyOrderTableViewCell"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
  
}


#pragma mark - tableview

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.arrGoodsModel.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 93.0f;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NDVerifyOrderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NDVerifyOrderTableViewCell"  forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NDPackageGoodsModel * model = self.arrGoodsModel[indexPath.section];
    cell.model = model;
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(NSMutableArray *)arrGoodsModel{
    if (_arrGoodsModel == nil) {
        _arrGoodsModel = [NSMutableArray array];
    }
    return _arrGoodsModel;
}
@end
