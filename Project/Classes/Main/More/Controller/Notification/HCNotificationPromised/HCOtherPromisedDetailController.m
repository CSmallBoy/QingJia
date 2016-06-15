//
//  HCPromisedNotiController.m
//  Project
//
//  Created by 朱宗汉 on 16/1/30.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCOtherPromisedDetailController.h"
#import "HCNotificationHeadImageController.h"
#import "HCPromisedCommentController.h"
#import "HCPromisedCommentController.h"
#import "HCMedicalViewController.h"
#import "HCPromisedReportController.h"

#import "HCNotificationCenterInfo.h"
#import "HCPromisedDetailInfo.h"
#import "HCPromisedMissInfo.h"

#import "HCButtonItem.h"

#import "HCSaveCallApi.h"
#import "HCDeletePromisedApi.h"

//分享
#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "WXApi.h"
#import "UMSocialSinaHandler.h"
#import "UMSocialSnsPlatformManager.h"
#import "UMSocialSinaSSOHandler.h"
//图片轮播
#import "SDCycleScrollView.h"
//详情接口
#import "HCGetCallDetailInfoApi.h"
//大图
#import "HCBigImageViewController.h"

@interface HCOtherPromisedDetailController ()<UMSocialUIDelegate,UIAlertViewDelegate>
{
    BOOL  _isShowDelete;
}
@property (nonatomic,strong) UIImageView    *sexIV;
@property (nonatomic,strong) UIImageView    *imageView;

@property (nonatomic,strong) UIButton   *headBtn;
//@property (nonatomic,strong) UIButton   * FatherTel;
//@property (nonatomic,strong) UIButton   * MotherTel;
@property (nonatomic,strong) UIButton   *MedicalBtn;

@property (nonatomic,strong) UILabel    *nameLabel;
@property (nonatomic,strong) UILabel    *ageLabel;
@property (nonatomic,strong) UILabel    *missMessageLabel;
@property (nonatomic,strong) UILabel    *missTimeLabel;
@property (nonatomic,strong) UILabel *missPlaceLabel;//丢失地方
@property (nonatomic,strong) UILabel    *numLabel;

@property (nonatomic,strong) UIView     *footerView;
@property (nonatomic,strong) UIView     *imgeViewBottom;
@property (nonatomic,strong) UIScrollView  *scrollView;
@property (nonatomic,strong) UIImageView   *deletIV;
@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong)UIImageView *leftAnimationView;//动画
@property (nonatomic,strong)UIImageView *rightAnimationview;

@property (nonatomic,strong) HCButtonItem *messageBtn;
@property (nonatomic,strong) HCButtonItem *MTalkBtn;
@property (nonatomic,strong) HCButtonItem *policeBtn;


@property (nonatomic,strong) HCNotificationCenterInfo *info;
@property (nonatomic,strong) HCPromisedMissInfo *missInfo;
@property (nonatomic,strong) HCPromisedDetailInfo *detailInfo;


@end

@implementation HCOtherPromisedDetailController

- (void)viewDidLoad {
    
    //一呼百应详情 ----- 别人的一呼百应
    [super viewDidLoad];
    [self setupBackItem];
    // 导航栏上的加号“+”
    [self addItem];
    self.view.backgroundColor = [UIColor colorWithWhite:0.94f alpha:1.0f];
    self.title = @"一呼百应详情";
    _isShowDelete = NO;
    
    
    [self.scrollView addSubview:self.headBtn];
    [self.scrollView addSubview:self.sexIV];
    [self.scrollView addSubview:self.nameLabel];
    [self.scrollView addSubview:self.ageLabel];
    [self.scrollView addSubview:self.backView];
    [self.scrollView addSubview:self.missTimeLabel];
    [self.scrollView addSubview:self.missPlaceLabel];
    [self.scrollView addSubview:self.missMessageLabel];
    self.view = self.scrollView;
    [self.navigationController.view addSubview:self.footerView];
    [self.view addSubview:self.deletIV];
    
    [self requestDetailData];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.view addSubview:self.footerView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.footerView removeFromSuperview];
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

#pragma mark --- private mothods

