//
//  HCPayWayTableViewCell.m
//  Project
//
//  Created by 朱宗汉 on 15/12/19.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCPayWayTableViewCell.h"

@interface HCPayWayTableViewCell()

@property (nonatomic,strong) UIButton *tmpBtn;

//支付宝
@property (nonatomic,strong) UIButton *alipayBtn;
//微信支付
@property (nonatomic,strong) UIButton *weixinpayBtn;
//银联支付
@property (nonatomic,strong) UIButton *unionpayBtn;

//支付宝圆点
@property (nonatomic,strong) UIButton *alipayPointBtn;
//微信支付圆点
@property (nonatomic,strong) UIButton *weixinpayPointBtn;
//银联支付圆点
@property (nonatomic,strong) UIButton *unionpayPointBtn;

@end

@implementation HCPayWayTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        

    }
    return self;
}



#pragma mark----private methods

-(void)clickPayBtn:(UIButton* )sender
{
    if (sender.tag == 0) {
        self.alipayBtn.selected = YES;
        self.alipayPointBtn.selected = YES;
        self.weixinpayBtn.selected = NO;
        self.weixinpayPointBtn.selected = NO;
        self.unionpayBtn.selected = NO;
        self.unionpayPointBtn.selected = NO;
    }else if(sender.tag == 1)
    {
        self.alipayBtn.selected = NO;
        self.alipayPointBtn.selected = NO;
        self.weixinpayBtn.selected = YES;
        self.weixinpayPointBtn.selected = YES;
        self.unionpayBtn.selected = NO;
        self.unionpayPointBtn.selected = NO;
        
    }else
    {
        self.alipayBtn.selected = NO;
        self.alipayPointBtn.selected = NO;
        self.weixinpayBtn.selected = NO;
        self.weixinpayPointBtn.selected = NO;
        self.unionpayBtn.selected = YES;
        self.unionpayPointBtn.selected = YES;
    }
}



#pragma mark -----Setter Or Getter

-(void)setIndexPath:(NSIndexPath *)indexPath
{

    [self.contentView addSubview:self.alipayBtn];
    [self.contentView addSubview:self.weixinpayBtn];
    [self.contentView addSubview:self.unionpayBtn];
    
    [self.alipayBtn addSubview:self.alipayPointBtn];
    [self.weixinpayBtn addSubview:self.weixinpayPointBtn];
    [self.unionpayBtn addSubview:self.unionpayPointBtn];
}

-(UIButton *)alipayBtn
{
    if (!_alipayBtn) {
        _alipayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _alipayBtn.frame = CGRectMake(10, 10, SCREEN_WIDTH-20, 44);
        _alipayBtn.backgroundColor = CLEARCOLOR;
        [self.alipayBtn  setTitle:@"支付宝支付" forState:UIControlStateNormal];
        [self.alipayBtn  setTitle:@"支付宝支付" forState:UIControlStateSelected];
        self.alipayBtn.selected = YES;
        [self.alipayBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.alipayBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        _alipayBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        ViewBorderRadius(_alipayBtn, 0, 1, LightGraryColor);
        _alipayBtn.tag = 0;
        [_alipayBtn addTarget:self action:@selector(clickPayBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_alipayBtn addSubview:self.alipayPointBtn];
    }
    return _alipayBtn;
}

-(UIButton *)weixinpayBtn
{
    if (!_weixinpayBtn) {
        _weixinpayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _weixinpayBtn.frame = CGRectMake(10, 64, SCREEN_WIDTH-20, 44);
        _weixinpayBtn.backgroundColor = CLEARCOLOR;
        _weixinpayBtn.tag = 1;
        [self.weixinpayBtn  setTitle:@"微信支付" forState:UIControlStateNormal];
        [self.weixinpayBtn  setTitle:@"微信支付" forState:UIControlStateSelected];
        [self.weixinpayBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.weixinpayBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        _weixinpayBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        ViewBorderRadius(_weixinpayBtn, 0, 1, LightGraryColor);
        [_weixinpayBtn addTarget:self action:@selector(clickPayBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_weixinpayBtn addSubview:self.weixinpayPointBtn];
        
    }
    return _weixinpayBtn;
}

-(UIButton *)unionpayBtn
{
    if (!_unionpayBtn) {
        _unionpayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _unionpayBtn.frame = CGRectMake(10, 118, SCREEN_WIDTH-20, 44);
        _unionpayBtn.backgroundColor = CLEARCOLOR;
        [self.unionpayBtn  setTitle:@"银联支付" forState:UIControlStateNormal];
        [self.unionpayBtn  setTitle:@"银联支付" forState:UIControlStateSelected];
        self.unionpayBtn.tag = 2;
        [self.unionpayBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.unionpayBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        _unionpayBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        ViewBorderRadius(_unionpayBtn, 0, 1, LightGraryColor);
        [_unionpayBtn addTarget:self action:@selector(clickPayBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_unionpayBtn addSubview:self.unionpayPointBtn];
    }
    return _unionpayBtn;
}

-(UIButton *)alipayPointBtn
{
    if (!_alipayPointBtn) {
        _alipayPointBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _alipayPointBtn.frame = CGRectMake(0, 0, 44, 44);
        _alipayPointBtn.selected = YES;
        [_alipayPointBtn setBackgroundImage:OrigIMG(@"buttonNormal") forState: UIControlStateNormal];
        [_alipayPointBtn setBackgroundImage:OrigIMG(@"buttonSelected") forState:UIControlStateSelected];
        _alipayPointBtn.tag  = 0;
        [_alipayPointBtn addTarget:self action:@selector(clickPayBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _alipayPointBtn;
}

-(UIButton *)weixinpayPointBtn
{
    if (!_weixinpayPointBtn) {
        _weixinpayPointBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _weixinpayPointBtn.frame = CGRectMake(0, 0, 44, 44);
        [_weixinpayPointBtn setBackgroundImage:OrigIMG(@"buttonNormal") forState: UIControlStateNormal];
        [_weixinpayPointBtn setBackgroundImage:OrigIMG(@"buttonSelected") forState:UIControlStateSelected];
        _weixinpayPointBtn.tag = 1;
        [_weixinpayPointBtn addTarget:self action:@selector(clickPayBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _weixinpayPointBtn;
}

-(UIButton *)unionpayPointBtn
{
    if (!_unionpayPointBtn) {
        _unionpayPointBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _unionpayPointBtn.frame = CGRectMake(0, 0, 44, 44);
        [_unionpayPointBtn setBackgroundImage:OrigIMG(@"buttonNormal") forState: UIControlStateNormal];
        [_unionpayPointBtn setBackgroundImage:OrigIMG(@"buttonSelected") forState:UIControlStateSelected];
        _unionpayPointBtn.tag =2;
        [_unionpayPointBtn addTarget:self action:@selector(clickPayBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _unionpayPointBtn;
}


@end
