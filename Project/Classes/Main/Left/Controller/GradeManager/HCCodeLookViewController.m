//
//  HCCodeLookViewController.m
//  Project
//
//  Created by 陈福杰 on 16/2/24.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCCodeLookViewController.h"
#import "HCShareViewController.h"
#import "KMQRCode.h"
#import "UIImage+RoundedRectImage.h"

#import "HCCreateGradeInfo.h"

@interface HCCodeLookViewController ()

@property (nonatomic, strong) UIBarButtonItem *rightItem;

@property (nonatomic, strong) UIView *grayView;
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIImageView *classImgView;
@property (nonatomic, strong) UILabel *classTitle;
@property (nonatomic, strong) UILabel *classSingle;

@property (nonatomic, strong) UIImageView *codeImgView;
@property (nonatomic,strong) HCCreateGradeInfo *info;


@end

@implementation HCCodeLookViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupBackItem];
    self.title = @"家庭二维码";
    
    self.info = self.data[@"info"];
    [self.view addSubview:self.grayView];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Share_QrCode"] style:UIBarButtonItemStylePlain target:self action:@selector(barClick)];
    self.navigationItem.rightBarButtonItem = bar;
    
    [self createCode];
    
}
- (void)barClick{
    HCShareViewController *vc = [[HCShareViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
    
}
#pragma mark - private methods

- (void)handleTap:(UITapGestureRecognizer *)tap
{
    CGPoint tapPoint = [tap locationInView:self.grayView];
    if (!CGRectContainsPoint(self.contentView.frame, tapPoint))
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)createCode
{
    NSString *source = [HCAccountMgr manager].loginInfo.createFamilyId;
    
    //使用iOS 7后的CIFilter对象操作，生成二维码图片imgQRCode（会拉伸图片，比较模糊，效果不佳）
    CIImage *imgQRCode = [KMQRCode createQRCodeImage:source];
    
    //使用核心绘图框架CG（Core Graphics）对象操作，进一步针对大小生成二维码图片imgAdaptiveQRCode（图片大小适合，清晰，效果好）
    UIImage *imgAdaptiveQRCode = [KMQRCode resizeQRCodeImage:imgQRCode
                                                    withSize:self.view.frame.size.width];
    
    //默认产生的黑白色的二维码图片；我们可以让它产生其它颜色的二维码图片，例如：蓝白色的二维码图片
    imgAdaptiveQRCode = [KMQRCode specialColorImage:imgAdaptiveQRCode
                                            withRed:0
                                              green:0
                                               blue:0]; //0~255
    
    //使用核心绘图框架CG（Core Graphics）对象操作，创建带圆角效果的图片
    UIImage *imgIcon = [UIImage createRoundedRectImage:[UIImage imageNamed:@"mtalklogo"]
                                              withSize:CGSizeMake(60.0, 60.0)
                                            withRadius:10];
    
    //使用核心绘图框架CG（Core Graphics）对象操作，合并二维码图片和用于中间显示的图标图片
    imgAdaptiveQRCode = [KMQRCode addIconToQRCodeImage:imgAdaptiveQRCode
                                              withIcon:imgIcon
                                          withIconSize:imgIcon.size];
    
    self.codeImgView.image = imgAdaptiveQRCode;
}

- (void)handleRightItem
{
    
}

#pragma mark - setter or getter

- (UIBarButtonItem *)rightItem
{
    if (!_rightItem)
    {
        _rightItem = [[UIBarButtonItem alloc] initWithImage:OrigIMG(@"") style:UIBarButtonItemStylePlain target:self action:@selector(handleRightItem)];
    }
    return _rightItem;
}

- (UIView *)grayView
{
    if (!_grayView)
    {
        _grayView = [[UIView alloc] initWithFrame:self.view.frame];
        _grayView.backgroundColor = RGBA(0, 0, 0, 0.7);
        [_grayView addSubview:self.contentView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [_grayView addGestureRecognizer:tap];
    }
    return _grayView;
}

- (UIView *)contentView
{
    if (!_contentView)
    {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(15,150/667.0*SCREEN_HEIGHT, WIDTH(self.view)-30, WIDTH(self.view))];
    
        _contentView.backgroundColor = [UIColor whiteColor];
        ViewRadius(_contentView, 5);
        
        [self.contentView addSubview:self.classImgView];
        [self.contentView addSubview:self.classTitle];
        [self.contentView addSubview:self.classSingle];
        [self.contentView addSubview:self.codeImgView];
    }
    return _contentView;
}

- (UIImageView *)classImgView
{
    if (!_classImgView)
    {
        _classImgView = [[UIImageView alloc] initWithFrame:CGRectMake(25, 15, WIDTH(self.contentView)*0.3, WIDTH(self.view)*0.16)];
        _classImgView.image = self.data[@"image"];
        ViewRadius(_classImgView, 3);
    }
    return _classImgView;
}

- (UILabel *)classTitle
{
    if (!_classTitle)
    {
        _classTitle = [[UILabel alloc] initWithFrame:CGRectMake(MaxX(self.classImgView)+10, 20, WIDTH(self.contentView)-WIDTH(self.classImgView), 20)];
        _classTitle.text = [NSString stringWithFormat:@"%@家庭",self.info.familyNickName];
        _classTitle.font = [UIFont systemFontOfSize:15];
        _classTitle.textColor = DarkGrayColor;
    }
    return _classTitle;
}

- (UILabel *)classSingle
{
    if (!_classSingle)
    {
        _classSingle = [[UILabel alloc] initWithFrame:CGRectMake(MinX(self.classTitle), MaxY(self.classTitle)+5, WIDTH(self.classTitle), 20)];
        _classSingle.textColor = DarkGrayColor;
        _classSingle.text = self.info.familyDescription;
        _classSingle.font = [UIFont systemFontOfSize:12];
    }
    return _classSingle;
}
//二维码  的大小
- (UIImageView *)codeImgView
{
    if (!_codeImgView)
    {
        _codeImgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.classImgView.frame.origin.x, MaxY(self.classImgView)+10, WIDTH(self.contentView)-50, WIDTH(self.contentView)-50)];
    }
    return _codeImgView;
}

@end
