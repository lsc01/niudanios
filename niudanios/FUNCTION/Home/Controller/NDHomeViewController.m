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
#import "NDPopularityGoodsViewController.h"
#import "NDNewGoodsViewController.h"
#import "NDGoodsPayViewController.h"
#import "SYQRCodeViewController.h"
#import "NDHomeBannerModel.h"
#import "NDHomeNewMessageModel.h"
#import "NDGoodsInfoModel.h"
#import "NDBaseWebViewController.h"
#import "NDLoginViewController.h"
#import "DHGuidePageHUD.h"
@interface NDHomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) NDHomeHeadView * headView;

@property(nonatomic,strong)UITableView *tableView;

@property (nonatomic ,strong) NSArray * arrBannerModel;
@property (nonatomic ,strong) NSArray * arrNewMsgModel;
    
///最新商品
@property (nonatomic ,strong) NSArray * arrHomeNewModel;
///猜你喜欢
@property (nonatomic ,strong) NSArray * arrHomeLikeModel;
///最新商品
@property (nonatomic ,strong) NSArray * arrHomePeopleModel;

///当前点击的是哪个，用来验证登录 0 最新商品  1人气商品
@property (nonatomic ,assign) NSInteger selectIndex;
    


@end

@implementation NDHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     [self setStaticGuidePage];
    [self setNav];
    [self setUI];
//    [self performSelector:@selector(httpGetInfoRequest) withObject:nil afterDelay:0.5];
    [SVProgressHUD show];
    [self postGetAllRequest];
}
    
- (void)setStaticGuidePage {
    NSArray *imageNameArray = @[@"start1.jpg",@"start2.jpeg",@"start3.jpeg",@"start4.jpeg",@"start5.jpg"];
    DHGuidePageHUD *guidePage = [[DHGuidePageHUD alloc] dh_initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) imageNameArray:imageNameArray buttonIsHidden:NO];
    guidePage.slideInto = YES;
    [self.tabBarController.view addSubview:guidePage];
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
    SYQRCodeViewController *QRVC = [SYQRCodeViewController new];
    WeakSelf();
    [QRVC setSYQRCodeSuncessBlock:^(SYQRCodeViewController *vc, NSString *qrString) {
        StrongSelf();
        [strongself.navigationController popViewControllerAnimated:NO];
        NSLog(@"string:%@",qrString);
        
        NDGoodsPayViewController * vcpay = [[NDGoodsPayViewController alloc] init];
        [strongself.navigationController pushViewController:vcpay animated:YES];
    }];
    [QRVC setSYQRCodeFailBlock:^(SYQRCodeViewController *vc) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [QRVC setSYQRCodeCancleBlock:^(SYQRCodeViewController *vc) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationController pushViewController:QRVC animated:YES];
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
        return self.arrHomeLikeModel.count;
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NDHomeSetionHeadView * headView = [[NSBundle mainBundle] loadNibNamed:@"NDHomeSetionHeadView" owner:self options:nil].firstObject;
    headView.frame = CGRectMake(0, 0, kScreenWidth, 52);
    headView.index = section;
    if (section == 0) {
        headView.labelDes.text = @"最新商品";
        
    }else if (section == 1){
        headView.labelDes.text = @"人气商品";
        headView.viewLeftLine.backgroundColor = HEXCOLOR(0xfc6d35);
    }else if (section == 2){
        headView.labelDes.text = @"猜你喜欢";
        [headView hideRightView];
    }
    
    WeakSelf();
    [headView setMoreGoodsBlock:^(NSInteger index) {
        StrongSelf();
        if (!Is_Login) {
            strongself.selectIndex = index;
            [strongself gotoLoginViewController];
            return ;
        }
    
        if (index == 0) {
            NDNewGoodsViewController * vc = [[NDNewGoodsViewController alloc] init];
            [strongself.navigationController pushViewController:vc animated:YES];
        }else if (index == 1){
            NDPopularityGoodsViewController * vc = [[NDPopularityGoodsViewController alloc] init];
            
            [strongself.navigationController pushViewController:vc animated:YES];
        }
    }];
    
    return headView;
}

