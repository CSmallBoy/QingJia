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
#import "HCPromisedCommentController.h"
#import "HCClosePromisedApi.h"

#import "HCButtonItem.h"

#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "WXApi.h"
#import "UMSocialSinaHandler.h"
#import "UMSocialSnsPlatformManager.h"
#import "UMSocialSinaSSOHandler.h"
//根据callId查询一呼百应详情
#import "HCGetCallDetailInfoApi.h"
//大图
#import "HCBigImageViewController.h"

@interface HCMyPromisedDetailController ()<SKStoreProductViewControllerDelegate, UMSocialUIDelegate>

@property (nonatomic,strong) UIImageView    *sexIV;
@property (nonatomic,strong) UIImageView   *imageView;//图片

@property (nonatomic,strong) UILabel    *nameLabel;
@property (nonatomic,strong) UILabel    *ageLabel;
@property (nonatomic,strong) UILabel    *missTimeLabel;
@property (nonatomic,strong) UILabel    *missMessageLabel;
@property (nonatomic,strong) UILabel *missPlaceLabel;//丢失地方
@property (nonatomic,strong) UILabel    *numLabel;

@property (nonatomic,strong) UIButton   *foundBtn;
@property (nonatomic,strong) UIButton   *headBtn;
@property (nonatomic,strong) UIButton   *MedicalBtn;

@property (nonatomic,strong) UIView     *blackView;
@property (nonatomic,strong) UIView     *myAlertView;
@property (nonatomic,strong) UIView     *imgeViewBottom;//图片下面的控件
@property (nonatomic,strong) UIView     *grayView;
@property (nonatomic,strong) UIScrollView     *scrollView;

@property (nonatomic,strong)UIView *backView;//图片的父视图
@property (nonatomic,strong)UIImageView *leftAnimationView;//动画
@property (nonatomic,strong)UIImageView *rightAnimationview;

@property (nonatomic,strong) HCNotificationCenterInfo   *info;

@property (nonatomic,strong)UIView *bottonView;
@property (nonatomic,strong)UIButton *getClueBtn;//发现线索

@end

@implementation HCMyPromisedDetailController

- (void)viewDidLoad {
    // --------与我相关一呼百应详情-----------------
    [super viewDidLoad];
    self.info = self.data[@"info"];
    // 导航栏上的加号“+”
    [self addItem];
    [self setupBackItem];
    self.view.backgroundColor = [UIColor colorWithWhite:0.94f alpha:1.0f];
    self.title = @"一呼百应详情";
    
    [self.scrollView addSubview:self.headBtn];
    [self.scrollView addSubview:self.sexIV];
    [self.scrollView addSubview:self.nameLabel];
    [self.scrollView addSubview:self.ageLabel];
    [self.scrollView addSubview:self.backView];
    
    [self.scrollView addSubview:self.missTimeLabel];
    [self.scrollView addSubview:self.missPlaceLabel];
    [self.scrollView addSubview:self.missMessageLabel];

    self.view = self.scrollView;
    [self.navigationController.view addSubview:self.bottonView];
 
    [self requestDetailData];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.view addSubview:self.bottonView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.bottonView removeFromSuperview];
}


#pragma mark - layoutSubviews

