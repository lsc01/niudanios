//
//  NDMIneDataViewController.m
//  niudanios
//
//  Created by lsc on 2018/9/2.
//  Copyright © 2018年 lsc. All rights reserved.
//

#import "NDMIneDataViewController.h"
#import "NDMineDataCell.h"
#import "NDMineDataHeaderView.h"
#import "NDUpdatePhoneViewController.h"
#import "BRDatePickerView.h"
#import "NDSexSelectView.h"
//#import "SAMKeychain.h"
#import "HLLSysAuthorityManager.h"
#import "HLLPhoneModel.h"

//照片相关库
#import "MLSelectPhotoPickerViewController.h"
#import "MLSelectPhotoAssets.h"
#import "MLSelectPhotoPickerAssetsViewController.h"
#import "MLSelectPhotoBrowserViewController.h"

#import "UIImage+Resize.h"
#import "HLLFormData.h"
#import "AFHTTPSessionManager.h"
typedef void(^SelectedPhotos)(NSArray *photoArray);

@interface NDMIneDataViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic ,strong) NDMineDataHeaderView * headView;

@property (nonatomic ,strong) UIView * viewFooter;

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,copy) SelectedPhotos selectedPhotosBlock;

@end

@implementation NDMIneDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"账号资料";
    [self setUI];
}


-(void)setUI{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.sectionHeaderHeight = 10.0f;
    self.tableView.tableHeaderView = self.headView;
    self.tableView.tableFooterView = self.viewFooter;
    self.tableView.bounces = YES;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NDMineDataCell" bundle:nil] forCellReuseIdentifier:@"NDMineDataCell"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.headView.imageViewHead sd_setImageWithURL:[NSURL URLWithString:ImageUrl([HLLShareManager shareMannager].userModel.headPortrait?:@"")] placeholderImage:[UIImage imageNamed:@"head_placehold"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        NSLog(@"error:%@",error);
    }];
    
    WeakSelf();
    [self.headView setHeadViewUpdateBlock:^(UIImageView *imageView) {
        StrongSelf();
        [strongself cellImageHeaderReplaceWithImageView:imageView];
    }];
 
}

-(void)saveBtnClick{
    
    
    NDMineDataCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSString * stringName = cell.textFieldName.text;
    cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    NSString * stringSex = cell.btnSelect.titleLabel.text;
    cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    NSString * birth = cell.btnSelect.titleLabel.text;
    if ([birth isEqualToString:@"请选择"]) {
        [SVProgressHUD showToast:@"请选择出生日期"];
        return;
    }
    NSMutableDictionary * dictP = [NSMutableDictionary dictionary];
    [dictP setObject:birth forKey:@"Strdate"];
    [dictP setObject:[HLLShareManager shareMannager].userModel.loginMobile forKey:@"loginMobile"];
    [dictP setObject:[stringSex isEqualToString:@"男"]?@(1):@(0) forKey:@"sex"];
    [dictP setObject:stringName forKey:@"nickName"];
    
    HLLFormData * Data =[[HLLFormData alloc]init];
    NSData *imageData =  UIImagePNGRepresentation(self.headView.imageViewHead.image);
    Data.data = imageData;
    Data.mimeType = @"image/png";
    Data.name = @"portrait";
    Data.filename = @"portrait.png";
    
    [SVProgressHUD show];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    [manager POST:URL_updateCustomerInfo parameters:dictP constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData *pictureData = UIImageJPEGRepresentation(self.headView.imageViewHead.image, 0.5);
        NSString *fileName = @"portrait";
        NSString *nameStr = @"portrait";
        NSLog(@"%@", nameStr);
        NSLog(@"%@", fileName);
        [formData appendPartWithFileData:pictureData name:nameStr fileName:[NSString stringWithFormat:@"%@.png", fileName] mimeType:@"image/png"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray * arrRows = responseObject[@"rows"];
        if (arrRows.count > 0) {
            NSDictionary * dict = arrRows.firstObject;
            if ([dict[@"code"] integerValue] == 0) {
                
                [self findCustomerInfoFunction];
            }else{
                [SVProgressHUD dismiss];
                [SVProgressHUD showToast:dict[@"msg"]];
            }
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showToast:@"修改失败"];
        
    }];

}

