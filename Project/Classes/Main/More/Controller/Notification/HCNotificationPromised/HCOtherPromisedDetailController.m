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

@interface HCOtherPromisedDetailController ()
{
    BOOL  _isShowDelete;
}
@property (nonatomic,strong) UIImageView    *sexIV;
@property (nonatomic,strong) UIImageView    *imageView;

@property (nonatomic,strong) UIButton   *headBtn;
@property (nonatomic,strong) UIButton   * FatherTel;
@property (nonatomic,strong) UIButton   * MotherTel;
@property (nonatomic,strong) UIButton   *MedicalBtn;

@property (nonatomic,strong) UILabel    *nameLabel;
@property (nonatomic,strong) UILabel    *ageLabel;
@property (nonatomic,strong) UILabel    *missMessageLabel;
@property (nonatomic,strong) UILabel    *missTimeLabel;
@property (nonatomic,strong) UILabel    *numLabel;

@property (nonatomic,strong) UIView     *footerView;
@property (nonatomic,strong) UIView     *imgeViewBottom;
@property (nonatomic,strong) UIScrollView  *scrollView;
@property (nonatomic,strong) UIImageView   *deletIV;

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
    self.info = self.data[@"info"];
    [self setupBackItem];
    self.view.backgroundColor = [UIColor colorWithWhite:0.94f alpha:1.0f];
    self.title = @"一呼百应详情";
    _isShowDelete = NO;
    [self requestDetailData];
    
    [self.scrollView addSubview:self.headBtn];
    [self.scrollView addSubview:self.sexIV];
    [self.scrollView addSubview:self.nameLabel];
    [self.scrollView addSubview:self.ageLabel];
    [self.scrollView addSubview:self.imageView];
    [self.scrollView addSubview:self.missTimeLabel];
    [self.scrollView addSubview:self.missMessageLabel];
    
    [self.view addSubview:self.scrollView];
    
    [self.view addSubview:self.footerView];
    [self.view addSubview:self.deletIV];
    
    // 导航栏上的加号“+”
    [self addItem];
    
    NSURL *url = [readUserInfo originUrl:self.info.lossImageName :kkLoss];
    [self.imageView sd_setImageWithURL:url placeholderImage:IMG(@"label_Head-Portraits")];
    
    NSURL *url1 = [readUserInfo originUrl:self.info.imageName :kkObject];
    UIImage *image = [[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:url1]];
    if (image) {
        [self.headBtn setBackgroundImage:image forState:UIControlStateNormal];
    }
    
    
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
            self.deletIV.frame = CGRectMake(255/375.0*SCREEN_WIDTH, -120/668.0*SCREEN_HEIGHT, 110/375.0*SCREEN_WIDTH, 120/668.0*SCREEN_HEIGHT);
        } completion:^(BOOL finished) {
            _isShowDelete = NO;
        }];
        
    }else
    {
        [UIView animateWithDuration:0.3 animations:^{
            self.deletIV.frame = CGRectMake(255/375.0*SCREEN_WIDTH, 64, 110/375.0*SCREEN_WIDTH, 120/668.0*SCREEN_HEIGHT);
        } completion:^(BOOL finished) {
            _isShowDelete = YES;
        }];
    }
    
}


//点击举报
-(void)toReportVC:(UIButton *)button
{
    [UIView animateWithDuration:0.3 animations:^{
        self.deletIV.frame = CGRectMake(255/375.0*SCREEN_WIDTH, -120/668.0*SCREEN_HEIGHT, 110/375.0*SCREEN_WIDTH, 120/668.0*SCREEN_HEIGHT);
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
    NSString *tel = [NSString stringWithFormat:@"tel://02134537916"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tel]];
    [self showHUDText:@"拨打客服电话"];
    //    HCPromisedViewController *promisedVC = [[HCPromisedViewController alloc]init];
    //    [self.navigationController pushViewController:promisedVC animated:YES];
}

-(void)SendMessage
{

    HCPromisedCommentController *commentVC = [[HCPromisedCommentController alloc]init];
    commentVC.callId = self.info.callId;
    [self.navigationController pushViewController:commentVC animated:YES];
}

-(void)CallPolice
{
    NSString *tel = [NSString stringWithFormat:@"tel://10086"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tel]];
    [self showHUDText:@"拨打110"];
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
            self.deletIV.frame = CGRectMake(255/375.0*SCREEN_WIDTH, -120/668.0*SCREEN_HEIGHT, 110/375.0*SCREEN_WIDTH, 120/668.0*SCREEN_HEIGHT);
        } completion:^(BOOL finished) {
            _isShowDelete = NO;
        }];
        return;
    }
    
    self.navigationController.navigationBarHidden = YES;
    CGRect  startFrame = [self.imageView convertRect:self.imageView.bounds toView:self.view];
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
    
    
    //长按将图片存储到相册
//    UILongPressGestureRecognizer *longTap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(saveImageToPhotoAlbum:)];
//    [bigImageView addGestureRecognizer:longTap];
    
}