- (void)addDataSuorce
{
    //头像
    NSURL *url1 = [readUserInfo originUrl:self.info.imageName :kkObject];
    UIImage *image = [[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:url1]];
    if (image) {
        [_headBtn setBackgroundImage:image forState:UIControlStateNormal];
    }
    //性别
    if ([self.info.sex isEqualToString:@"男"])
    {
        _sexIV.image = IMG(@"男");
    }
    else
    {
        _sexIV.image = IMG(@"女");
    }
    //姓名
    _nameLabel.text = self.info.trueName;
    //年龄
    _ageLabel.text = [NSString stringWithFormat:@"%@岁",self.info.age];
    //走失时间
    _missTimeLabel.text = [NSString stringWithFormat:@"走失时间：%@",self.info.lossTime];
    //走失地点
    _missPlaceLabel.text = [NSString stringWithFormat:@"走失地点：%@",self.info.lossAddress];
    //走势描述
    NSString *str = [NSString stringWithFormat:@"走失描述：%@",self.info.lossDesciption];
    CGFloat missMessageLabelY = self.missPlaceLabel.frame.origin.y+self.missPlaceLabel.frame.size.height+5/668.0*SCREEN_HEIGHT;
    CGSize  size = [str boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-40, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17],NSForegroundColorAttributeName : [UIColor grayColor]} context:nil].size;
    _missMessageLabel.frame = CGRectMake(20/375.0*SCREEN_WIDTH,missMessageLabelY,size.width,size.height);
    _missMessageLabel.text = str;
    //走失照片
    NSURL *url = [readUserInfo originUrl:self.info.lossImageName :kkLoss];
    [_imageView sd_setImageWithURL:url placeholderImage:IMG(@"label_Head-Portraits")];
    //
    for (UILabel *label in self.imgeViewBottom.subviews)
    {
        if (label.tag == 500)
        {
            label.text = self.info.relation1;
        }
        else if (label.tag == 501)
        {
            label.text = self.info.relation2;
        }
    }
    //医疗卡
    if ([self.info.openHealthCard isEqualToString:@"1"])//医疗卡打开
    {
        [_MedicalBtn setBackgroundImage:IMG(@"notification_health") forState:UIControlStateNormal];
    }
    else
    {
        _MedicalBtn.userInteractionEnabled = NO;
        [_MedicalBtn setBackgroundImage:IMG(@"promisedDetail_medical") forState:UIControlStateNormal];
    }
    //编号
    _numLabel.text = [NSString stringWithFormat:@"编号:%@",self.info.callId];
    
}

-(void)addItem
{
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:IMG(@"myPromisedDetail_share") style:UIBarButtonItemStylePlain target:self action:@selector(toShoreVC:)];
    self.navigationItem.rightBarButtonItem = right;
}


// 跳转到分享界面
-(void)toShoreVC:(UIButton *)button
{
    NSString *shareContent = @"M-talk";
    NSString *commonContent = self.info.lossDesciption;
    NSString *commonURL = [NSString stringWithFormat:@"http://58.210.13.58:8090/share/Share/call.do?code=%@", self.info.callId];
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"56971c14e0f55af6e5001da1"
                                      shareText:shareContent
                                     shareImage:IMG(@"landingpage_Background")
                                shareToSnsNames:@[UMShareToQQ,
                                                  UMShareToQzone,
                                                  UMShareToWechatSession,
                                                  UMShareToWechatTimeline,
                                                  UMShareToSina]
                                       delegate:self];
    //标题
    [UMSocialData defaultData].extConfig.qqData.title = commonContent;            // QQ 标题
    [UMSocialData defaultData].extConfig.qzoneData.title = commonContent;         // QQ 空间
    [UMSocialData defaultData].extConfig.wechatSessionData.title = commonContent;  //微信好友
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = commonContent; // 微信朋友圈
    //url
    [UMSocialData defaultData].extConfig.qqData.url = commonURL;                 // qq url
    [UMSocialData defaultData].extConfig.qzoneData.url = commonURL;           // QQ空间 url
    [UMSocialData defaultData].extConfig.wechatSessionData.url = commonURL;    // 微信好友 url
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = commonURL;    // 微信朋友圈 url
    //新浪图文链接
    [UMSocialData defaultData].extConfig.sinaData.shareText = [NSString stringWithFormat:@"%@,%@",commonContent,commonURL];

}


-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}