-(void)loginAccountSuccess{
    NSLog(@"。。。");
    if (self.selectIndex == 0) {
        NDNewGoodsViewController * vc = [[NDNewGoodsViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (self.selectIndex == 1){
        NDNewGoodsViewController * vc = [[NDNewGoodsViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (self.selectIndex == 2){
        
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        NDHomeGoodsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NDHomeGoodsCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.arrCellModel = self.arrHomeNewModel;
        WeakSelf();
        [cell setSelectItemBlock:^(NSInteger index) {
            StrongSelf();
            if (![HLLShareManager shareMannager].userModel) {
                NDLoginViewController * loginVC = [[NDLoginViewController alloc] init];
                [strongself.navigationController pushViewController:loginVC animated:YES];
                return;
            }
            NDGoodsInfoModel * model = self.arrHomeNewModel[index];
            NDBaseWebViewController * webVC = [[NDBaseWebViewController alloc] init];
            webVC.urlString = [NSString stringWithFormat:@"%@?id=%@&customerId=%@",URL_h5ToTwisted,model.Id,[HLLShareManager shareMannager].userModel.Id];
            webVC.title = @"扭蛋";
            [strongself.navigationController pushViewController:webVC animated:YES];
        }];
        return cell;
    }else if (indexPath.section == 1) {
        NDHomeGoodsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NDHomeGoodsCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.arrCellModel = self.arrHomePeopleModel;
        WeakSelf();
        [cell setSelectItemBlock:^(NSInteger index) {
            StrongSelf();
            if (![HLLShareManager shareMannager].userModel) {
                NDLoginViewController * loginVC = [[NDLoginViewController alloc] init];
                [strongself.navigationController pushViewController:loginVC animated:YES];
                return;
            }
            NDGoodsInfoModel * model = self.arrHomePeopleModel[index];
            NDBaseWebViewController * webVC = [[NDBaseWebViewController alloc] init];
            webVC.urlString = [NSString stringWithFormat:@"%@?id=%@&customerId=%@",URL_h5ToTwisted,model.Id,[HLLShareManager shareMannager].userModel.Id];
            webVC.title = @"扭蛋";
            [strongself.navigationController pushViewController:webVC animated:YES];
        }];
        return cell;
    }else if (indexPath.section == 2){
        
        NDGoodsInfoModel * model = self.arrHomeLikeModel[indexPath.row];
        NDHomeLikeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NDHomeLikeCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = model;
        return cell;
    }
    return nil;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.section == 2){
        if (![HLLShareManager shareMannager].userModel) {
            NDLoginViewController * loginVC = [[NDLoginViewController alloc] init];
            [self.navigationController pushViewController:loginVC animated:YES];
            return;
        }
        
        NDGoodsInfoModel * model = self.arrHomeLikeModel[indexPath.row];
        NDBaseWebViewController * webVC = [[NDBaseWebViewController alloc] init];
        webVC.urlString = [NSString stringWithFormat:@"%@?id=%@&customerId=%@",URL_h5ToTwisted,model.Id,[HLLShareManager shareMannager].userModel.Id];
        webVC.title = @"扭蛋";
        [self.navigationController pushViewController:webVC animated:YES];
    }
}

-(NDHomeHeadView *)headView{
    if (_headView == nil) {
        _headView = [[NDHomeHeadView alloc] init];
        _headView.frame = CGRectMake(0, 0, kScreenWidth, cycleView_H+44);
    }
    return _headView;
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self postGetAllRequest];
    [self.headView startAnimation];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.headView stopAnimation];
}

#pragma mark - 网络请求

-(void)httpGetInfoRequest{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD show];
    });
    [self httpGetBannerData];
    [self httpGetNotiMsgData];
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_async(group, queue, ^{
        
        [self httpGetLikeGoodsFinish:^{
            dispatch_semaphore_signal(semaphore);
            
        }];
    });
 
    dispatch_group_async(group, queue, ^{
        
        [self httpGetNewGoodsFinish:^{
            dispatch_semaphore_signal(semaphore);
            
        }];
    });
    dispatch_group_async(group, queue, ^{
        
        [self httpGetPopularityGoodsFinish:^{
            dispatch_semaphore_signal(semaphore);
            
        }];
    });
   
    
    dispatch_group_notify(group, queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            [self.tableView reloadData];
        });
    });
    
    
}