-(void)findCustomerInfoFunction{
    NSMutableDictionary * dictP = [NSMutableDictionary dictionary];
    [dictP setObject:[HLLShareManager shareMannager].userModel.Id forKey:@"id"];
    [HLLHttpManager postWithURL:URL_findCustomerInfo params:dictP success:^(NSDictionary *responseObject) {
         [SVProgressHUD dismiss];
        NSArray * arrRows = responseObject[@"rows"];
        if (arrRows.count > 0) {
            NSDictionary * dict = arrRows.firstObject;
            NDUserInfoModel * model = [NDUserInfoModel mj_objectWithKeyValues:dict[@"tbCustomer"]];
            [HLLShareManager shareMannager].userModel = model;
            NSDictionary * dictT = [[HLLShareManager shareMannager].userModel mj_keyValues];
            NSData * data = [NSJSONSerialization dataWithJSONObject:dictT options:0 error:nil];
//            [SAMKeychain setPasswordData:data forService:sevodadacnuizcnas account:acdadaddacnuizcnas];
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:acdadaddacnuizcnas];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        [SVProgressHUD showToast:@"修改成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([self.delegate respondsToSelector:@selector(updateDataInfoSuccess)]) {
                [self.delegate updateDataInfoSuccess];
            }
            [self.navigationController popViewControllerAnimated:YES];
        });
    } failure:^(NSError *error, NSInteger errCode, NSString *errMsg) {
        [SVProgressHUD dismiss];
    }];
}


#pragma mark - tableview

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44.0f;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section == 0){
        return 3;
    }else{
        return 0;
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        NDMineDataCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NDMineDataCell"  forIndexPath:indexPath];
        cell.viewLine.hidden = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textFieldName.hidden = YES;
        cell.btnSelect.hidden = NO;
        
        if (indexPath.row == 0) {
            cell.btnSelect.enabled = NO;

            cell.textFieldName.text = [HLLShareManager shareMannager].userModel.nickName;
            cell.textFieldName.hidden = NO;
            cell.btnSelect.hidden = YES;
            cell.labelTitle.text = @"昵称";
        }else if (indexPath.row == 1){
            cell.btnSelect.enabled = YES;
            
            [cell.btnSelect setTitle:[[HLLShareManager shareMannager].userModel.sex isEqualToString:@"1"]?@"男":@"女" forState:UIControlStateNormal];
            cell.labelTitle.text = @"性别";
           
        }else if (indexPath.row == 2){
            cell.viewLine.hidden = YES;
            cell.btnSelect.enabled = YES;
            
            NSArray * arrayT = [[HLLShareManager shareMannager].userModel.birthdayTime componentsSeparatedByString:@" "];
            if (arrayT.count>0) {
                NSString * Birth = arrayT.firstObject;
                [cell.btnSelect setTitle:Birth forState:UIControlStateNormal];
            }
            cell.labelTitle.text = @"出生年月";
            
        }
        [cell setSelectBtnBlock:^(UIButton *btnSelect) {
            if (indexPath.row == 1) {
                [NDSexSelectView showSexResultBlock:^(NSString *selectValue) {
                    [btnSelect setTitle:selectValue forState:UIControlStateNormal];
                }];
                
            }else if (indexPath.row == 2){
                [BRDatePickerView showDatePickerWithTitle:@"" dateType:UIDatePickerModeDate defaultSelValue:@"" minDateStr:@"" maxDateStr:@"" isAutoSelect:NO resultBlock:^(NSString *selectValue,NSDate * selectDate) {
                    [btnSelect setTitle:selectValue forState:UIControlStateNormal];
                }];
            }
            
            
        }];
        
        
        
        return cell;
    }
    return nil;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(void)cellImageHeaderReplaceWithImageView:(UIImageView *)imageView{
    
    [self openPhotoMenuWithPhotos:^(NSArray *photoArray) {
        [SVProgressHUD showWithStatus:@"正在压缩图片.."];
        [self CompressImages:photoArray
                      toSize:CGSizeMake(750,316)
                     Quality:kCGInterpolationHigh
                 returnBlock:^(NSArray *CompressedImages, NSArray *datas) {
                     [SVProgressHUD dismiss];
                     UIImage *photo = CompressedImages.firstObject;
                     imageView.image = photo;
                 }];
    }];
}
//打开选择列表
-(void)openPhotoMenuWithPhotos:(SelectedPhotos)PhotosBlock{
    
    _selectedPhotosBlock = PhotosBlock;
    //在这里呼出下方菜单按钮项
    UIActionSheet *PicActionSheet = [[UIActionSheet alloc]
                                     initWithTitle:nil
                                     delegate:self
                                     cancelButtonTitle:@"取消"
                                     destructiveButtonTitle:nil
                                     otherButtonTitles:@"从相册选择",@"拍照", nil];
    [PicActionSheet showInView:self.view];
}
#pragma mark - UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex == actionSheet.cancelButtonIndex){
        NSLog(@"取消");
    }
    switch (buttonIndex) {
        case 0:
        {
            [self OpenPotoLibWithPhoto];
        }
            
            break;
        case 1:
            [self takePhoto];
            break;
            
        default:
            break;
    }
}