// 跳转到发现线索界面
-(void)toFindLineVC:(UIButton *)button
{
    HCPromisedCommentController *myFindLineVC = [[HCPromisedCommentController alloc]init];
    myFindLineVC.callId = self.info.callId;
    [self.navigationController pushViewController:myFindLineVC animated:YES];
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
    if ([self.status isEqualToString:@"1"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该呼已经被关闭" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alert dismissWithClickedButtonIndex:0 animated:YES];
        });
        [alert show];
    }
    else
    {
        [self.view addSubview:self.blackView];
    }
    
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
        
        [self showHUDView:@"正在跳转AppStore"];
        
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
        [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone)
         {
            if (requestStatus == HCRequestStatusSuccess) {
                    
            [self hideHUDView];
            NSLog(@"-----------------------关闭一呼百应--------------------------");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"aboutMeData" object:nil];
            [self.navigationController popToRootViewControllerAnimated:YES];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"callPromised" object:nil];
            [self.blackView removeFromSuperview];
            }
                
         }];
    }
    else
    {
        [self.blackView removeFromSuperview];
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
    UIImageView  *smallImageView = (UIImageView *)tap.view;
    HCBigImageViewController *bigImageVC = [[HCBigImageViewController alloc] init];
    bigImageVC.image = smallImageView.image;
    [self.navigationController pushViewController:bigImageVC animated:YES];
}

#pragma mark --- setter Or getter

//头像
- (UIButton *)headBtn
{
    if(!_headBtn){
        _headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _headBtn.frame = CGRectMake(17/375.0*SCREEN_WIDTH,10/668.0*SCREEN_HEIGHT, 80/680.0*SCREEN_HEIGHT, 80/680.0*SCREEN_HEIGHT);
        ViewRadius(_headBtn, _headBtn.frame.size.width*0.5);
        [_headBtn addTarget:self action:@selector(headClick:) forControlEvents:UIControlEventTouchUpInside];
        _headBtn.layer.borderColor = [UIColor redColor].CGColor;
        _headBtn.layer.borderWidth = 3;
        [_headBtn setBackgroundImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
        [self.view addSubview:_headBtn];
    }
    return _headBtn;
}

//性别
- (UIImageView *)sexIV
{
    if(!_sexIV){
        CGFloat sexIVX = self.headBtn.frame.origin.x+self.headBtn.frame.size.width + 10/375.0*SCREEN_WIDTH;
        _sexIV = [[UIImageView alloc]initWithFrame:CGRectMake(sexIVX, 30/668.0*SCREEN_HEIGHT, 15, 15)];
    }
    return _sexIV;
}

//姓名
- (UILabel *)nameLabel
{
    if(!_nameLabel){
        CGFloat nameLabelX = self.sexIV.frame.origin.x + self.sexIV.frame.size.width+10/375.0*SCREEN_WIDTH;
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(nameLabelX,30/668.0*SCREEN_HEIGHT,80/375.0*SCREEN_WIDTH,20/668.0*SCREEN_HEIGHT)];
        _nameLabel.adjustsFontSizeToFitWidth = YES;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.textColor = [UIColor blackColor];
    }
    return _nameLabel;
}

//年龄
- (UILabel *)ageLabel
{
    if(!_ageLabel){
        CGFloat  ageLabelX = self.nameLabel.frame.origin.x + self.nameLabel.frame.size.width;
        _ageLabel = [[UILabel alloc]initWithFrame:CGRectMake(ageLabelX,30/668.0*SCREEN_HEIGHT,50/375.0*SCREEN_WIDTH,20/668.0*SCREEN_HEIGHT)];
        _ageLabel.font = [UIFont systemFontOfSize:14];
        _ageLabel.textAlignment = NSTextAlignmentLeft;
        _ageLabel.textColor = [UIColor lightGrayColor];
    }
    return _ageLabel;
}

