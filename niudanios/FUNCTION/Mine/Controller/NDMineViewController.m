//
//  NDMineViewController.m
//  niudanios
//
//  Created by lsc on 2018/8/23.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDMineViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "UINavigationBar+Awesome.h"
#import "NDMineTableViewCell.h"
#import "NDMineFunctionCell.h"
#import "NDSettingViewController.h"
#import "NDLoginViewController.h"
#import "NDMineOrderViewController.h"
#import "NDMyWalletViewController.h"
#import "NDMineDownViewController.h"
#import "NDTaskBonusViewController.h"
#import "NDMineEnshrineViewController.h"
#import "NDNuidanRecordViewController.h"
#import "NDAboutViewController.h"
#import "NDMineAddressViewController.h"
#import "ShareSdkHeader.h"

#define Head_H (kScreenWidth*(360.0/750))
#define KheadViewH(x) ((x)*(kScreenWidth/375.0))
@interface NDMineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UIImageView * imageHead;
@property (nonatomic ,strong) UILabel * labelName;

@property (nonatomic ,strong) UIView * headView;

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation NDMineViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.fd_prefersNavigationBarHidden = YES;//隐藏导航栏
    self.title = @"个人中心";
    [self setUI];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if ([HLLShareManager shareMannager].userModel) {
        [self.imageHead sd_setImageWithURL:[NSURL URLWithString:HTTP([HLLShareManager shareMannager].userModel.headPortrait?:@"")] placeholderImage:[UIImage imageNamed:@"head_placehold"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            NSLog(@"error:%@",error);
        }];
      
        self.labelName.text = [HLLShareManager shareMannager].userModel.nickName;
    }else{
        self.imageHead.image = [UIImage imageNamed:@"head_placehold"];
        self.labelName.text = @"未登录";
    }
}

-(void)setUI{
    
    [self.view addSubview:self.headView];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(Head_H+(isIPhoneX?24:0));
    }];
    
    UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_a"]];
    [self.headView addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.headView);
    }];
    
    
    UIView * viewNav = [[UIView alloc] init];
    viewNav.backgroundColor = HEXCOLOR(0x000000);
    viewNav.alpha = 0.1;
    [self.headView addSubview:viewNav];
    CGFloat top = isIPhoneX?44:20;
    [viewNav mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.headView);
        make.top.mas_equalTo(top);
        make.height.mas_equalTo(44);
    }];
    
    
    UILabel * labelTitle = [[UILabel alloc] init];
    labelTitle.text = @"个人中心";
    labelTitle.textColor = [UIColor whiteColor];
    labelTitle.textAlignment = NSTextAlignmentCenter;
    labelTitle.font = [UIFont systemFontOfSize:18.0];
    [self.headView addSubview:labelTitle];
    [labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(viewNav);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(viewNav);
    }];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"ic_share"] forState:UIControlStateNormal];
    [rightBtn.imageView setContentMode:UIViewContentModeCenter];
    [rightBtn addTarget:self action:@selector(navRightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:rightBtn];
    
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(viewNav);
        make.height.width.mas_equalTo(23);
        make.right.mas_equalTo(self.headView).offset(-15);
    }];
    
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"ic_set"] forState:UIControlStateNormal];
    [leftBtn.imageView setContentMode:UIViewContentModeCenter];
    [leftBtn addTarget:self action:@selector(navLeftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(viewNav);
        make.height.width.mas_equalTo(25);
        make.left.mas_equalTo(self.headView).offset(15);
    }];
    
    
    
    self.imageHead = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"head_placehold"]];
    self.imageHead.layer.cornerRadius = KheadViewH(60)/2.0;
    self.imageHead.layer.masksToBounds = YES;
    [self.headView addSubview:self.imageHead];
    [self.imageHead mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(KheadViewH(60));
        make.centerX.mas_equalTo(self.headView);
        make.top.mas_equalTo(viewNav.mas_bottom).offset(KheadViewH(8));
    }];
    
    
    self.labelName = [[UILabel alloc] init];
    self.labelName.text = @"未登录";
    self.labelName.textColor = [UIColor whiteColor];
    self.labelName.textAlignment = NSTextAlignmentCenter;
    self.labelName.font = [UIFont systemFontOfSize:16.0];
    [self.headView addSubview:self.labelName];
    [self.labelName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.headView);
        make.top.mas_equalTo(self.imageHead.mas_bottom).offset(KheadViewH(13));
    }];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.sectionFooterHeight = 10.0f;
    
    self.tableView.bounces = YES;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NDMineTableViewCell" bundle:nil] forCellReuseIdentifier:@"NDMineTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"NDMineFunctionCell" bundle:nil] forCellReuseIdentifier:@"NDMineFunctionCell"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.headView.mas_bottom);
    }];
}