-(void)addItem
{
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:IMG(@"导航条－inclass_Plus") style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick:)];
    self.navigationItem.rightBarButtonItem = right;
    
}

// 点击了右边的Item
-(void)rightItemClick:(UIBarButtonItem *)right
{
    if (_isShowDelete)
    {
        [UIView animateWithDuration:0.3 animations:^{
            self.deletIV.frame = CGRectMake(255/375.0*SCREEN_WIDTH, -160/668.0*SCREEN_HEIGHT, 110/375.0*SCREEN_WIDTH, 160/668.0*SCREEN_HEIGHT);
        } completion:^(BOOL finished) {
            _isShowDelete = NO;
        }];
        
    }else
    {
        [UIView animateWithDuration:0.3 animations:^{
            self.deletIV.frame = CGRectMake(255/375.0*SCREEN_WIDTH, 0, 110/375.0*SCREEN_WIDTH, 160/668.0*SCREEN_HEIGHT);
        } completion:^(BOOL finished) {
            _isShowDelete = YES;
        }];
    }
    
}


//点击举报
-(void)toReportVC:(UIButton *)button
{
    [UIView animateWithDuration:0.3 animations:^{
        self.deletIV.frame = CGRectMake(255/375.0*SCREEN_WIDTH, -160/668.0*SCREEN_HEIGHT, 110/375.0*SCREEN_WIDTH, 160/668.0*SCREEN_HEIGHT);
    } completion:^(BOOL finished) {
        _isShowDelete = NO;
    }];
    HCPromisedReportController *reportVC = [[HCPromisedReportController alloc]init];
    reportVC.callId = self.info.callId;
    [self.navigationController pushViewController:reportVC animated:YES];
}

// 点击头像
-(void)headClick:(UIButton  *)button
{
    UIImage *image = [button backgroundImageForState:UIControlStateNormal];
    HCNotificationHeadImageController *imageVC = [[HCNotificationHeadImageController alloc]init];
    imageVC.data = @{@"image" : image};
    [self.navigationController pushViewController:imageVC animated:YES];
}

// 点击进入  医疗急救卡
-(void)toMedicalVC
{
    HCMedicalViewController   *medicalVC = [[HCMedicalViewController alloc]init];
    medicalVC.objectId = self.info.objectId;
    [self.navigationController pushViewController:medicalVC animated:YES];
}

-(void)CallTOPromised
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否确认拨打客服电话" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 300;
    [alert show];
}

-(void)SendMessage
{
    HCPromisedCommentController *commentVC = [[HCPromisedCommentController alloc]init];
    commentVC.callId = self.info.callId;
    [self.navigationController pushViewController:commentVC animated:YES];
}

-(void)CallPolice
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否确认拨打110" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 200;
    [alert show];
}

-(void)FatherTelClick
{
    NSString *tel = [NSString stringWithFormat:@"tel://%@",self.info.contactorPhoneNo1];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tel]];
    [self showHUDText:@"拨打联系人1"];
}

-(void)MotherTelClick
{
    NSString *tel = [NSString stringWithFormat:@"tel://%@",self.info.contactorPhoneNo2];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tel]];
    [self showHUDText:@"拨打联系人2"];
}


// 点击进入图片大图
-(void)addBigImage:(UITapGestureRecognizer *)tap
{
    if (_isShowDelete) {
        [UIView animateWithDuration:0.3 animations:^{
            self.deletIV.frame = CGRectMake(255/375.0*SCREEN_WIDTH, -160/668.0*SCREEN_HEIGHT, 110/375.0*SCREEN_WIDTH, 160/668.0*SCREEN_HEIGHT);
        } completion:^(BOOL finished) {
            _isShowDelete = NO;
        }];
        return;
    }
    UIImageView  *smallImageView = (UIImageView *)tap.view;
    HCBigImageViewController *bigImageVC = [[HCBigImageViewController alloc] init];
    bigImageVC.image = smallImageView.image;
    [self.navigationController pushViewController:bigImageVC animated:YES];
}

