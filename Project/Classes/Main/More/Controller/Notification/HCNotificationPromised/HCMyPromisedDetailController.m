//
//  HCPromisedNotiController.m
//  Project
//
//  Created by 朱宗汉 on 16/1/30.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <StoreKit/StoreKit.h>

#import "HCMyPromisedDetailController.h"
#import "HCNotificationHeadImageController.h"
#import "HCPromisedCommentController.h"
#import "HCMedicalViewController.h"

#import "HCNotificationCenterInfo.h"

#import "HCClosePromisedApi.h"

#import "HCButtonItem.h"
@interface HCMyPromisedDetailController ()<SKStoreProductViewControllerDelegate>

@property (nonatomic,strong) UIImageView    *sexIV;
@property (nonatomic,strong) UIImageView   *imageView;

@property (nonatomic,strong) UILabel    *nameLabel;
@property (nonatomic,strong) UILabel    *ageLabel;
@property (nonatomic,strong) UILabel    *missTimeLabel;
@property (nonatomic,strong) UILabel    *missMessageLabel;
@property (nonatomic,strong) UILabel    *numLabel;


@property (nonatomic,strong) UIButton   * FatherTel;
@property (nonatomic,strong) UIButton   * MotherTel;
@property (nonatomic,strong) UIButton   *foundBtn;
@property (nonatomic,strong) UIButton   *headBtn;
@property (nonatomic,strong) UIButton   *MedicalBtn;


@property (nonatomic,strong) UIView     *blackView;
@property (nonatomic,strong) UIView     *myAlertView;
@property (nonatomic,strong) UIView     *imgeViewBottom;
@property (nonatomic,strong) UIView     *grayView;
@property (nonatomic,strong) UIScrollView     *scrollView;

@property (nonatomic,strong) HCNotificationCenterInfo   *info;

@end

@implementation HCMyPromisedDetailController

- (void)viewDidLoad {
    // --------与我相关一呼百应详情-----------------
    [super viewDidLoad];
    self.info = self.data[@"info"];
    [self setupBackItem];
    self.view.backgroundColor = [UIColor colorWithWhite:0.94f alpha:1.0f];
    self.title = @"一呼百应详情";
    
    [self.scrollView addSubview:self.headBtn];
    [self.scrollView addSubview:self.sexIV];
    [self.scrollView addSubview:self.nameLabel];
    [self.scrollView addSubview:self.ageLabel];
    [self.scrollView addSubview:self.imageView];
    
    [self.scrollView addSubview:self.missTimeLabel];
    [self.scrollView addSubview:self.missMessageLabel];
    
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.foundBtn];
    
    
    NSURL *url = [readUserInfo originUrl:self.info.lossImageName :kkLoss];
    
    [self.imageView sd_setImageWithURL:url placeholderImage:IMG(@"label_Head-Portraits")];
    
    NSURL *url1 = [readUserInfo originUrl:self.info.imageName :kkObject];
    UIImage *image = [[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:url1]];
    [self.headBtn setBackgroundImage:image forState:UIControlStateNormal];
    
}

#pragma mark ---SKStoreProductViewControllerDelegate

// 点击了appstore的取消按钮
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark --- private mothods
// 点击头像
-(void)headClick:(UIButton  *)button
{
    UIImage *image = [button backgroundImageForState:UIControlStateNormal];
    HCNotificationHeadImageController *imageVC = [[HCNotificationHeadImageController alloc]init];
    imageVC.data = @{@"image" : image};
    [self.navigationController pushViewController:imageVC animated:YES];
    
}

// 点击了已经找到的按钮
-(void)foundBtnClick:(UIButton *)button
{
    [self.view addSubview:self.blackView];
    [self.view addSubview:self.myAlertView];
}

// 点击联系人1
-(void)FatherTelClick
{
    NSString *tel = [NSString stringWithFormat:@"tel://%@",self.info.contactorPhoneNo1];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tel]];
    [self showHUDText:@"拨打联系人1"];
    
    
}

// 点击联系人2
-(void)MotherTelClick
{
    NSString *tel = [NSString stringWithFormat:@"tel://%@",self.info.contactorPhoneNo2];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tel]];
    [self showHUDText:@"拨打联系人2"];
}