#pragma mark - tableview

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
 
    return 3;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 1) {
        return (kScreenWidth*177.0/375);
    }
    
    return 44.0f;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
    if(section == 0){
        return 4;
    }else if(section == 1){
        return 1;
    }else if(section == 2){
        return 2;
    }else{
        return 0;
    }
  
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        NDMineTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NDMineTableViewCell"	 forIndexPath:indexPath];
        cell.viewLine.hidden = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            cell.imageViewHead.image = [UIImage imageNamed:@"ic_ads"];
            cell.labelName.text = @"全部订单";
        }else if (indexPath.row == 1){
            cell.imageViewHead.image = [UIImage imageNamed:@"ic_pd"];
            cell.labelName.text = @"待发货";
        }else if (indexPath.row == 2){
            cell.imageViewHead.image = [UIImage imageNamed:@"ic_logistics"];
            cell.labelName.text = @"待收货";
        }else if (indexPath.row == 3){
            cell.imageViewHead.image = [UIImage imageNamed:@"ic_rg"];
            cell.labelName.text = @"已收货";
            cell.viewLine.hidden = YES;
        }
        
        
        return cell;
    }else if (indexPath.section == 2){
        NDMineTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NDMineTableViewCell" forIndexPath:indexPath];
        cell.viewLine.hidden = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            cell.imageViewHead.image = [UIImage imageNamed:@"ic_callservice"];
            cell.labelName.text = @"联系客服";
        }else if (indexPath.row == 1){
            cell.imageViewHead.image = [UIImage imageNamed:@"ic_au"];
            cell.labelName.text = @"关于我们";
            cell.viewLine.hidden = YES;
        }
        
        
        return cell;
    }else{
        NDMineFunctionCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NDMineFunctionCell" forIndexPath:indexPath];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        WeakSelf();
        [cell setFunctionSelectedBlock:^(NSInteger tag) {
            StrongSelf();
            NSLog(@"tag:%d",tag);
            if (![HLLShareManager shareMannager].userModel) {
                NDLoginViewController * loginVC = [[NDLoginViewController alloc] init];
                [strongself.navigationController pushViewController:loginVC animated:YES];
                return;
            }
            
            if (tag == 1) {
                NDMyWalletViewController * vc = [[NDMyWalletViewController alloc] init];
                [strongself.navigationController pushViewController:vc animated:YES];
            }else if(tag == 2){
                NDMineEnshrineViewController * vc = [[NDMineEnshrineViewController alloc] init];
                [strongself.navigationController pushViewController:vc animated:YES];
            }else if(tag == 3){
                NDNuidanRecordViewController * vc = [[NDNuidanRecordViewController alloc] init];
                [strongself.navigationController pushViewController:vc animated:YES];
            }else if(tag == 4){
                NDTaskBonusViewController * vc = [[NDTaskBonusViewController alloc] init];
                [strongself.navigationController pushViewController:vc animated:YES];
            }else if(tag == 5){
                NDMineAddressViewController * vc = [[NDMineAddressViewController alloc] init];
                [strongself.navigationController pushViewController:vc animated:YES];
            }else if(tag == 6){
                NDMineDownViewController * vc = [[NDMineDownViewController alloc] init];
                [strongself.navigationController pushViewController:vc animated:YES];
            }
        }];
        return cell;
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        if (![HLLShareManager shareMannager].userModel) {
            NDLoginViewController * loginVC = [[NDLoginViewController alloc] init];
            [self.navigationController pushViewController:loginVC animated:YES];
            return;
        }
        NDMineOrderViewController * orderVC = [[NDMineOrderViewController alloc] init];
        orderVC.selectTag = indexPath.row;
        [self.navigationController pushViewController:orderVC animated:YES];
    }else if (indexPath.section == 2){
        if (indexPath.row == 1) {
            NDAboutViewController * vc = [[NDAboutViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 0){
            [self contactCustomerService];
        }
    }
    
}

-(void)contactCustomerService{
    [SVProgressHUD show];
    [HLLHttpManager postWithURL:URL_customPhone params:nil success:^(NSDictionary *responseObject) {
        [SVProgressHUD dismiss];
        NSArray * arrRows = responseObject[@"rows"];
        if (arrRows.count>0) {
            NSDictionary * dictT = arrRows.firstObject;
            NSString * phone = dictT[@"phone"];
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phone];
            UIWebView * callWebview = [[UIWebView alloc] init];
            [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
            [self.view addSubview:callWebview];
        }
    } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showToast:@"呼叫失败"];
    }];
}

#pragma mark - 导航栏左右按钮点击
-(void)navLeftBtnClick{
    
    if (![HLLShareManager shareMannager].userModel) {
        NDLoginViewController * loginVC = [[NDLoginViewController alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
        return;
    }
    
    
    NDSettingViewController * settingVC = [[NDSettingViewController alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
    
}
-(void)navRightBtnClick{
    
    [SVProgressHUD showToast:@"分享"];
    
    
    return;

    //1、创建分享参数
    NSArray* imageArray = @[[UIImage imageNamed:@"bg_a.png"]];
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                         images:imageArray
                                            url:[NSURL URLWithString:@"http://mob.com"]
                                          title:@"分享标题"
                                           type:SSDKContentTypeAuto];
    
            //2、分享（可以弹出我们的分享菜单和编辑界面）
            [ShareSDK showShareActionSheet:nil
                                     items:@[
                                             @(SSDKPlatformTypeSinaWeibo),
                                             @(SSDKPlatformSubTypeWechatSession),
                                             @(SSDKPlatformSubTypeWechatTimeline),
                                             @(SSDKPlatformSubTypeQQFriend)
                                             ]
                               shareParams:shareParams
                       onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                           
                           switch (state) {
                               case SSDKResponseStateSuccess:
                               {
                                   UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                       message:nil
                                                                                      delegate:nil
                                                                             cancelButtonTitle:@"确定"
                                                                             otherButtonTitles:nil];
                                   [alertView show];
                                   
                               }
                                   break;
                               case SSDKResponseStateFail:
                               {
                                   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                                   message:[NSString stringWithFormat:@"%@",error]
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"OK"
                                                                         otherButtonTitles:nil, nil];
                                   [alert show];
                                   
                               }
                                   break;
                               default:
                                   break;
                           }
                }];

    }
}



-(UIView *)headView{
    if(_headView == nil){
        _headView = [[UIView alloc] init];
        _headView.backgroundColor = [UIColor clearColor];
    }
    return _headView;
}

@end