//点击删除
- (void)manageBtnClick
{
    HCDeletePromisedApi *api =[[HCDeletePromisedApi alloc]init];
    api.callId = self.info.callId;
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone) {
        if (requestStatus == HCRequestStatusSuccess) {
            [self showHUDText:@"删除成功"];
            [UIView animateWithDuration:0.3 animations:^{
                self.deletIV.frame = CGRectMake(255/375.0*SCREEN_WIDTH, -160/668.0*SCREEN_HEIGHT, 110/375.0*SCREEN_WIDTH, 160/668.0*SCREEN_HEIGHT);
            } completion:^(BOOL finished) {
                _isShowDelete = NO;
            }];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"aboutMeData" object:nil];
        }
        else
        {
            [self showHUDText:respone[@"message"]];
            [UIView animateWithDuration:0.3 animations:^{
                self.deletIV.frame = CGRectMake(255/375.0*SCREEN_WIDTH, -160/668.0*SCREEN_HEIGHT, 110/375.0*SCREEN_WIDTH, 160/668.0*SCREEN_HEIGHT);
            } completion:^(BOOL finished) {
                _isShowDelete = NO;
            }];
        }
        
    }];
}

//点击收藏
- (void)collectButtonClick
{
    HCSaveCallApi *api =[[HCSaveCallApi alloc]init];
    api.callId = self.info.callId;
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone) {
        if (requestStatus == HCRequestStatusSuccess) {
            [self showHUDText:@"收藏成功"];
           
            [UIView animateWithDuration:0.3 animations:^{
                self.deletIV.frame = CGRectMake(255/375.0*SCREEN_WIDTH, -160/668.0*SCREEN_HEIGHT, 110/375.0*SCREEN_WIDTH, 160/668.0*SCREEN_HEIGHT);
            } completion:^(BOOL finished) {
                _isShowDelete = NO;
            }];

            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"showSave" object:nil];
        }
        else
        {
            [self showHUDText:respone[@"message"]];
            [UIView animateWithDuration:0.3 animations:^{
                self.deletIV.frame = CGRectMake(255/375.0*SCREEN_WIDTH, -160/668.0*SCREEN_HEIGHT, 110/375.0*SCREEN_WIDTH, 160/668.0*SCREEN_HEIGHT);
            } completion:^(BOOL finished) {
                _isShowDelete = NO;
            }];
        }
        
    }];
}

//点击分享
- (void)toShoreVC
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


#pragma mark - viewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 200)
    {
        if (buttonIndex == 0)
        {
            [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
        }else
        {
            NSString *tel = [NSString stringWithFormat:@"tel://110"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tel]];
//            [self showHUDText:@"拨打110"];
        }
        
    }
    else if (alertView.tag == 300)
    {
        if (buttonIndex == 0)
        {
            [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
        }else
        {
            NSString *tel = [NSString stringWithFormat:@"tel://02134537916"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tel]];
//            [self showHUDText:@"拨打客服电话"];
        }
        
    }
}


#pragma mark --- setter Or getter


