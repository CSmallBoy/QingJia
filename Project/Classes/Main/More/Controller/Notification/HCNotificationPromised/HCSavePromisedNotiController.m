//
//  HCPromisedNotiController.m
//  Project
//
//  Created by 朱宗汉 on 16/1/30.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCSavePromisedNotiController.h"
#import "HCNotificationHeadImageController.h"
#import "HCButtonItem.h"
@interface HCSavePromisedNotiController ()

@property (nonatomic,strong) UIButton   *headBtn;
@property (nonatomic,strong) UIImageView    *sexIV;
@property (nonatomic,strong) UILabel    *nameLabel;
@property (nonatomic,strong) UILabel    *ageLabel;
@property (nonatomic ,strong) UIImageView   *imageView;
@property (nonatomic,strong) UIButton   * FatherTel;
@property (nonatomic,strong) UIButton   * MotherTel;
@property (nonatomic,strong) UILabel    *missMessageLabel;


@property (nonatomic,strong) UIView  *footerView;
@property (nonatomic,strong) HCButtonItem *messageBtn;
@property (nonatomic,strong) HCButtonItem *MTalkBtn;
@property (nonatomic,strong) HCButtonItem *policeBtn;

@end

@implementation HCSavePromisedNotiController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBackItem];
    self.view.backgroundColor = [UIColor colorWithWhite:0.94f alpha:1.0f];
    self.title = @"一呼百应详情";
    [self.view addSubview:self.headBtn];
    [self.view addSubview:self.sexIV];
    [self.view addSubview:self.nameLabel];
    [self.view addSubview:self.ageLabel];
    [self.view addSubview:self.imageView];
    
    [self.view addSubview:self.footerView];
   
}


#pragma mark --- private mothods
// 点击头像
-(void)head_Click:(UIButton  *)button
{
    UIImage *image = [button backgroundImageForState:UIControlStateNormal];
    HCNotificationHeadImageController *imageVC = [[HCNotificationHeadImageController alloc]init];
    imageVC.data = @{@"image" : image};
    [self.navigationController pushViewController:imageVC animated:YES];
}


-(void)pushTOPromised
{
    NSString *tel = [NSString stringWithFormat:@"tel://02134537916"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tel]];
    [self showHUDText:@"拨打客服电话"];
    //    HCPromisedViewController *promisedVC = [[HCPromisedViewController alloc]init];
    //    [self.navigationController pushViewController:promisedVC animated:YES];
}

-(void)ContactCustomerService
{
    [self showHUDText:@"留言"];
}

-(void)ContactWithPolice
{
    NSString *tel = [NSString stringWithFormat:@"tel://10086"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tel]];
    [self showHUDText:@"拨打110"];
}

#pragma mark --- setter Or getter


- (UIButton *)headBtn
{
    if(!_headBtn){
        _headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _headBtn.frame = CGRectMake(SCREEN_WIDTH*0.35, 64 +20, SCREEN_WIDTH*0.3, SCREEN_WIDTH*0.3);
        ViewRadius(_headBtn, _headBtn.frame.size.width*0.5);
        [_headBtn addTarget:self action:@selector(head_Click:) forControlEvents:UIControlEventTouchUpInside];
        _headBtn.layer.borderColor = [UIColor redColor].CGColor;
        _headBtn.layer.borderWidth = 3;
        [_headBtn setBackgroundImage:[UIImage imageNamed:@"image_hea.jpg"] forState:UIControlStateNormal];
        [self.view addSubview:_headBtn];
    }
    return _headBtn;
}


- (UIImageView *)sexIV
{
    if(!_sexIV){
        _sexIV = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.355, 64+20+ self.headBtn.frame.size.height + 10, 15, 15)];
        _sexIV.backgroundColor = [UIColor yellowColor];
    }
    return _sexIV;
}


- (UILabel *)nameLabel
{
    if(!_nameLabel){
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.38+self.sexIV.frame.size.width, 64+20+ self.headBtn.frame.size.height + 10, 60  ,20)];
        _nameLabel.text = @"姓名";
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.textColor = [UIColor blackColor];
    }
    return _nameLabel;
}


