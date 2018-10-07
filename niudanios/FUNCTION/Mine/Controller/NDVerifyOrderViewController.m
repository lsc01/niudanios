//
//  NDVerifyOrderViewController.m
//  niudanios
//
//  Created by lsc on 2018/9/6.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDVerifyOrderViewController.h"
#import "NDVerifyOrderTableViewCell.h"
#import "NDVerifyOrderHeadView.h"
#import "NDAddressEditViewController.h"
#import "NDMineAddressViewController.h"

@interface NDVerifyOrderViewController ()<UITableViewDelegate,UITableViewDataSource,NDMineAddressViewControllerDelegate>


@property (strong, nonatomic) UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *labelTotalGoods;
@property (weak, nonatomic) IBOutlet UILabel *labelYunfei;

@property (nonatomic ,strong) NDVerifyOrderHeadView * headView;
@property (nonatomic ,copy) NSString * yunfei;
@end

@implementation NDVerifyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"确认订单";
    self.labelTotalGoods.text = [NSString stringWithFormat:@"共%d件商品",self.arrGoodsModel.count];
    if ([self.defaultAddrModel.cond isEqualToString:@"N"]) {
        self.labelYunfei.text = @"(快递费0元)";
        self.yunfei = @"0";
    }else{
        //通过区计算快递费
        [self calculateYunfeiWithAredId:self.defaultAddrModel.areaId];
    }
    [self setUI];
    
}


-(void)calculateYunfeiWithAredId:(NSString *)aredId{
    NSMutableDictionary * dictP = [NSMutableDictionary dictionary];
    [dictP setObject:aredId forKey:@"aredId"];
    
    [SVProgressHUD show];
    [HLLHttpManager postWithURL:URL_squeryDistinguish params:dictP success:^(NSDictionary *responseObject) {
        [SVProgressHUD dismiss];
        NSArray * arrayRows = responseObject[@"rows"];
        if (arrayRows.count>0) {
            NSDictionary * dictRow = arrayRows.firstObject;
            self.labelYunfei.text = [NSString stringWithFormat:@"(快递费%@元)",dictRow[@"money"]];
            self.yunfei = dictRow[@"money"];
        }
        
    } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
        [SVProgressHUD dismiss];
    }];
    
}
- (IBAction)submitOrderClick:(UIButton *)sender {
    NSMutableString * dataParams = [NSMutableString string];
    for (NSInteger i=0; i<self.arrGoodsModel.count; i++) {
        NDPackageGoodsModel * model = self.arrGoodsModel[i];
        [dataParams appendString:model.Id];
        if (i != self.arrGoodsModel.count-1) {
            [dataParams appendString:@","];
        }
    }

    NSMutableDictionary * dictP = [NSMutableDictionary dictionary];
    [dictP setObject:self.yunfei forKey:@"money"];
    [dictP setObject:dataParams forKey:@"data"];
    [dictP setObject:self.defaultAddrModel.Id forKey:@"addressId"];
    [dictP setObject:@"1" forKey:@"customerId"];
    
    [SVProgressHUD showWithStatus:@"正在提交"];
    [HLLHttpManager postWithURL:URL_order_confirm params:dictP success:^(NSDictionary *responseObject) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showToast:@"下单成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([self.delegate respondsToSelector:@selector(submitOrderSucceed)]) {
                [self.delegate submitOrderSucceed];
            }
            [self.navigationController popViewControllerAnimated:YES];
        });
        
    } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
        [SVProgressHUD dismiss];
    }];
    
    
    
}
-(void)setUI{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNavigationBarAndStateBarHeight-44) style:UITableViewStylePlain];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.sectionHeaderHeight = 10.0f;
    self.tableView.tableHeaderView = self.headView;
    self.tableView.bounces = YES;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NDVerifyOrderTableViewCell" bundle:nil] forCellReuseIdentifier:@"NDVerifyOrderTableViewCell"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    WeakSelf();
    [self.headView setAddNewAddrBlock:^{
        StrongSelf();
        NDAddressEditViewController * vc = [[NDAddressEditViewController alloc] init];
        [strongself.navigationController pushViewController:vc animated:YES];
    }];
    
    [self.headView setReplaceAddressBlock:^{
        StrongSelf();
        [strongself replaceAddress];
    }];
}

-(void)replaceAddress{
    NDMineAddressViewController * mineAddrVC = [[NDMineAddressViewController alloc] init];
    mineAddrVC.delegate = self;
    [self.navigationController pushViewController:mineAddrVC animated:YES];
}

-(void)selectMineAddressWithModel:(NDSelectDefaultAddrModel *)model{
    self.defaultAddrModel = model;
    _headView.model = self.defaultAddrModel;
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


-(NDVerifyOrderHeadView *)headView{
    if (_headView == nil) {
        _headView = [[NSBundle mainBundle] loadNibNamed:@"NDVerifyOrderHeadView" owner:self options:nil].firstObject;
        _headView.frame = CGRectMake(0, 0, kScreenWidth, 75);
        if ([self.defaultAddrModel.cond isEqualToString:@"N"]) {
            _headView.hasAddress = NO;
        }else{
            _headView.hasAddress = YES;
            _headView.model = self.defaultAddrModel;
        }
    }
    return _headView;
}

@end