//丢失时间
- (UILabel *)missTimeLabel
{
    if(!_missTimeLabel){
        CGFloat missTimeLabelX = self.headBtn.frame.origin.x+self.headBtn.frame.size.width + 10/375.0*SCREEN_WIDTH;
        CGFloat missTimeLabelY = self.nameLabel.frame.origin.y+self.nameLabel.frame.size.height+5/668.0*SCREEN_HEIGHT;
        _missTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(missTimeLabelX, missTimeLabelY, SCREEN_WIDTH-missTimeLabelX, 20/668.0*SCREEN_HEIGHT)];
        _missTimeLabel.textColor = [UIColor blackColor];
        _missTimeLabel.font = [UIFont systemFontOfSize:14];
    }
    return _missTimeLabel;
}

//丢失地点
- (UILabel *)missPlaceLabel
{
    if (_missPlaceLabel == nil)
    {
        CGFloat missPlaceLabelX = self.headBtn.frame.origin.x+self.headBtn.frame.size.width + 10/375.0*SCREEN_WIDTH;
        CGFloat missPlaceLabelY = self.missTimeLabel.frame.origin.y+self.missTimeLabel.frame.size.height+5;
        _missPlaceLabel = [[UILabel alloc]initWithFrame:CGRectMake(missPlaceLabelX, missPlaceLabelY, SCREEN_WIDTH-missPlaceLabelX, 20/668.0*SCREEN_HEIGHT)];
        _missPlaceLabel.textColor = [UIColor blackColor];
        _missPlaceLabel.font = [UIFont systemFontOfSize:14];
    }
    return _missPlaceLabel;
}

//丢失描述
- (UILabel *)missMessageLabel
{
    if(!_missMessageLabel)
    {
        _missMessageLabel = [[UILabel alloc]initWithFrame:CGRectMake(20/375.0*SCREEN_WIDTH,self.missPlaceLabel.frame.origin.y+self.missPlaceLabel.frame.size.height+5/668.0*SCREEN_HEIGHT,SCREEN_WIDTH-40,10)];
        _missMessageLabel.font = [UIFont fontWithName:@"PingFangTC-Thin" size:17];
        //        _missMessageLabel.font = [UIFont boldSystemFontOfSize:5.0];
        _missMessageLabel.adjustsFontSizeToFitWidth = YES;
        _missMessageLabel.numberOfLines = 0;
        
    }
    return _missMessageLabel;
}

//图片的父视图
- (UIView *)backView
{
    if (_backView == nil)
    {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(60/375.0*SCREEN_WIDTH, CGRectGetMaxY(self.missMessageLabel.frame)+20/668.0*SCREEN_HEIGHT, 250/375.0*SCREEN_WIDTH, 350/668.0*SCREEN_HEIGHT)];
        _backView.backgroundColor = [UIColor whiteColor];
        ViewRadius(_backView, 10);
        [_backView addSubview:self.imageView];
        [_backView addSubview:self.imgeViewBottom];
        [_backView addSubview:self.MedicalBtn];
    }
    return _backView;
}


//图片
- (UIImageView *)imageView
{
    if(!_imageView){
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.backView.frame), 300/668.0*SCREEN_HEIGHT)];
        _imageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addBigImage:)];
        [_imageView addGestureRecognizer:tap];
        
        //        _imageView.contentMode  = UIViewContentModeScaleAspectFit;
        _imageView.backgroundColor = [UIColor blackColor];
        
    }
    return _imageView;
}