// 点击了小按钮
-(void)buttonClick:(UIButton  *)button
{
    
    if ([button.titleLabel.text isEqualToString:@"好评"])
    {
        [self.blackView removeFromSuperview];
        [self.myAlertView removeFromSuperview];
        
        [self showHUDText:@"正在跳转AppStore"];
        
        // -----------------------------跳转到appStore---------------------------------------------
        //初始化控制器
        SKStoreProductViewController *storeProductViewContorller = [[SKStoreProductViewController alloc] init];
        //设置代理请求为当前控制器本身
        storeProductViewContorller.delegate = self;
        //加载一个新的视图展示
        [storeProductViewContorller loadProductWithParameters:
         //appId唯一的
         @{SKStoreProductParameterITunesItemIdentifier : @"587767923"} completionBlock:^(BOOL result, NSError *error) {
             //block回调
             if(error){
                 [self showHUDError:@"跳转失败"];
                 NSLog(@"错误 %@ with userInfo %@",error,[error userInfo]);
             }else{
                 [self hideHUDView];
                 //模态弹出appstore
                 [self presentViewController:storeProductViewContorller animated:YES completion:^{
                     
                 }
                  ];
             }
         }];
        //------------------------------------------------------------------------------------------
        
    }else  if ([button.titleLabel.text isEqualToString:@"关闭"])
    {
        
        //关闭一呼百应
        [self showHUDView:nil];
        HCClosePromisedApi *api = [[HCClosePromisedApi alloc]init];
        api.callId = self.info.callId;
        
        [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone) {
           
            if (requestStatus == HCRequestStatusSuccess) {
                
                [self hideHUDView];
                
                NSLog(@"-----------------------关闭一呼百应--------------------------");
                [[NSNotificationCenter defaultCenter] postNotificationName:@"aboutMeData" object:nil];
                [self.navigationController popToRootViewControllerAnimated:YES];
                [self.blackView removeFromSuperview];
                [self.myAlertView removeFromSuperview];
                
            }
            
        }];
        
        
        
    }
    else
    {
        [self.blackView removeFromSuperview];
        [self.myAlertView removeFromSuperview];
    }
}

// 点击进入  医疗急救卡
-(void)toMedicalVC
{
    HCMedicalViewController   *medicalVC = [[HCMedicalViewController alloc]init];
     medicalVC.objectId = self.info.objectId;
    [self.navigationController pushViewController:medicalVC animated:YES];
}

// 点击进入图片大图
-(void)addBigImage:(UITapGestureRecognizer *)tap
{
    self.navigationController.navigationBarHidden = YES;
    CGRect  startFrame =  [self.imageView convertRect:self.imageView.bounds toView:self.view];
    UIImageView  *bigImageView = [[UIImageView alloc]initWithFrame:startFrame];
    UIImageView  *smallImageView = (UIImageView *)tap.view;
    bigImageView.image = smallImageView.image;
    bigImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeBigImage:)];
    bigImageView.userInteractionEnabled = YES;
    bigImageView.backgroundColor = [UIColor blackColor];
    [bigImageView addGestureRecognizer:tap2];
    
    [self.view addSubview:bigImageView];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        bigImageView.frame = self.view.frame;
        
    }];
    
}

// 点击移除图片大图
-(void)removeBigImage:(UITapGestureRecognizer *)tap
{
    self.navigationController.navigationBarHidden = NO;
    tap.view.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.3 animations:^{
        CGRect  startFrame =  [self.imageView convertRect:self.imageView.bounds toView:self.view];
        tap.view.frame = startFrame;
    }completion:^(BOOL finished) {
        [tap.view removeFromSuperview];
    }];
    
    
}

#pragma mark --- setter Or getter


- (UIView *)imgeViewBottom
{
    if(!_imgeViewBottom){
        _imgeViewBottom = [[UIView alloc]initWithFrame:CGRectMake(0,30,self.imageView.frame.size.width , self.imageView.frame.size.height/6)];
        _imgeViewBottom.backgroundColor = [UIColor whiteColor];
        [_imgeViewBottom addSubview:self.numLabel];
        [_imgeViewBottom addSubview:self.FatherTel];
        [_imgeViewBottom addSubview:self.MotherTel];
        
        NSArray *btnArr = @[self.FatherTel,self.MotherTel];
        NSArray *arr = @[self.info.relation1,self.info.relation2];
        for (int i = 0; i<2; i++)
        {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX([btnArr[i] frame])+5,
                                                                      self.imageView.frame.size.height/7-15/670.0*SCREEN_HEIGHT,
                                                                      SCREEN_WIDTH*60/250 ,
                                                                      15/670.0*SCREEN_HEIGHT)];
            label.text = arr[i];
            label.textColor = [UIColor grayColor];
            label.font = [UIFont systemFontOfSize:12];
            [_imgeViewBottom addSubview:label];
            
        }
        
    }
    return _imgeViewBottom;
}