- (UIImageView *)deletIV
{
    if (_deletIV == nil)
    {
        UIButton *manageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        manageButton.frame = CGRectMake(20/375.0*SCREEN_WIDTH, 17/668.0*SCREEN_HEIGHT, 17/375.0*SCREEN_WIDTH, 17/668.0*SCREEN_HEIGHT);
        [manageButton setBackgroundImage:IMG(@"otherPromisedDetail_delete") forState:UIControlStateNormal];
        [manageButton addTarget:self action:@selector(manageBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *manageTitleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        manageTitleButton.frame = CGRectMake(CGRectGetMaxX(manageButton.frame), 12/668.0*SCREEN_HEIGHT, 83/375.0*SCREEN_WIDTH, 28/668.0*SCREEN_HEIGHT);
        [manageTitleButton setTitle:@"删除" forState:UIControlStateNormal];
        [manageTitleButton addTarget:self action:@selector(manageBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *scanButton = [UIButton buttonWithType:UIButtonTypeCustom];
        scanButton.frame = CGRectMake(CGRectGetMinX(manageButton.frame), CGRectGetMaxY(manageButton.frame)+21/668.0*SCREEN_HEIGHT, CGRectGetWidth(manageButton.frame), CGRectGetHeight(manageButton.frame));
        [scanButton setBackgroundImage:IMG(@"otherPromisedDetail_report") forState:UIControlStateNormal];
        [scanButton addTarget:self action:@selector(toReportVC:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *scanTitleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        scanTitleButton.frame = CGRectMake(CGRectGetMaxX(manageButton.frame), CGRectGetMaxY(manageTitleButton.frame)+10/668.0*SCREEN_HEIGHT, CGRectGetWidth(manageTitleButton.frame), CGRectGetHeight(manageTitleButton.frame));
        [scanTitleButton setTitle:@"举报" forState:UIControlStateNormal];
        [scanTitleButton addTarget:self action:@selector(toReportVC:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        collectButton.frame = CGRectMake(CGRectGetMinX(manageButton.frame), CGRectGetMaxY(scanButton.frame)+21/668.0*SCREEN_HEIGHT, CGRectGetWidth(manageButton.frame), CGRectGetHeight(manageButton.frame));
        [collectButton setBackgroundImage:IMG(@"otherPromisedDetail_collect") forState:UIControlStateNormal];
        [collectButton addTarget:self action:@selector(collectButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *collectTitleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        collectTitleButton.frame = CGRectMake(CGRectGetMaxX(manageButton.frame), CGRectGetMaxY(scanTitleButton.frame)+10/668.0*SCREEN_HEIGHT, CGRectGetWidth(manageTitleButton.frame), CGRectGetHeight(manageTitleButton.frame));
        [collectTitleButton setTitle:@"收藏" forState:UIControlStateNormal];
        [collectTitleButton addTarget:self action:@selector(collectButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *reportBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        reportBtn.frame = CGRectMake(CGRectGetMinX(manageButton.frame), CGRectGetMaxY(collectButton.frame)+21/668.0*SCREEN_HEIGHT, CGRectGetWidth(manageButton.frame), CGRectGetHeight(manageButton.frame));
        [reportBtn setBackgroundImage:IMG(@"myPromisedDetail_share") forState:UIControlStateNormal];
        [reportBtn addTarget:self action:@selector(toShoreVC) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *reportText = [UIButton buttonWithType:UIButtonTypeCustom];
        reportText.frame = CGRectMake(CGRectGetMaxX(manageButton.frame), CGRectGetMaxY(collectTitleButton.frame)+10/668.0*SCREEN_HEIGHT, CGRectGetWidth(manageTitleButton.frame), CGRectGetHeight(manageTitleButton.frame));
        [reportText setTitle:@"分享" forState:UIControlStateNormal];
        [reportText addTarget:self action:@selector(toShoreVC) forControlEvents:UIControlEventTouchUpInside];
        
        self.deletIV = [[UIImageView alloc] initWithFrame:CGRectMake(255/375.0*SCREEN_WIDTH, -160/668.0*SCREEN_HEIGHT, 110/375.0*SCREEN_WIDTH, 160/668.0*SCREEN_HEIGHT)];
        self.deletIV.image = IMG(@"pullDown_longMenu");
        self.deletIV.userInteractionEnabled = YES;
        
        
        [self.deletIV addSubview:manageButton];
        [self.deletIV addSubview:manageTitleButton];
        [self.deletIV addSubview:scanButton];
        [self.deletIV addSubview:scanTitleButton];
        [self.deletIV addSubview:collectButton];
        [self.deletIV addSubview:collectTitleButton];
        [self.deletIV addSubview:reportBtn];
        [self.deletIV addSubview:reportText];
    }
    return _deletIV;
}


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
            label.tag = 500+i;
            label.textColor = [UIColor grayColor];
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
        //停止播放动画stopAnimating;
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


-(UIView *)footerView
{
    if (!_footerView)
    {
        _footerView = [[UIView alloc]initWithFrame:CGRectMake(0,SCREEN_HEIGHT-60 , SCREEN_WIDTH, 60)];
        _footerView.backgroundColor = [UIColor whiteColor];
        
        UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 1)];
        topView.backgroundColor = [UIColor lightGrayColor];
        [_footerView addSubview:topView];
        
        UIView *lineViewOne = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3-1, 10, 1, 40)];
        lineViewOne.backgroundColor = LightGraryColor;
        [_footerView addSubview:lineViewOne];
        
        UIView *lineViewTwo = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3*2-2, 10, 1, 40)];
        lineViewTwo.backgroundColor = LightGraryColor;
        [_footerView addSubview:lineViewTwo];
        
        [_footerView addSubview: self.messageBtn];
        [_footerView addSubview: self.MTalkBtn];
        [_footerView addSubview: self.policeBtn];
    }
    return _footerView;
}

-(HCButtonItem *)MTalkBtn
{
    //message_phone  m-talk_Customer-Services
    if (!_MTalkBtn)
    {
        _MTalkBtn=[[HCButtonItem alloc]initWithFrame:CGRectMake(0, 2, SCREEN_WIDTH/3-2, 44) WithImageName:@"m-talk_Customer-Services" WithImageWidth:30 WithImageHeightPercentInItem:.7 WithTitle:NSLocalizedString(@"M-Talk客服", nil) WithFontSize:14 WithFontColor:OrangeColor WithGap:10];
        [_MTalkBtn addTarget:self action:@selector(CallTOPromised) forControlEvents:UIControlEventTouchUpInside];
    }
    return _MTalkBtn;
}

-(HCButtonItem *)messageBtn
{
    if (!_messageBtn)
    {
        _messageBtn=[[HCButtonItem alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3, 2, SCREEN_WIDTH/3-2, 44) WithImageName:@"Eye" WithImageWidth:30 WithImageHeightPercentInItem:.7 WithTitle:NSLocalizedString(@"发现线索", nil) WithFontSize:14 WithFontColor:OrangeColor WithGap:10];
        [_messageBtn addTarget:self action:@selector(SendMessage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _messageBtn;
}

-(HCButtonItem *)policeBtn
{
    if (!_policeBtn)
    {
        _policeBtn=[[HCButtonItem alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3*2, 2, SCREEN_WIDTH/3-2, 44) WithImageName:@"110" WithImageWidth:30 WithImageHeightPercentInItem:.7 WithTitle:NSLocalizedString(@"快速报警", nil) WithFontSize:14 WithFontColor:OrangeColor WithGap:10];
        [_policeBtn addTarget:self action:@selector(CallPolice) forControlEvents:UIControlEventTouchUpInside];
    }
    return _policeBtn;
}

- (UIScrollView *)scrollView
{
    if(!_scrollView){
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT, SCREEN_HEIGHT-49)];
        _scrollView.backgroundColor = kHCBackgroundColor;
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(self.backView.frame) + 30/668.0*SCREEN_HEIGHT);
        
        UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeDeletIV)];
        [_scrollView addGestureRecognizer:tap];
    }
    return _scrollView;
}

-(void)removeDeletIV
{
    if (_isShowDelete)
    {
        [UIView animateWithDuration:0.3 animations:^{
            self.deletIV.frame = CGRectMake(255/375.0*SCREEN_WIDTH, -160/668.0*SCREEN_HEIGHT, 110/375.0*SCREEN_WIDTH, 160/668.0*SCREEN_HEIGHT);
        } completion:^(BOOL finished) {
            _isShowDelete = NO;
        }];
    }
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
            
            //推送问题
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            NSMutableArray *mutableArray = [NSMutableArray
                                            arrayWithArray:[user objectForKey:@"callIdArr"]];
            if (mutableArray.count)
            {
                if ([mutableArray containsObject:self.callId])
                {
                    [mutableArray removeObject:self.callId];
                    NSInteger callPushNum = [[[NSUserDefaults standardUserDefaults] objectForKey:@"Call_Badge"] integerValue];
                    callPushNum--;
                    [[NSUserDefaults standardUserDefaults] setInteger:callPushNum forKey:@"Call_Badge"];
                    if (callPushNum == 0)
                    {
                        self.navigationController.tabBarItem.badgeValue = nil;
                    }
                    else
                    {
                        self.navigationController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld", callPushNum];
                    }
                }
            }
            NSArray * array = [NSArray arrayWithArray:mutableArray];
            [user setObject:array forKey:@"callIdArr"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"cityCallPush" object:nil];

        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