//图片的底部控件
- (UIView *)imgeViewBottom
{
    if(!_imgeViewBottom){
        _imgeViewBottom = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.imageView.frame),CGRectGetWidth(self.backView.frame), 50/668.0*SCREEN_HEIGHT)];
        _imgeViewBottom.backgroundColor = [UIColor whiteColor];
        [_imgeViewBottom addSubview:self.numLabel];
        [_imgeViewBottom addSubview:self.leftAnimationView];
        [_imgeViewBottom addSubview:self.rightAnimationview];
        UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(55/375.0*SCREEN_WIDTH, CGRectGetMaxY(self.numLabel.frame)+3/668.0*SCREEN_HEIGHT, CGRectGetWidth(self.numLabel.frame) - 10/375.0*SCREEN_WIDTH, 1)];
        lineLabel.backgroundColor = [UIColor darkGrayColor];
        [_imgeViewBottom addSubview:lineLabel];
        
        NSArray *btnArr = @[self.leftAnimationView,self.rightAnimationview];
        for (int i = 0; i<2; i++)
        {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX([btnArr[i] frame])+15/375.0*SCREEN_WIDTH,CGRectGetMinY([btnArr[i] frame]),70/375.0*SCREEN_WIDTH,CGRectGetHeight([btnArr[i] frame]))];
            label.textColor = [UIColor grayColor];
            label.tag = 500 + i;
            label.font = [UIFont systemFontOfSize:12];
            [_imgeViewBottom addSubview:label];
        }
        
    }
    return _imgeViewBottom;
}

//健康
- (UIButton *)MedicalBtn
{
    if(!_MedicalBtn){
        _MedicalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _MedicalBtn.frame = CGRectMake(5/375.0*SCREEN_WIDTH, 275/668.0*SCREEN_HEIGHT, 50/375.0*SCREEN_WIDTH, 50/375.0*SCREEN_WIDTH);
//        _MedicalBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        ViewRadius(_MedicalBtn,25/375.0*SCREEN_WIDTH);
        [_MedicalBtn addTarget:self action:@selector(toMedicalVC) forControlEvents:UIControlEventTouchUpInside];
    }
    return _MedicalBtn;
}

//编号
- (UILabel *)numLabel
{
    if(!_numLabel){
        _numLabel = [[UILabel alloc]initWithFrame:CGRectMake(55/375.0*SCREEN_WIDTH,0,CGRectGetWidth(_backView.frame)-CGRectGetMaxX(self.MedicalBtn.frame),15/668.0*SCREEN_HEIGHT)];
//        _numLabel.adjustsFontSizeToFitWidth = YES;
        _numLabel.font = [UIFont systemFontOfSize:13];
        _numLabel.textColor = [UIColor blackColor];
    }
    return _numLabel;
}

//联系人1
- (UIImageView *)leftAnimationView
{
    if (_leftAnimationView == nil)
    {
        _leftAnimationView = [[UIImageView alloc] initWithFrame:CGRectMake(55/375.0*SCREEN_WIDTH,CGRectGetMaxY(self.numLabel.frame)+10/668.0*SCREEN_HEIGHT,20/375.0*SCREEN_WIDTH,20/375.0*SCREEN_WIDTH)];
        _leftAnimationView.userInteractionEnabled = YES;
        _leftAnimationView.animationImages = @[IMG(@"myPromisedDetail_animation1"),IMG(@"myPromisedDetail_animation2"),IMG(@"myPromisedDetail_animation3")];
        _leftAnimationView.animationDuration = 3*0.3;
        _leftAnimationView.animationRepeatCount = 0;
        [_leftAnimationView startAnimating];
        
        UITapGestureRecognizer *leftTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(FatherTelClick)];
        [_leftAnimationView addGestureRecognizer:leftTap];
        //停止播放动画  - (void)stopAnimating;
        //判断是否正在执行动画  - (BOOL)isAnimating;
    }
    return _leftAnimationView;
}

//联系人2
- (UIImageView *)rightAnimationview
{
    if (_rightAnimationview == nil)
    {
        _rightAnimationview = [[UIImageView alloc] initWithFrame:CGRectMake(150/375.0*SCREEN_WIDTH,CGRectGetMaxY(self.numLabel.frame)+10/668.0*SCREEN_HEIGHT,20/375.0*SCREEN_WIDTH,20/375.0*SCREEN_WIDTH)];
        _rightAnimationview.userInteractionEnabled = YES;
        _rightAnimationview.animationImages = @[IMG(@"myPromisedDetail_animation1"),IMG(@"myPromisedDetail_animation2"),IMG(@"myPromisedDetail_animation3")];
        _rightAnimationview.animationDuration = 3*0.3;
        _rightAnimationview.animationRepeatCount = 0;
        [_rightAnimationview startAnimating];
        UITapGestureRecognizer *rightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(MotherTelClick)];
        [_rightAnimationview addGestureRecognizer:rightTap];
    }
    return _rightAnimationview;
}