- (UIButton *)FatherTel
{
    if(!_FatherTel)
    {
        _FatherTel = [UIButton buttonWithType:UIButtonTypeCustom];
        _FatherTel.frame =CGRectMake(self.MedicalBtn.frame.size.width+10 ,
                                     CGRectGetMaxY(self.numLabel.frame) +7,
                                     self.imageView.frame.size.height/7 * 25/50,
                                     self.imageView.frame.size.height/7 * 25/50) ;
           [_FatherTel addTarget:self action:@selector(FatherTelClick) forControlEvents:UIControlEventTouchUpInside];
        [_FatherTel setBackgroundImage:IMG(@"PHONE-1") forState:UIControlStateNormal];
    }
    return _FatherTel;
}

- (UIButton *)MotherTel
{
    if(!_MotherTel){
        _MotherTel = [UIButton buttonWithType:UIButtonTypeCustom];
        _MotherTel.frame =CGRectMake(CGRectGetMaxY(self.MedicalBtn.frame) + SCREEN_WIDTH*80/250 + 5,
                                     CGRectGetMaxY(self.numLabel.frame) +7,
                                     self.imageView.frame.size.height/7 * 25/50,
                                     self.imageView.frame.size.height/7 * 25/50) ;
         [_MotherTel addTarget:self action:@selector(MotherTelClick) forControlEvents:UIControlEventTouchUpInside];
        [_MotherTel setBackgroundImage:IMG(@"PHONE-1") forState:UIControlStateNormal];
    }
    return _MotherTel;
}

- (UILabel *)numLabel
{
    if(!_numLabel){
        _numLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.MedicalBtn.frame.size.width + 10,5,200/320.0*SCREEN_WIDTH,12/480.0*SCREEN_HEIGHT)];
        _numLabel.text = [NSString stringWithFormat:@"编号:%@",self.info.callId];
        _numLabel.adjustsFontSizeToFitWidth = YES;
        _numLabel.textColor = [UIColor blackColor];
        
    }
    return _numLabel;
}

- (UIButton *)MedicalBtn
{
    if(!_MedicalBtn){
        _MedicalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _MedicalBtn.frame = CGRectMake(5, 5, self.imageView.frame.size.width/5, self.imageView.frame.size.width/5);
        _MedicalBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        ViewRadius(_MedicalBtn,self.imageView.frame.size.width/10 );
        [_MedicalBtn addTarget:self action:@selector(toMedicalVC) forControlEvents:UIControlEventTouchUpInside];
        [_MedicalBtn setBackgroundImage:IMG(@"健康－爱心") forState:UIControlStateNormal];
        
    }
    return _MedicalBtn;
}


- (UIButton *)headBtn
{
    if(!_headBtn){
        _headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _headBtn.frame = CGRectMake(10,10, 80/680.0*SCREEN_HEIGHT, 80/680.0*SCREEN_HEIGHT);
        ViewRadius(_headBtn, _headBtn.frame.size.width*0.5);
        [_headBtn addTarget:self action:@selector(headClick:) forControlEvents:UIControlEventTouchUpInside];
        _headBtn.layer.borderColor = [UIColor redColor].CGColor;
        _headBtn.layer.borderWidth = 3;
        [_headBtn setBackgroundImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
        [self.view addSubview:_headBtn];
    }
    return _headBtn;
}

- (UIImageView *)sexIV
{
    if(!_sexIV){
        CGFloat sexIVX = self.headBtn.frame.origin.x+self.headBtn.frame.size.width + 10;
        _sexIV = [[UIImageView alloc]initWithFrame:CGRectMake(sexIVX, 30/600.0 *SCREEN_HEIGHT, 15, 15)];
        if ([self.info.sex isEqualToString:@"男"])
        {
            _sexIV.image = IMG(@"男");
        }
        else
        {
            _sexIV.image = IMG(@"女");
        }
    }
    return _sexIV;
}


- (UILabel *)nameLabel
{
    if(!_nameLabel){
        CGFloat nameLabelX = self.sexIV.frame.origin.x + self.sexIV.frame.size.width+10;
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(nameLabelX,30/600.0*SCREEN_HEIGHT,75,20)];
        _nameLabel.adjustsFontSizeToFitWidth = YES;
        _nameLabel.text = self.info.trueName;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.textColor = [UIColor blackColor];
    }
    return _nameLabel;
}

- (UILabel *)ageLabel
{
    if(!_ageLabel){
        CGFloat  ageLabelX = self.nameLabel.frame.origin.x + self.nameLabel.frame.size.width;
        _ageLabel = [[UILabel alloc]initWithFrame:CGRectMake(ageLabelX,30/600.0*SCREEN_HEIGHT,30,20)];
        _ageLabel.font = [UIFont systemFontOfSize:14];
        _ageLabel.text = [NSString stringWithFormat:@"%@岁",self.info.age];
        _ageLabel.textColor = [UIColor lightGrayColor];
    }
    return _ageLabel;
}

