//
//  NDMineAddressViewController.m
//  niudanios
//
//  Created by lsc on 2018/9/5.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDMineAddressViewController.h"
#import "NDMineAddressTableViewCell.h"
#import "NDAddressEditViewController.h"
@interface NDMineAddressViewController ()<UITableViewDelegate,UITableViewDataSource,NDAddressEditViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic ,strong) NSMutableArray * arrData;

@end

@implementation NDMineAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我的收货地址";
    [self setUI];
    [self postRequest];
    
}

-(void)postRequest{
    [SVProgressHUD show];
    NSMutableDictionary * dictP = [NSMutableDictionary dictionary];
    [dictP setObject:@"1" forKey:@"customerId"];
    [HLLHttpManager postWithURL:URL_ShippingAddressfind params:dictP success:^(NSDictionary *responseObject) {
        [SVProgressHUD dismiss];
        self.arrData = nil;
        NSArray * arrRows = responseObject[@"rows"];
        for (NSDictionary * dictT in arrRows) {
            NDSelectDefaultAddrModel * model = [NDSelectDefaultAddrModel mj_objectWithKeyValues:dictT];
            [self.arrData addObject:model];
        }
        [self.tableView reloadData];
        
    } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
        [SVProgressHUD dismiss];
    }];
}

-(void)setUI{
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.bounces = YES;
    self.tableView.sectionFooterHeight = 8.0f;
    [self.tableView registerNib:[UINib nibWithNibName:@"NDMineAddressTableViewCell" bundle:nil] forCellReuseIdentifier:@"NDMineAddressTableViewCell"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}


#pragma mark - tableview

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.arrData.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NDSelectDefaultAddrModel * model = self.arrData[indexPath.section];
    NDMineAddressTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NDMineAddressTableViewCell"  forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.model = model;
    WeakSelf();
    [cell setEditAddressBlock:^{
        StrongSelf();
        [strongself editAddressWithModel:model];
    }];
    
    [cell setDeleteAddressBlock:^{
        StrongSelf();
        [strongself deleteAddressWithModel:model];
    }];
    return cell;
    
}


-(void)editAddressWithModel:(NDSelectDefaultAddrModel *)model{
    NDAddressEditViewController * vc = [[NDAddressEditViewController alloc] init];
    vc.delegate = self;
    vc.modelAddress = model;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)deleteAddressWithModel:(NDSelectDefaultAddrModel *)model{
    WeakSelf();
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定删除？" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        StrongSelf();
        //点击按钮响应事件
        [SVProgressHUD show];
        NSMutableDictionary * dictP = [NSMutableDictionary dictionary];
        [dictP setObject:model.Id forKey:@"id"];
        
        [HLLHttpManager postWithURL:URL_ShippingAddressdelete params:dictP success:^(NSDictionary *responseObject) {
            [SVProgressHUD dismiss];
            [SVProgressHUD showToast:@"删除成功"];
            [strongself postRequest];
        } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
            [SVProgressHUD dismiss];
            [SVProgressHUD showToast:@"删除失败"];
        }];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //点击按钮响应事件
    }]];
    [self presentViewController:alert animated:YES completion:nil];
    
    
   
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NDSelectDefaultAddrModel * model = self.arrData[indexPath.section];
    if ([self.delegate respondsToSelector:@selector(selectMineAddressWithModel:)]) {
        [self.delegate selectMineAddressWithModel:model];
    }
}

- (IBAction)addNewAddressClick:(UIButton *)sender {
    NDAddressEditViewController * vc = [[NDAddressEditViewController alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)addNewAddrSuccess{
    [self postRequest];
}

-(NSMutableArray *)arrData{
    if (_arrData == nil) {
        _arrData = [NSMutableArray array];
    }
    return _arrData;
}
@end
