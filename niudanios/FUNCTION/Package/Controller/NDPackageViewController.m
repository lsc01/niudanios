//
//  NDPackageViewController.m
//  niudanios
//
//  Created by lsc on 2018/8/23.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDPackageViewController.h"
#import "NDPackageTableViewCell.h"
#import "NDVerifyOrderViewController.h"
#import "NDPackageGoodsModel.h"
@interface NDPackageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *btnAllSelect;

@property (weak, nonatomic) IBOutlet UILabel *labelSelect;

@property (weak, nonatomic) IBOutlet UILabel *labelDes;

@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;

@property (nonatomic ,strong) NSMutableArray * arrData;

@property (nonatomic ,strong) NSMutableArray * arrID;//记录选中的id

@end

@implementation NDPackageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [self setUI];
    
    [self postRequest];
}

-(void)postRequest{
    NSMutableDictionary * dictP = [NSMutableDictionary dictionary];
    [dictP setObject:@(1) forKey:@"customerId"];
    [HLLHttpManager postWithURL:URL_queryBackpack params:dictP success:^(NSDictionary *responseObject) {
        NSArray * arrRows = responseObject[@"rows"];
        self.arrData = nil;
        for (NSDictionary * dict in arrRows) {
            NDPackageGoodsModel * model = [NDPackageGoodsModel mj_objectWithKeyValues:dict];
            [self.arrData addObject:model];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
        
    }];
}

-(void)setUI{
    self.btnAllSelect.layer.cornerRadius = 10;
    self.btnAllSelect.clipsToBounds = YES;
    self.btnAllSelect.layer.borderColor = [UIColor whiteColor].CGColor;
    self.btnAllSelect.layer.borderWidth = 1;
    
    
    self.btnSubmit.layer.cornerRadius = 4;
    self.btnSubmit.clipsToBounds = YES;
    

    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.bounces = YES;
    self.tableView.sectionFooterHeight = 10.0f;
    [self.tableView registerNib:[UINib nibWithNibName:@"NDPackageTableViewCell" bundle:nil] forCellReuseIdentifier:@"NDPackageTableViewCell"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}




- (IBAction)selectAllClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self.arrID removeAllObjects];
    if (sender.selected) {
        for (NDPackageGoodsModel * model in self.arrData) {
            [self.arrID addObject:model.Id];
        }
    }
    [self.tableView reloadData];
}
- (IBAction)submitOrderClick:(UIButton *)sender {
    if (self.arrID.count==0) {
        [SVProgressHUD showToast:@"请选择商品"];
        return;
    }
    
    NSMutableDictionary * dictP = [NSMutableDictionary dictionary];
    [dictP setObject:@"1" forKey:@"customerId"];
    [HLLHttpManager postWithURL:URL_selectDefaultAddr params:dictP success:^(NSDictionary *responseObject) {
        [SVProgressHUD dismiss];
        NSArray * arrRows = responseObject[@"rows"];
        NDSelectDefaultAddrModel * addrModel = nil;
        if (arrRows.count>=1) {
            NSDictionary * dictT = arrRows.firstObject;
            addrModel =[NDSelectDefaultAddrModel mj_objectWithKeyValues:dictT];
        }else{
            NDSelectDefaultAddrModel * model = [[NDSelectDefaultAddrModel alloc] init];
            model.cond = @"N";
            addrModel = model;
        }
        
        NDVerifyOrderViewController * vc = [[NDVerifyOrderViewController alloc] init];
        vc.defaultAddrModel = addrModel;
        vc.arrGoodsModel = self.arrID;
        [self.navigationController pushViewController:vc animated:YES];
        
    } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showToast:@"下单失败,请重试"];
    }];
    
    return;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD show];
    });
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_async(group, queue, ^{
        
        [self httpGetSelectBackpackFinish:^{
            dispatch_semaphore_signal(semaphore);
            
        }];
    });
    
    dispatch_group_async(group, queue, ^{
        
        [self httpGetSelectDefaultAddrFinish:^{
            dispatch_semaphore_signal(semaphore);
            
        }];
    });
    
    
    dispatch_group_notify(group, queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            NDVerifyOrderViewController * vc = [[NDVerifyOrderViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];

        });
    });

}
-(void)httpGetSelectBackpackFinish:(void(^)(void))finishBlock{
    NSMutableString * stringData = [NSMutableString string];
    for (int i = 0; i<self.arrID.count; i++) {
        [stringData appendString:self.arrID[i]];
        if (i!=self.arrID.count -1) {
            [stringData appendString:@","];
        }
    }
    NSMutableDictionary * dictP = [NSMutableDictionary dictionary];
    [dictP setObject:stringData forKey:@"data"];
    [HLLHttpManager postWithURL:URL_selectBackpack params:dictP success:^(NSDictionary *responseObject) {
        finishBlock?finishBlock():nil;
    } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
        finishBlock?finishBlock():nil;
    }];
}

-(void)httpGetSelectDefaultAddrFinish:(void(^)(void))finishBlock{
    
    NSMutableDictionary * dictP = [NSMutableDictionary dictionary];
    [dictP setObject:@"1" forKey:@"customerId"];
    [HLLHttpManager postWithURL:URL_selectDefaultAddr params:dictP success:^(NSDictionary *responseObject) {
        finishBlock?finishBlock():nil;
    } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
        finishBlock?finishBlock():nil;
    }];
}
    

#pragma mark - tableview

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.arrData.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 93.0f;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NDPackageGoodsModel * model = self.arrData[indexPath.section];
    
    NDPackageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NDPackageTableViewCell"  forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = model;
    WeakSelf();
    [cell setSelectGoodsBlock:^(BOOL selected, NDPackageGoodsModel *goodsModel) {
        StrongSelf();
        if (selected) {
            [strongself.arrID addObject:goodsModel];
        }else{
            [strongself.arrID removeObject:goodsModel];
        }
    }];
    if (self.btnAllSelect.selected) {
        cell.btnSelect.selected = YES;
    }else{
        cell.btnSelect.selected = NO;
    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(NSMutableArray *)arrData{
    if (_arrData == nil) {
        _arrData = [NSMutableArray array];
    }
    return _arrData;
}

-(NSMutableArray *)arrID{
    if (_arrID == nil) {
        _arrID = [NSMutableArray array];
    }
    return _arrID;
}

@end
