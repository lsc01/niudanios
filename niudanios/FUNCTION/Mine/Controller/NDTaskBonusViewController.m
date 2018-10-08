//
//  NDTaskBonusViewController.m
//  niudanios
//
//  Created by lsc on 2018/9/4.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDTaskBonusViewController.h"
#import "NDTaskBonusTableViewCell.h"

#import "NDTaskBonusModel.h"
@interface NDTaskBonusViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic ,strong) NSMutableArray * arrData;

@end

@implementation NDTaskBonusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"任务奖励";
    [self setUI];
    [SVProgressHUD show];
    [self postRequest];
}


-(void)postRequest{
    
    NSMutableDictionary * dictP = [NSMutableDictionary dictionary];
    [dictP setObject:[HLLShareManager shareMannager].userModel.Id forKey:@"id"];
    
    [HLLHttpManager postWithURL:URL_queryBounty params:dictP success:^(NSDictionary *responseObject) {
        [SVProgressHUD dismiss];
        NSArray * arrRows = responseObject[@"rows"];
        self.arrData = nil;
        for (NSDictionary * dict in arrRows) {
            NDTaskBonusModel * model = [NDTaskBonusModel mj_objectWithKeyValues:dict];
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
    [self.tableView registerNib:[UINib nibWithNibName:@"NDTaskBonusTableViewCell" bundle:nil] forCellReuseIdentifier:@"NDTaskBonusTableViewCell"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
}
#pragma mark - tableview

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return Kcell_height;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.arrData.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NDTaskBonusTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NDTaskBonusTableViewCell"  forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NDTaskBonusModel *model = self.arrData[indexPath.row];
    cell.model = model;
    
    WeakSelf();
    [cell setGetTaskBonusBlock:^(NDTaskBonusModel *model) {
        StrongSelf();
        [strongself getTaskBonusWithId:model.Id];
    }];
    
    return cell;
    
}

-(void)getTaskBonusWithId:(NSString *)ID{
    [SVProgressHUD showWithStatus:@"正在领取"];
    NSMutableDictionary * dictP = [NSMutableDictionary dictionary];
    [dictP setObject:ID forKey:@"id"];
    
    [HLLHttpManager postWithURL:URL_receiveHortation params:dictP success:^(NSDictionary *responseObject) {
        
        NSArray * arrRows = responseObject[@"rows"];
        
        if (arrRows.count>0) {
            NSDictionary * dictT = arrRows.firstObject;
//            0代表失败，1代表成功
            NSInteger count = [dictT[@"count"] integerValue];
            if (count == 0) {
                [SVProgressHUD dismiss];
                [SVProgressHUD showToast:@"领取失败"];
            }else{
                [SVProgressHUD showToast:@"领取成功"];
                [self postRequest];
            }
        }
    } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showToast:@"领取失败"];
    }];
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
@end