- (UIImageView *)imageView
{
    if(!_imageView){
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(60/375.0*SCREEN_WIDTH, CGRectGetMaxY(self.missMessageLabel.frame) + 20, 250/375.0*SCREEN_WIDTH, 350/250.0*250/375.0*SCREEN_WIDTH)];
        ViewRadius(_imageView, 10);
        
        _imageView.userInteractionEnabled = YES;
        
        UIView *clearView = [[UIView alloc]initWithFrame:CGRectMake(0, 350/250.0*250/375.0*SCREEN_WIDTH-self.imgeViewBottom.frame.size.height-30, _imageView.frame.size.width, self.imgeViewBottom.frame.size.height+30)];
        clearView.backgroundColor = [UIColor clearColor];
        
        
        
        [clearView addSubview:self.imgeViewBottom];
        UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addBigImage:)];
        [_imageView addGestureRecognizer:tap];
        
        [clearView addSubview:self.MedicalBtn];
        
        [_imageView addSubview:clearView];
        
    }
    return _imageView;
}

- (UIButton *)foundBtn
{
    if(!_foundBtn){
        _foundBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _foundBtn.frame = CGRectMake(0, SCREEN_HEIGHT-49, SCREEN_WIDTH, 49);
        [_foundBtn setTitle:@"已找到" forState:UIControlStateNormal];
        _foundBtn.backgroundColor = [UIColor orangeColor];
        [_foundBtn addTarget:self action:@selector(foundBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return _foundBtn;
}


- (UILabel *)missMessageLabel
{
    if(!_missMessageLabel)
    {
        NSString *str = [NSString stringWithFormat:@"走失描述：%@",self.info.lossDesciption];
        CGSize  size = [str boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-40, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17],NSForegroundColorAttributeName : [UIColor grayColor]} context:nil].size;
        _missMessageLabel = [[UILabel alloc]initWithFrame:CGRectMake(20,80/600.0*SCREEN_HEIGHT,size.width,size.height)];
        _missMessageLabel.font = [UIFont fontWithName:@"PingFangTC-Thin" size:17];
        //        _missMessageLabel.font = [UIFont boldSystemFontOfSize:5.0];
        _missMessageLabel.adjustsFontSizeToFitWidth = YES;
        _missMessageLabel.text = str;
        _missMessageLabel.numberOfLines = 0;
        
    }
    return _missMessageLabel;
}


- (UILabel *)missTimeLabel
{
    if(!_missTimeLabel){
        CGFloat missTimeLabelX = self.headBtn.frame.origin.x+self.headBtn.frame.size.width + 10;
        _missTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(missTimeLabelX, 60/600.0*SCREEN_HEIGHT, 200, 20)];
        _missTimeLabel.textColor = [UIColor blackColor];
        _missTimeLabel.font = [UIFont systemFontOfSize:14];
        _missTimeLabel.text = [NSString stringWithFormat:@"走失时间：%@",self.info.lossTime];
    }
    return _missTimeLabel;
}



- (UIView *)blackView
{
    if(!_blackView){
        _blackView = [[UIView alloc]initWithFrame:self.view.frame];
        _blackView.backgroundColor = [UIColor blackColor];
        _blackView.alpha = 0.3;
    }
    return _blackView;
}

- (UIView *)myAlertView
{
    if(!_myAlertView){
        _myAlertView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300,160 )];
        _myAlertView.backgroundColor = [UIColor whiteColor];
        _myAlertView.center =self.view.center;
        ViewRadius(_myAlertView, 5);
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 30 , 300  , 40 )];
        label.text = @"请确认是否关闭我的一呼百应!";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        [_myAlertView addSubview:label];
        NSArray *Arr = @[@"好评",@"关闭",@"取消"];
        for (int i = 0;i<3 ; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(30 + i *80, 100, 60, 40);
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setTitle:Arr[i] forState:UIControlStateNormal];
            button.layer.borderColor = [UIColor blackColor].CGColor;
            button.layer.borderWidth = 1;
            button.layer.masksToBounds = YES;
            button.layer.cornerRadius = 7;
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [_myAlertView addSubview:button];
            
        }
    }
    return _myAlertView;
}


- (UIScrollView *)scrollView
{
    if(!_scrollView){
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT, SCREEN_HEIGHT-49)];
        _scrollView.backgroundColor = kHCBackgroundColor;
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(self.imageView.frame) + 20);
    }
    return _scrollView;
}

//self.imageView.frame.size.width -(CGRectGetMaxX(self.MedicalBtn.frame)+ 15)
//self.MedicalBtn.frame)+ 10100
- (UIView *)grayView
{
    if(!_grayView){
        _grayView = [[UIView alloc]initWithFrame:CGRectMake(100, CGRectGetMaxX(self.numLabel.frame) + 5, 100, 20)];
        _grayView.backgroundColor = [UIColor blackColor];
        
    }
    return _grayView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
