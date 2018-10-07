//
//  NDMineOrderViewController.m
//  niudanios
//
//  Created by lsc on 2018/9/2.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDMineOrderViewController.h"
#import "NDMineOrderSelectView.h"
#import "NDMineOrderTableViewCell.h"
#import "NDMineOrderDetailViewController.h"
#import "NDMineOrderInfoModel.h"
#import "UIScrollView+EmptyDataSet.h"
@interface NDMineOrderViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>


@property(nonatomic,strong)UITableView *tableView;

@property (nonatomic ,strong) NSMutableArray * arrData;

@end

@implementation NDMineOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我的订单";
    
    [self setUI];
}

-(void)postRequest:(NSInteger)selectTag{
    self.selectTag = selectTag;
    [SVProgressHUD show];
    NSMutableDictionary * dictP = [NSMutableDictionary dictionary];
    [dictP setObject:@(10) forKey:@"rows"];
    [dictP setObject:@(1) forKey:@"page"];
    [dictP setObject:@(1) forKey:@"customerId"];
    switch (selectTag) {
        case 1:
        {
            [dictP setObject:@"DF" forKey:@"status"];
        }
            break;
        case 2:
        {
            [dictP setObject:@"DS" forKey:@"status"];
        }
            break;
        case 3:
        {
            [dictP setObject:@"YS" forKey:@"status"];
        }
            break;
            
        default:
            break;
    }
    
    [HLLHttpManager postWithURL:URL_stotalOrder params:dictP success:^(NSDictionary *responseObject) {
        [SVProgressHUD dismiss];
        NSArray * arrRows = responseObject[@"rows"];
        self.arrData = nil;
        for (NSDictionary * dict in arrRows) {
            NDMineOrderInfoModel * model = [NDMineOrderInfoModel mj_objectWithKeyValues:dict];
            [self.arrData addObject:model];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
        [SVProgressHUD dismiss];
    }];
}

-(void)setUI{
    NDMineOrderSelectView * view = [[NSBundle mainBundle] loadNibNamed:@"NDMineOrderSelectView" owner:self options:nil].firstObject;
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    WeakSelf();
    [view setSelectBtnStatusBlock:^(NSInteger tag) {
        StrongSelf();
        [strongself postRequest:tag];
    }];
    view.viewLine.hidden = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        view.viewLine.hidden = NO;
        [view setSelectNormalWithTag:self.selectTag];
    });
    
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.sectionHeaderHeight = 10.0f;
    self.tableView.bounces = YES;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NDMineOrderTableViewCell" bundle:nil] forCellReuseIdentifier:@"NDMineOrderTableViewCell"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(view.mas_bottom);
    }];
}

#pragma mark - tableview

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.arrData.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 168;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NDMineOrderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NDMineOrderTableViewCell"     forIndexPath:indexPath];
    
    NDMineOrderInfoModel * model = self.arrData[indexPath.section];
    cell.model = model;
    WeakSelf();
    [cell setRigthBtnActionBlock:^(NSString *Id, OrderState orderState) {
        StrongSelf();
        [strongself cellRigthBtnActionWithId:Id andOrderState:orderState];
    }];
    return cell;
    
}

-(void)cellRigthBtnActionWithId:(NSString *)Id andOrderState:(OrderState)state{
    switch (state) {
        case OrderState_1:
        {
            [self cellRemindSendWithId:Id];
        }
            break;
        case OrderState_2:
        {
            [self cellOrderDetailWithId:Id];
        }
            break;
        case OrderState_3:
        {
            [self cellDeleteOrderWithId:Id];
        }
            break;
            
        default:
            break;
    }
}

-(void)cellRemindSendWithId:(NSString *)Id{
    NSMutableDictionary * dictP = [NSMutableDictionary dictionary];
    [dictP setObject:Id forKey:@"id"];

    [SVProgressHUD show];
    [HLLHttpManager postWithURL:URL_remindOrder params:dictP success:^(NSDictionary *responseObject) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showToast:@"已提醒发货"];
        
    } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showToast:@"操作失败"];
     
    }];
}

-(void)cellOrderDetailWithId:(NSString *)Id{
    NSMutableDictionary * dictP = [NSMutableDictionary dictionary];
    [dictP setObject:Id forKey:@"id"];
    
    [SVProgressHUD show];
    [HLLHttpManager postWithURL:URL_detailOrder params:dictP success:^(NSDictionary *responseObject) {
        [SVProgressHUD dismiss];
        NSArray * arrRows = responseObject[@"rows"];
        if (arrRows.count >0) {
            NSDictionary * dictT = arrRows.firstObject;
           
        }
        
    } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showToast:@"操作失败"];
     
    }];
}

-(void)cellDeleteOrderWithId:(NSString *)Id{
    NSMutableDictionary * dictP = [NSMutableDictionary dictionary];
    [dictP setObject:Id forKey:@"id"];
    
    [SVProgressHUD show];
    [HLLHttpManager postWithURL:URL_deleteOrder params:dictP success:^(NSDictionary *responseObject) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showToast:@"删除成功"];
        [self postRequest:self.selectTag];
    } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showToast:@"操作失败"];
       
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NDMineOrderInfoModel * model = self.arrData[indexPath.section];
    NDMineOrderDetailViewController * vc = [[NDMineOrderDetailViewController alloc] init];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

#pragma mark - 空白页
//空白页显示图片
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"bg_nrd"];
}
//空白页显示标题
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"您还没有任何订单哦";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName:HEXCOLOR(0x999999)
                                 };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}

//将组件彼此上下分离（默认分隔为11个分
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
    return 16.0f;
}


-(NSMutableArray *)arrData{
    if (_arrData == nil) {
        _arrData = [NSMutableArray array];
    }
    return _arrData;
}

@end
