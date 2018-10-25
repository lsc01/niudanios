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
#import "UIScrollView+EmptyDataSet.h"
@interface NDPackageViewController ()<UITableViewDelegate,UITableViewDataSource,NDVerifyOrderViewControllerDelegate,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *btnAllSelect;

@property (weak, nonatomic) IBOutlet UILabel *labelSelect;

@property (weak, nonatomic) IBOutlet UILabel *labelDes;

@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;

@property (nonatomic ,strong) NSMutableArray * arrData;

@property (nonatomic ,strong) NSMutableArray * arrID;//记录选中的id
@property (weak, nonatomic) IBOutlet UIView *viewBottomTool;

@end

@implementation NDPackageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"我的扭蛋";
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    self.viewBottomTool.hidden = YES;
    [self setUI];
    [SVProgressHUD show];
//    [self postQueryPostage];
}

-(void)postQueryPostage{
 
    [HLLHttpManager postWithURL:URL_queryPostage params:nil success:^(NSDictionary *responseObject) {
        NSArray * arrRows = responseObject[@"rows"];
        if (arrRows.count>0) {
            NSDictionary * dict = arrRows.firstObject;
            NSNumber * count = dict[@"number"];
            self.labelDes.text = [NSString stringWithFormat:@"满%@件包邮",count];
        }
    } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
        
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self postRequest];
}

-(void)postRequest{
    
    NSMutableDictionary * dictP = [NSMutableDictionary dictionary];
    [dictP setObject:[HLLShareManager shareMannager].userModel.Id forKey:@"customerId"];
    [HLLHttpManager postWithURL:URL_queryBackpack params:dictP success:^(NSDictionary *responseObject) {
        NSArray * arrRows = responseObject[@"rows"];
        if (arrRows.count > 0) {
            NSDictionary * dictT = arrRows.firstObject;
            NSArray * arrlistBackpack = dictT[@"listBackpack"];
            self.arrData = nil;
            self.arrID = nil;
            for (NSDictionary * dict in arrlistBackpack) {
                NDPackageGoodsModel * model = [NDPackageGoodsModel mj_objectWithKeyValues:dict];
                [self.arrData addObject:model];
            }
            [self.tableView reloadData];
            if (self.arrData.count>0) {
                self.viewBottomTool.hidden = NO;
                NSNumber * count = dictT[@"number"];
                self.labelDes.text = [NSString stringWithFormat:@"满%@件包邮",count];
            }else{
                self.viewBottomTool.hidden = YES;
            }
            [self.arrID removeAllObjects];
            if (self.arrID.count==0) {
                self.btnAllSelect.selected = NO;
            }
            self.labelSelect.text = [NSString stringWithFormat:@"已选择%d件",self.arrID.count];
        }
        
        [SVProgressHUD dismiss];
    } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
        [SVProgressHUD dismiss];
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
            [self.arrID addObject:model];
        }
    }
    self.labelSelect.text = [NSString stringWithFormat:@"已选择%d件",self.arrID.count];
    [self.tableView reloadData];
}
- (IBAction)submitOrderClick:(UIButton *)sender {
    if (self.arrID.count==0) {
        [SVProgressHUD showToast:@"请选择商品"];
        return;
    }
    
    NSMutableDictionary * dictP = [NSMutableDictionary dictionary];
    [dictP setObject:[HLLShareManager shareMannager].userModel.Id forKey:@"customerId"];
    [HLLHttpManager postWithURL:URL_selfitemreplace params:dictP success:^(NSDictionary *responseObject) {
        
        NSArray * arrRows = responseObject[@"rows"];
        if (arrRows.count>=1) {
            NSDictionary * dictT = arrRows.firstObject;
            if ([dictT[@"count"] integerValue] == 0) {
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
                    vc.delegate = self;
                    [self.navigationController pushViewController:vc animated:YES];
                    
                } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
                    [SVProgressHUD dismiss];
                    [SVProgressHUD showToast:@"下单失败,请重试"];
                }];
            }else{
                [SVProgressHUD dismiss];
                [SVProgressHUD showToast:@"有扭蛋到期"];
            }
            
        }else{
           [SVProgressHUD dismiss];
        }
        
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
    [dictP setObject:[HLLShareManager shareMannager].userModel.Id forKey:@"customerId"];
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
            if (strongself.arrID.count==0) {
                self.btnAllSelect.selected = NO;
            }
        }
        strongself.labelSelect.text = [NSString stringWithFormat:@"已选择%d件",strongself.arrID.count];
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


#pragma mark - 空白页
//空白页显示图片
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"bg_enpty"];
}
//空白页显示标题
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"这里是空的哦~~~";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:12.0f],
                                 NSForegroundColorAttributeName:HEXCOLOR(0x999999)
                                 };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}
//空白页显示详细描述
//- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
//    NSString *text = @"暂时没有已上课程";
//
//    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
//    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
//    paragraph.alignment = NSTextAlignmentCenter;
//
//    NSDictionary *attributes = @{
//                                 NSFontAttributeName:[UIFont systemFontOfSize:14.0f],
//                                 NSForegroundColorAttributeName:[UIColor lightGrayColor],
//                                 NSParagraphStyleAttributeName:paragraph
//                                 };
//
//    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
//}

//将组件彼此上下分离（默认分隔为11个分
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
    return 16.0f;
}





#pragma mark - 提交订单成功代理回调
-(void)submitOrderSucceed{
    [SVProgressHUD show];
//    [self postRequest];
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