///使用相机
-(void)takePhoto
{
    WeakSelf();
    
    switch ([HLLSysAuthorityManager isAllowCamera]) {
        case SYS_NotDetermined:
        {
            [HLLSysAuthorityManager getCameraPermissions:^(BOOL isAllow) {
                StrongSelf();
                if (isAllow) {
                    
                    [strongself OpenCamera];
                }else{
                    
                    [HLLSysAuthorityManager alertWithTitle:@"相机被禁用" message:[NSString stringWithFormat:@"请在系统中的“设置”-“%@”中允许访问您的相机",[HLLPhoneModel getAPPName]]];
                    HLLLog(@"不允许相机");
                }
            }];
        }
            break;
        case SYS_Authorized:
        {
            [self OpenCamera];
            HLLLog(@"允许相机");
        }
            break;
        case SYS_Denied:
        {
            
            [HLLSysAuthorityManager alertWithTitle:@"相机被禁用" message:[NSString stringWithFormat:@"请在系统中的“设置”-“%@”中允许访问您的相机",[HLLPhoneModel getAPPName]]];
            HLLLog(@"不允许相机");
        }
            break;
            
        default:
            break;
    }
    
}

#pragma mark  - 照相机
///打开相机
-(void)OpenCamera{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = sourceType;
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        //            picker.showsCameraControls = YES;
        picker.allowsEditing = YES;
        
        [self presentViewController:picker animated:YES completion:nil];
    } else {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}


//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        
        //        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];  //图库
        //        //保存到本地
        //        [library writeImageToSavedPhotosAlbum:image.CGImage metadata:nil completionBlock:^(NSURL *assetURL, NSError *error) {
        //        }];
        
        
        NSArray *imageArray = [NSArray arrayWithObject:image];
        _selectedPhotosBlock?_selectedPhotosBlock(imageArray):nil;
        
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:nil];
        
    }
    
}