- (UILabel *)ageLabel
{
    if(!_ageLabel){
        _ageLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.355+self.sexIV.frame.size.width+10+60, 64+20+ self.headBtn.frame.size.height + 10, 40  ,20)];
        _ageLabel.font = [UIFont systemFontOfSize:12];
        _ageLabel.text = @"5岁";
        _ageLabel.textColor = [UIColor lightGrayColor];
    }
    return _ageLabel;
}


- (UIImageView *)imageView
{
    if(!_imageView){
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.165, SCREEN_HEIGHT*0.35, SCREEN_WIDTH*0.67, SCREEN_HEIGHT *0.54)];
        ViewRadius(_imageView, 5);
        _imageView.image = IMG(@"label_Head-Portraits");
        
        _imageView.userInteractionEnabled = YES;
        [_imageView addSubview:self.FatherTel];
        [_imageView addSubview:self.MotherTel];
        [_imageView addSubview:self.missMessageLabel];
        
        }
    return _imageView;
}


- (UIButton *)FatherTel
{
    if(!_FatherTel){
        _FatherTel = [UIButton buttonWithType:UIButtonTypeCustom];
        [_FatherTel setTitle:@"联系父亲" forState:UIControlStateNormal];
        _FatherTel.frame =CGRectMake(0, self.imageView.frame.size.height-50, self.imageView.frame.size.width/2, 50) ;
        _FatherTel.backgroundColor = [UIColor orangeColor];
                           
    }
    return _FatherTel;
}

- (UIButton *)MotherTel
{
    if(!_MotherTel){
        _MotherTel = [UIButton buttonWithType:UIButtonTypeCustom];
        [_MotherTel setTitle:@"联系母亲" forState:UIControlStateNormal];
        _MotherTel.backgroundColor = [UIColor orangeColor];
        _MotherTel.frame =CGRectMake(self.imageView.frame.size.width/2, self.imageView.frame.size.height-50, self.imageView.frame.size.width/2, 50) ;
    }
    return _MotherTel;
}


- (UILabel *)missMessageLabel
{
    if(!_missMessageLabel)
    {
        NSString *str = @"某年某月某日，我的女儿小红，在人民广场与我走失，6岁，马尾辫，穿着宝红色上衣，白色裤子，她性格腼腆，不害羞内向，希望有心人看见了，能即时与我联系，不胜感激，好人一生平安";
        CGSize  size = [str boundingRectWithSize:CGSizeMake(self.imageView.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12],NSForegroundColorAttributeName : [UIColor grayColor]} context:nil].size;
        _missMessageLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,self.imageView.frame.size.height-50-size.height , self.imageView.frame.size.width, size.height)];
        _missMessageLabel.font = [UIFont systemFontOfSize:12];
        _missMessageLabel.text = str;
        _missMessageLabel.numberOfLines = 0;
        
    }
    return _missMessageLabel;
}


-(UIView *)footerView
{
    if (!_footerView)
    {
        //        CGFloat footerViewY = MAX(SCREEN_HEIGHT-61,self.notificationMessLab.frame.size.height+120);
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
        [_MTalkBtn addTarget:self action:@selector(pushTOPromised) forControlEvents:UIControlEventTouchUpInside];
    }
    return _MTalkBtn;
}

-(HCButtonItem *)messageBtn
{
    if (!_messageBtn)
    {
        _messageBtn=[[HCButtonItem alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3, 2, SCREEN_WIDTH/3-2, 44) WithImageName:@"Bubble_nor-2" WithImageWidth:30 WithImageHeightPercentInItem:.7 WithTitle:NSLocalizedString(@"留言", nil) WithFontSize:14 WithFontColor:OrangeColor WithGap:10];
        [_messageBtn addTarget:self action:@selector(ContactCustomerService) forControlEvents:UIControlEventTouchUpInside];
    }
    return _messageBtn;
}

-(HCButtonItem *)policeBtn
{
    if (!_policeBtn)
    {
        _policeBtn=[[HCButtonItem alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3*2, 2, SCREEN_WIDTH/3-2, 44) WithImageName:@"110" WithImageWidth:30 WithImageHeightPercentInItem:.7 WithTitle:NSLocalizedString(@"快速报警", nil) WithFontSize:14 WithFontColor:OrangeColor WithGap:10];
        [_policeBtn addTarget:self action:@selector(ContactWithPolice) forControlEvents:UIControlEventTouchUpInside];
    }
    return _policeBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
