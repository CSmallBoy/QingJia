//
//  HCPromisedNotiController.m
//  Project
//
//  Created by 朱宗汉 on 16/1/30.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCMyPromisedDetailController.h"
#import "HCNotificationHeadImageController.h"
#import "HCPromisedCommentController.h"
#import "HCMedicalViewController.h"

#import "HCNotificationCenterInfo.h"

#import "HCButtonItem.h"
@interface HCMyPromisedDetailController ()

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

@property (nonatomic,strong) HCNotificationCenterInfo   *info;

@end

@implementation HCMyPromisedDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.info = self.data[@"info"];
    [self setupBackItem];
    self.view.backgroundColor = [UIColor colorWithWhite:0.94f alpha:1.0f];
    self.title = @"一呼百应详情";
    [self.view addSubview:self.headBtn];
    [self.view addSubview:self.sexIV];
    [self.view addSubview:self.nameLabel];
    [self.view addSubview:self.ageLabel];
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.foundBtn];
    [self.view addSubview:self.missTimeLabel];
    [self.view addSubview:self.missMessageLabel];

   
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

// 点击了小按钮
-(void)buttonClick:(UIButton  *)button
{
    
    if ([button.titleLabel.text isEqualToString:@"好评"])
    {
        [self.blackView removeFromSuperview];
        [self.myAlertView removeFromSuperview];
        HCPromisedCommentController *commentVc= [[HCPromisedCommentController alloc]init];
        [self.navigationController pushViewController:commentVc animated:YES];
        
    }else  if ([button.titleLabel.text isEqualToString:@"关闭"])
    {
        [self.blackView removeFromSuperview];
        [self.myAlertView removeFromSuperview];
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
    [self.navigationController pushViewController:medicalVC animated:YES];
}

#pragma mark --- setter Or getter


- (UIView *)imgeViewBottom
{
    if(!_imgeViewBottom){
        _imgeViewBottom = [[UIView alloc]initWithFrame:CGRectMake(0,self.imageView.frame.size.height-self.imageView.frame.size.height/6,self.imageView.frame.size.width , self.imageView.frame.size.height/6)];
        _imgeViewBottom.backgroundColor = [UIColor whiteColor];
        [_imgeViewBottom addSubview:self.MedicalBtn];
        [_imgeViewBottom addSubview:self.numLabel];
        [_imgeViewBottom addSubview:self.FatherTel];
        [_imgeViewBottom addSubview:self.MotherTel];
        
        NSArray *btnArr = @[self.FatherTel,self.MotherTel];
        NSArray *arr = @[@"联系人1",@"联系人2"];
        for (int i = 0; i<2; i++)
        {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX([btnArr[i] frame])+5,self.numLabel.frame.size.height+3+self.imageView.frame.size.height/24-7.5,SCREEN_WIDTH*60/250 , 15)];
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
        _FatherTel.frame =CGRectMake(self.MedicalBtn.frame.size.width + 20, self.numLabel.frame.size.height+3,self.imageView.frame.size.height/12, self.imageView.frame.size.height/12) ;
        [_FatherTel setBackgroundImage:IMG(@"PHONE-1") forState:UIControlStateNormal];
    }
    return _FatherTel;
}

- (UIButton *)MotherTel
{
    if(!_MotherTel){
        _MotherTel = [UIButton buttonWithType:UIButtonTypeCustom];
        _MotherTel.frame =CGRectMake(self.MedicalBtn.frame.size.width + 20 + SCREEN_WIDTH*60/250, self.numLabel.frame.size.height+3,self.imageView.frame.size.height/12, self.imageView.frame.size.height/12) ;
        [_MotherTel setBackgroundImage:IMG(@"PHONE-1") forState:UIControlStateNormal];
    }
    return _MotherTel;
}

- (UILabel *)numLabel
{
    if(!_numLabel){
        _numLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.MedicalBtn.frame.size.width + 20,0,100,12)];
        _numLabel.text = @"编号：12345678";
        _numLabel.adjustsFontSizeToFitWidth = YES;
        _numLabel.textColor = [UIColor blackColor];
        
    }
    return _numLabel;
}

- (UIButton *)MedicalBtn
{
    if(!_MedicalBtn){
        _MedicalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _MedicalBtn.frame = CGRectMake(10, -self.imageView.frame.size.width/10, self.imageView.frame.size.width/5, self.imageView.frame.size.width/5);
        _MedicalBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        [_MedicalBtn addTarget:self action:@selector(toMedicalVC) forControlEvents:UIControlEventTouchUpInside];
        ViewRadius(_MedicalBtn,self.imageView.frame.size.width/10 );
        [_MedicalBtn setBackgroundImage:IMG(@"健康－爱心") forState:UIControlStateNormal];
        
    }
    return _MedicalBtn;
}


- (UIButton *)headBtn
{
    if(!_headBtn){
        _headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _headBtn.frame = CGRectMake(10,74, 80, 80);
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
        _sexIV = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 15, 15)];
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
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(125,100,75,20)];
        _nameLabel.adjustsFontSizeToFitWidth = YES;
        _nameLabel.text = self.info.name;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.textColor = [UIColor blackColor];
    }
    return _nameLabel;
}

- (UILabel *)ageLabel
{
    if(!_ageLabel){
        _ageLabel = [[UILabel alloc]initWithFrame:CGRectMake(210,100,30,20)];
        _ageLabel.font = [UIFont systemFontOfSize:14];
        _ageLabel.text = [NSString stringWithFormat:@"%@岁",self.info.age];
        _ageLabel.textColor = [UIColor lightGrayColor];
    }
    return _ageLabel;
}

- (UIImageView *)imageView
{
    if(!_imageView){
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.165, SCREEN_HEIGHT*0.35 + 40, SCREEN_WIDTH*0.67, SCREEN_HEIGHT *0.4)];
        ViewRadius(_imageView, 5);
        _imageView.image = IMG(@"1");
        _imageView.userInteractionEnabled = YES;
        [_imageView addSubview:self.imgeViewBottom];
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
        NSString *str = [NSString stringWithFormat:@"走失描述：%@",self.info.missDesc];
//        CGSize  size = [str boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-50, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14],NSForegroundColorAttributeName : [UIColor grayColor]} context:nil].size;
        _missMessageLabel = [[UILabel alloc]initWithFrame:CGRectMake(30,150,SCREEN_WIDTH-50,SCREEN_HEIGHT/8)];
        _missMessageLabel.adjustsFontSizeToFitWidth = YES;
        _missMessageLabel.text = str;
        _missMessageLabel.numberOfLines = 0;
        
    }
    return _missMessageLabel;
}


- (UILabel *)missTimeLabel
{
    if(!_missTimeLabel){
        _missTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 130, 200, 20)];
        _missTimeLabel.textColor = [UIColor blackColor];
        _missTimeLabel.font = [UIFont systemFontOfSize:14];
        _missTimeLabel.text = [NSString stringWithFormat:@"走失时间：%@",self.info.sendTime];
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