-(void)httpGetBannerData{
    [HLLHttpManager postWithURL:URL_Banner params:nil success:^(NSDictionary *responseObject) {
        NSArray * arrRows = responseObject[@"rows"];
        self.arrBannerModel = nil;
        self.arrBannerModel = [NDHomeBannerModel mj_objectArrayWithKeyValuesArray:arrRows];
        NSMutableArray * arrImages = [NSMutableArray array];
        for (NDHomeBannerModel * model in self.arrBannerModel) {
            [arrImages addObject:[model.imageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        }
        [self.headView setClcleViewUrlImageArray:arrImages];
        
    } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
        
    }];
}

-(void)httpGetNotiMsgData{

    [HLLHttpManager postWithURL:URL_NewMgs params:nil success:^(NSDictionary *responseObject) {
        NSArray * arrRows = responseObject[@"rows"];
        self.arrNewMsgModel = nil;
        self.arrNewMsgModel = [NDHomeNewMessageModel mj_objectArrayWithKeyValuesArray:arrRows];
        [self.headView setcycVerticalArray:self.arrNewMsgModel];
    } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
        
    }];
}

-(void)httpGetLikeGoodsFinish:(void(^)(void))finishBlock{

    [HLLHttpManager postWithURL:URL_likeGoods params:nil success:^(NSDictionary *responseObject) {
        finishBlock?finishBlock():nil;
    } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
        finishBlock?finishBlock():nil;
    }];
}

-(void)httpGetNewGoodsFinish:(void(^)(void))finishBlock{
    
    [HLLHttpManager postWithURL:URL_newGoods params:nil success:^(NSDictionary *responseObject) {
        finishBlock?finishBlock():nil;
    } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
        finishBlock?finishBlock():nil;
    }];
}
-(void)httpGetPopularityGoodsFinish:(void(^)(void))finishBlock{
    
    [HLLHttpManager postWithURL:URL_HumanGoods params:nil success:^(NSDictionary *responseObject) {
        finishBlock?finishBlock():nil;
    } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
        finishBlock?finishBlock():nil;
    }];
}
    
-(void)postGetAllRequest{
    [HLLHttpManager postWithURL:URL_homeAllData  params:nil success:^(NSDictionary *responseObject) {
        [SVProgressHUD dismiss];
        NSArray * arrRows = responseObject[@"rows"];
        if (arrRows.count > 0) {
            NSDictionary * dictData = arrRows.firstObject;
            self.arrBannerModel = [NDHomeBannerModel mj_objectArrayWithKeyValuesArray:dictData[@"sowingImg"]];
            self.arrNewMsgModel = [NDHomeNewMessageModel mj_objectArrayWithKeyValuesArray:dictData[@"sowingMessage"]];
            self.arrHomePeopleModel = [NDGoodsInfoModel mj_objectArrayWithKeyValuesArray:dictData[@"homePeople"]];
            self.arrHomeLikeModel = [NDGoodsInfoModel mj_objectArrayWithKeyValuesArray:dictData[@"homeLike"]];
            self.arrHomeNewModel = [NDGoodsInfoModel mj_objectArrayWithKeyValuesArray:dictData[@"homeNew"]];
            
            
            NSMutableArray * arrImages = [NSMutableArray array];
            for (NDHomeBannerModel * model in self.arrBannerModel) {
                [arrImages addObject:[model.imageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            }
            [self.headView setClcleViewUrlImageArray:arrImages];
            [self.headView setcycVerticalArray:self.arrNewMsgModel];
            [self.tableView reloadData];
        }
        
    } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showToast:@"加载错误"];
    }];

}

@end