//底部选择栏
- (UIView *)bottonView
{
    if (_bottonView == nil)
    {
        _bottonView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-49, SCREEN_WIDTH, 49)];
        _bottonView.backgroundColor = [UIColor whiteColor];
        [_bottonView addSubview:self.getClueBtn];
        [_bottonView addSubview:self.foundBtn];
    }
    return _bottonView;
}

- (UIButton *)getClueBtn
{
    if (_getClueBtn == nil)
    {
        _getClueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _getClueBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH/2-0.5, 49);
        [_getClueBtn setTitle:@"发现线索" forState:UIControlStateNormal];
        _getClueBtn.backgroundColor = [UIColor orangeColor];
        [_getClueBtn addTarget:self action:@selector(toFindLineVC:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _getClueBtn;
}

//已找到
- (UIButton *)foundBtn
{
    if(!_foundBtn){
        _foundBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _foundBtn.frame = CGRectMake(SCREEN_WIDTH/2+0.5, 0, SCREEN_WIDTH/2-0.5, 49);
        [_foundBtn setTitle:@"已找到" forState:UIControlStateNormal];
        _foundBtn.backgroundColor = [UIColor orangeColor];
        [_foundBtn addTarget:self action:@selector(foundBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _foundBtn;
}



- (UIView *)blackView
{
    if(!_blackView){
        _blackView = [[UIView alloc] initWithFrame:self.view.frame];
        _blackView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.3];
        [_blackView addSubview:self.myAlertView];
    }
    return _blackView;
}

//提示框
- (UIView *)myAlertView
{
    if(!_myAlertView){
        _myAlertView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300/375.0*SCREEN_WIDTH,160/668.0*SCREEN_HEIGHT)];
        _myAlertView.backgroundColor = [UIColor whiteColor];
        _myAlertView.center = CGPointMake(SCREEN_WIDTH/2, (SCREEN_HEIGHT-64-49)/2);
        ViewRadius(_myAlertView, 5);
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 35/668.0*SCREEN_HEIGHT, 300/375.0*SCREEN_WIDTH, 40/668.0*SCREEN_HEIGHT)];
        label.text = @"请确认是否关闭一呼百应";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        [_myAlertView addSubview:label];
        NSArray *Arr = @[@"关闭",@"取消"];
        for (int i = 0;i<2 ; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake((40 + i *130)/375.0*SCREEN_WIDTH, 100/668.0*SCREEN_HEIGHT, 90/375.0*SCREEN_WIDTH, 40/668.0*SCREEN_HEIGHT);
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
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(self.backView.frame) + 30/668.0*SCREEN_HEIGHT);
    }
    return _scrollView;
}

- (UIView *)grayView
{
    if(!_grayView){
        _grayView = [[UIView alloc]initWithFrame:CGRectMake(100, CGRectGetMaxX(self.numLabel.frame) + 5, 100, 20)];
        _grayView.backgroundColor = [UIColor blackColor];
        
    }
    return _grayView;
}

#pragma mark ---- network

-(void)requestDetailData
{
    [self showHUDView:nil];
    HCGetCallDetailInfoApi *api = [[HCGetCallDetailInfoApi alloc] init];
    api.callId = self.callId;
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone) {
        [self hideHUDView];
        if (requestStatus == HCRequestStatusSuccess)
        {
            NSDictionary *dic = respone[@"Data"][@"callInf"];
            self.info = [HCNotificationCenterInfo mj_objectWithKeyValues:dic];
            [self addDataSuorce];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