#pragma mark --------照片相关库代理方法
#pragma mark - 打开相册第三方库
-(void)OpenPotoLibWithPhoto
{
    WeakSelf();
    switch ([HLLSysAuthorityManager isAllowPhotoAlbum]) {
        case SYS_NotDetermined:
        {
            [HLLSysAuthorityManager getPhotoPermissions:^(BOOL isAllow) {
                StrongSelf();
                if (isAllow) {
                    
                    [strongself openPhotoAlbum];
                }else{
                    
                    [HLLSysAuthorityManager alertWithTitle:@"相册被禁用" message:[NSString stringWithFormat:@"请在系统中的“设置”-“%@”中允许访问您的相册",[HLLPhoneModel getAPPName]]];
                    HLLLog(@"不允许相册");
                }
            }];
        }
            break;
        case SYS_Authorized:
        {
            [self openPhotoAlbum];
            HLLLog(@"允许相册");
        }
            break;
        case SYS_Denied:
        {
            
            [HLLSysAuthorityManager alertWithTitle:@"相册被禁用" message:[NSString stringWithFormat:@"请在系统中的“设置”-“%@”中允许访问您的相册",[HLLPhoneModel getAPPName]]];
            HLLLog(@"不允许相册");
        }
            break;
            
        default:
            break;
    }
    
}


///打开相册
-(void)openPhotoAlbum{
    // 创建控制器
    MLSelectPhotoPickerViewController *pickerVc = [[MLSelectPhotoPickerViewController alloc] init];
    // 默认显示相册里面的内容SavePhotos
    pickerVc.status = PickerViewShowStatusCameraRoll;
    pickerVc.maxCount = 1;
    [pickerVc showPickerVc:self];
    
    pickerVc.callBack = ^(NSArray *assets){
        NSMutableArray *imageArray = [NSMutableArray array];
        
        for(int i= 0; i< assets.count;i++){
            MLSelectPhotoAssets *asset = assets[i];
            [imageArray addObject:[MLSelectPhotoPickerViewController getImageWithImageObj:asset]];
            
        }
        _selectedPhotosBlock?_selectedPhotosBlock(imageArray):nil;
    };
}



#pragma  mark - 压缩图片
-(void)CompressImages:(NSArray *)ImageArray
               toSize:(CGSize)size
              Quality:(CGInterpolationQuality)QualityKind
          returnBlock:(void(^)(NSArray *CompressedImages,NSArray *datas))ImageReturnBlock
{
    __block NSMutableArray *CompressedArray = [NSMutableArray new];
    __block NSMutableArray *CompressData = [NSMutableArray new];
    [ImageArray enumerateObjectsUsingBlock:^(UIImage*  _Nonnull img, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImage *NewImage = [img resizedImage:size interpolationQuality:QualityKind];//调整尺寸
        
        NSData* Imagedata = [NSData new];
        if (UIImagePNGRepresentation(NewImage) == nil)
        {
            Imagedata = UIImageJPEGRepresentation(NewImage, 0.2);
        }
        else
        {
            Imagedata = UIImagePNGRepresentation(NewImage);
        }
        [CompressData addObject:Imagedata];
        UIImage *compressedImage = [UIImage imageWithData:Imagedata];
        [CompressedArray addObject:compressedImage];
        
    }];
    if((CompressedArray.count != 0)&&(ImageReturnBlock)){//返回处理后的数据
        ImageReturnBlock(CompressedArray,CompressData);
    }
}



-(NDMineDataHeaderView *)headView{
    if(_headView == nil){
        _headView = [[NSBundle mainBundle] loadNibNamed:@"NDMineDataHeaderView" owner:self options:nil].firstObject;
        _headView.frame = CGRectMake(0, 0, kScreenWidth, 74);
        _headView.backgroundColor = [UIColor whiteColor];
        
    }
    return _headView;
}

-(UIView *)viewFooter{
    if (_viewFooter == nil) {
        _viewFooter = [[UIView alloc] init];
        _viewFooter.frame = CGRectMake(0, 0, kScreenWidth, 64);
        _viewFooter.backgroundColor = [UIColor clearColor];
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundColor:HEXCOLOR(0x1dcb7c)];
        [btn setTitle:@"保存" forState:UIControlStateNormal];
        [btn setTitleColor:HEXCOLOR(0xffffff) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(15, 20, kScreenWidth-30, 44);
        btn.layer.cornerRadius = 4;
        btn.layer.masksToBounds = YES;
        [_viewFooter addSubview:btn];
        
    }
    return _viewFooter;
}




@end