//- (void)saveImageToPhotoAlbum:(UILongPressGestureRecognizer *)tap
//{
//    UIImageView *imageView = (UIImageView *)tap.view;
//    UIImageWriteToSavedPhotosAlbum(imageView.image, nil, nil, nil);
//    
//}

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

//点击删除
- (void)manageBtnClick
{
    
}

//点击收藏
- (void)collectButtonClick
{
    HCSaveCallApi *api =[[HCSaveCallApi alloc]init];
    api.callId = self.info.callId;
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone) {
        if (requestStatus == HCRequestStatusSuccess) {
            [self showHUDText:@"收藏成功"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"showSave" object:nil];
        }
        
    }];
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
        manageTitleButton.frame = CGRectMake(CGRectGetMaxX(manageButton.frame), 12/668.0*SCREEN_HEIGHT, 83/375.0*SCREEN_WIDTH, 27/668.0*SCREEN_HEIGHT);
        [manageTitleButton setTitle:@"删除" forState:UIControlStateNormal];
        [manageTitleButton addTarget:self action:@selector(manageBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *scanButton = [UIButton buttonWithType:UIButtonTypeCustom];
        scanButton.frame = CGRectMake(CGRectGetMinX(manageButton.frame), CGRectGetMaxY(manageButton.frame)+20/668.0*SCREEN_HEIGHT, CGRectGetWidth(manageButton.frame), CGRectGetHeight(manageButton.frame));
        [scanButton setBackgroundImage:IMG(@"otherPromisedDetail_report") forState:UIControlStateNormal];
        [scanButton addTarget:self action:@selector(toReportVC:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *scanTitleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        scanTitleButton.frame = CGRectMake(CGRectGetMaxX(manageButton.frame), CGRectGetMaxY(manageTitleButton.frame)+10/668.0*SCREEN_HEIGHT, CGRectGetWidth(manageTitleButton.frame), CGRectGetHeight(manageTitleButton.frame));
        [scanTitleButton setTitle:@"举报" forState:UIControlStateNormal];
        [scanTitleButton addTarget:self action:@selector(toReportVC:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        collectButton.frame = CGRectMake(CGRectGetMinX(manageButton.frame), CGRectGetMaxY(scanButton.frame)+20/668.0*SCREEN_HEIGHT, CGRectGetWidth(manageButton.frame), CGRectGetHeight(manageButton.frame));
        [collectButton setBackgroundImage:IMG(@"otherPromisedDetail_collect") forState:UIControlStateNormal];
        [collectButton addTarget:self action:@selector(collectButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *collectTitleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        collectTitleButton.frame = CGRectMake(CGRectGetMaxX(manageButton.frame), CGRectGetMaxY(scanTitleButton.frame)+10/668.0*SCREEN_HEIGHT, CGRectGetWidth(manageTitleButton.frame), CGRectGetHeight(manageTitleButton.frame));
        [collectTitleButton setTitle:@"收藏" forState:UIControlStateNormal];
        [collectTitleButton addTarget:self action:@selector(collectButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        self.deletIV = [[UIImageView alloc] initWithFrame:CGRectMake(255/375.0*SCREEN_WIDTH, -120/668.0*SCREEN_HEIGHT, 110/375.0*SCREEN_WIDTH, 120/668.0*SCREEN_HEIGHT)];
        self.deletIV.image = IMG(@"pullDown_menu");
        self.deletIV.userInteractionEnabled = YES;
        
        
        [self.deletIV addSubview:manageButton];
        [self.deletIV addSubview:manageTitleButton];
        [self.deletIV addSubview:scanButton];
        [self.deletIV addSubview:scanTitleButton];
        [self.deletIV addSubview:collectButton];
        [self.deletIV addSubview:collectTitleButton];
    }
    return _deletIV;
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
        _ageLabel.text = [NSString stringWithFormat:@"%@岁",self.info.age ];
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

- (UILabel *)numLabel
{
    if(!_numLabel){
        _numLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.MedicalBtn.frame.size.width + 10,5,160/320.0*SCREEN_WIDTH,12/480.0*SCREEN_HEIGHT)];
        _numLabel.text =[NSString stringWithFormat:@"编号：%@",self.info.callId];
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
        _MotherTel.frame =CGRectMake(self.MedicalBtn.frame.size.width+10 + SCREEN_WIDTH*60/250.0 + 5,
                                     CGRectGetMaxY(self.numLabel.frame) +7,
                                     self.imageView.frame.size.height/7 * 25/50,
                                     self.imageView.frame.size.height/7 * 25/50) ;
        [_MotherTel addTarget:self action:@selector(MotherTelClick) forControlEvents:UIControlEventTouchUpInside];
        [_MotherTel setBackgroundImage:IMG(@"PHONE-1") forState:UIControlStateNormal];
    }
    return _MotherTel;
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
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(self.imageView.frame) + 30);
        
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
            self.deletIV.frame = CGRectMake(255/375.0*SCREEN_WIDTH, -120/668.0*SCREEN_HEIGHT, 110/375.0*SCREEN_WIDTH, 120/668.0*SCREEN_HEIGHT);
        } completion:^(BOOL finished) {
            _isShowDelete = NO;
        }];
    }
}

#pragma mark ---- network

-(void)requestDetailData
{

    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
