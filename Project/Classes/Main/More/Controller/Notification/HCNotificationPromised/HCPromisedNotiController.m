//
//  HCPromisedNotiController.m
//  Project
//
//  Created by 朱宗汉 on 16/1/30.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCPromisedNotiController.h"
#import "HCNotificationHeadImageController.h"
#import "HCPromisedCommentController.h"

#import "HCButtonItem.h"
@interface HCPromisedNotiController ()

@property (nonatomic,strong) UIButton   *headBtn;
@property (nonatomic,strong) UIImageView    *sexIV;
@property (nonatomic,strong) UILabel    *nameLabel;
@property (nonatomic,strong) UILabel    *ageLabel;
@property (nonatomic ,strong) UIImageView   *imageView;
@property (nonatomic,strong) UIButton   * FatherTel;
@property (nonatomic,strong) UIButton   * MotherTel;
@property (nonatomic,strong) UIButton   *foundBtn;
@property (nonatomic,strong) UILabel    *missMessageLabel;

@property (nonatomic,strong) UIView     *blackView;
@property (nonatomic,strong) UIView     *myAlertView;

@end

@implementation HCPromisedNotiController

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
    [self.view addSubview:self.foundBtn];

   
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

#pragma mark --- setter Or getter


- (UIButton *)headBtn
{
    if(!_headBtn){
        _headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _headBtn.frame = CGRectMake(SCREEN_WIDTH*0.35, 64 +20, SCREEN_WIDTH*0.3, SCREEN_WIDTH*0.3);
        ViewRadius(_headBtn, _headBtn.frame.size.width*0.5);
        [_headBtn addTarget:self action:@selector(headClick:) forControlEvents:UIControlEventTouchUpInside];
        _headBtn.layer.borderColor = [UIColor redColor].CGColor;
        _headBtn.layer.borderWidth = 3;
        [_headBtn setBackgroundImage:[UIImage imageNamed:@"label_Head-Portraits"] forState:UIControlStateNormal];
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
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.165, SCREEN_HEIGHT*0.35 +20, SCREEN_WIDTH*0.67, SCREEN_HEIGHT *0.54)];
        ViewRadius(_imageView, 5);
        _imageView.image = IMG(@"label_Head-Portraits");
        
        _imageView.userInteractionEnabled = YES;
        [_imageView addSubview:self.FatherTel];
        [_imageView addSubview:self.MotherTel];
        [_imageView addSubview:self.missMessageLabel];
        
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
