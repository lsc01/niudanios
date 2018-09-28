//
//  NDAccountPayDeatailVC.m
//  niudanios
//
//  Created by lsc on 2018/9/3.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDAccountPayDeatailVC.h"
#import "NDAccountPayDetailCell.h"
#import "NDNiudanFilterView.h"
#import "NDNiudanFilterModel.h"
#import "NDMyWalletRecordModel.h"
@interface NDAccountPayDeatailVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property (strong, nonatomic) NDNiudanFilterView *filterView;

@property (nonatomic ,strong) UIButton * btnTitle;

@property (nonatomic ,strong) NSMutableArray * arrData;

@end

@implementation NDAccountPayDeatailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNav];
    [self setUI];
    [self postRequestWithTag:0];
}
-(void)postRequestWithTag:(NSInteger)tag{
    [SVProgressHUD show];
    NSMutableDictionary * dictP = [NSMutableDictionary dictionary];
    [dictP setObject:@"1" forKey:@"customerId"];
    if (tag!=0) {
        [dictP setObject:@(tag-1) forKey:@"status"];
    }
    
    [HLLHttpManager postWithURL:URL_queryConsume params:dictP success:^(NSDictionary *responseObject) {
        [SVProgressHUD dismiss];
        NSArray * arrRows = responseObject[@"rows"];
        self.arrData = nil;
        for (NSDictionary * dict in arrRows) {
            NDMyWalletRecordModel * model = [NDMyWalletRecordModel mj_objectWithKeyValues:dict];
            [self.arrData addObject:model];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
        [SVProgressHUD dismiss];
    }];
}


-(void)setNav{
    self.navigationItem.titleView = self.btnTitle;
    
}

-(void)setUI{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.bounces = NO;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NDAccountPayDetailCell" bundle:nil] forCellReuseIdentifier:@"NDAccountPayDetailCell"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    self.filterView = [[NDNiudanFilterView alloc] init];
    [self.view addSubview:self.filterView];
    [self.filterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.view bringSubviewToFront:self.filterView];
    self.filterView.hidden = YES;
    [self setFilterArray];
    WeakSelf();
    [self.filterView setSelectRowBlock:^(NSInteger row) {
        StrongSelf();
        NDNiudanFilterModel * model = strongself.filterView.arrayModel[row];
        [strongself.btnTitle setTitle:model.textValue forState:UIControlStateNormal];
        strongself.filterView.hidden = YES;
        [strongself postRequestWithTag:row];
    }];
}
-(void)setFilterArray{
    
    NDNiudanFilterModel * model = [[NDNiudanFilterModel alloc] init];
    model.textValue = @"全部";
    model.textColor = HEXCOLOR(kBaseColor);
    NDNiudanFilterModel * model2 = [[NDNiudanFilterModel alloc] init];
    model2.textValue = @"充值";
    model2.textColor = HEXCOLOR(0x222222);
    NDNiudanFilterModel * model3 = [[NDNiudanFilterModel alloc] init];
    model3.textValue = @"扭蛋";
    model3.textColor = HEXCOLOR(0x222222);
    NDNiudanFilterModel * mode4 = [[NDNiudanFilterModel alloc] init];
    mode4.textValue = @"奖励";
    mode4.textColor = HEXCOLOR(0x222222);
    NDNiudanFilterModel * model5 = [[NDNiudanFilterModel alloc] init];
    model5.textValue = @"订单";
    model5.textColor = HEXCOLOR(0x222222);
    
    self.filterView.arrayModel = @[model,model2,model3,mode4,model5];
}




-(void)titlebtnSelectClick{
    NSLog(@"全部");
    self.filterView.hidden = !self.filterView.hidden;
}



#pragma mark - tableview

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 69.0f;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.arrData.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NDAccountPayDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NDAccountPayDetailCell"  forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NDMyWalletRecordModel * model = self.arrData[indexPath.row];
    cell.model = model;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



-(UIButton *)btnTitle{
    if (_btnTitle == nil) {
        _btnTitle = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnTitle setTitle:@"全部" forState:UIControlStateNormal];
        [_btnTitle setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnTitle setImage:[UIImage imageNamed:@"cl_wt"] forState:UIControlStateNormal];
        [_btnTitle setImage:[UIImage imageNamed:@"cl_wt"] forState:UIControlStateHighlighted];
        NSDictionary *attribute = @{NSFontAttributeName:_btnTitle.titleLabel.font};
        //获取文本的宽度
        CGFloat btnWidth = [_btnTitle.titleLabel.text boundingRectWithSize:CGSizeMake(0, 30)
                                                             options:\
                            NSStringDrawingTruncatesLastVisibleLine |
                            NSStringDrawingUsesLineFragmentOrigin |
                            NSStringDrawingUsesFontLeading
                                                          attributes:attribute
                                                             context:nil].size.width;
        
        
        //通过调节文本和图片的内边距到达目的
        _btnTitle.imageEdgeInsets = UIEdgeInsetsMake(0, btnWidth, 0, -btnWidth);
        [_btnTitle setTitleEdgeInsets:UIEdgeInsetsMake(0, -_btnTitle.imageView.image.size.width, 0, _btnTitle.imageView.image.size.width)];

        _btnTitle.titleLabel.font = [UIFont systemFontOfSize:18.0];
        _btnTitle.frame = CGRectMake(0, 0, 60, 30);
        [_btnTitle addTarget:self action:@selector(titlebtnSelectClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnTitle;
}

-(NSMutableArray *)arrData{
    if (_arrData == nil) {
        _arrData = [NSMutableArray array];
    }
    return _arrData;
}


@end
