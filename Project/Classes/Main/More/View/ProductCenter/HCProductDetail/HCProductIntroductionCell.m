//
//  HCProductIntroductionCell.m
//  Project
//
//  Created by 朱宗汉 on 15/12/16.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCProductIntroductionCell.h"

@interface HCProductIntroductionCell()

@property (nonatomic,strong) UIScrollView *scrollView;


@property (nonatomic,strong) UILabel *productNameLb;
//购买方式1
@property (nonatomic,strong) UIButton *buyWayFirstBtn;
@property (nonatomic,strong) UILabel *buyWayFirstlb;
//购买方式2
@property (nonatomic,strong) UIButton *buyWaySecondBtn;
@property (nonatomic,strong) UILabel *buyWaySecondLb;
//加减
@property (nonatomic,strong) UILabel *numberLb;
@property (nonatomic,strong) UIButton *addBtn ;
@property (nonatomic,strong) UIButton *deleteBtn;
@property (nonatomic,strong) UILabel *buyNumberLb;
//价格
@property (nonatomic,strong) UILabel *priceLab;
@property (nonatomic,strong) UILabel *priceLb;
@property (nonatomic,strong) UIButton *tmpBtn;

@end

@implementation HCProductIntroductionCell

- (void)layoutSubviews
{
    [super layoutSubviews];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
    }
    return self;
}

#pragma mark---delegate

-(void)setIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        [self.contentView addSubview:self.scrollView];
    }else
    {
            _deleteBtn.tag = 11;
            _addBtn.tag = 12;
        
            [self.contentView addSubview: self.productNameLb];
            [self.contentView addSubview: self.buyWayFirstBtn];
            [self.contentView addSubview: self.buyWayFirstlb];
            [self.contentView addSubview: self.buyWaySecondBtn];
            [self.contentView addSubview: self.buyWaySecondLb];
      
        
            [self.contentView addSubview: self.numberLb];
            [self.contentView addSubview: self.addBtn];
            [self.contentView addSubview: self.buyNumberLb];
            [self.contentView addSubview: self.deleteBtn];
        
            [self.contentView addSubview: self.priceLab];
            [self.contentView addSubview: self.priceLb];
    }
}

#pragma mark - private methods

-(void)addBtnAction:(UIButton *)sender
{
    
}
-(void)deleteBtnAction:(UIButton *)sender
{
    
}

-(void)buyWayFirst
{
    DLog(@"购买方式1");
}

-(void)buyWaySecond
{
    DLog(@"购买方式1");
}

-(void)clickAddBtn
{
    self.info.buyNumber += 1;
    self.buyNumberLb.text = [NSString stringWithFormat:@"%d",self.info.buyNumber];
    self.priceLb.text = [NSString stringWithFormat:@"%d元",self.info.buyNumber*self.info.price];
}

-(void)clickDeleteBtn
{
    self.info.buyNumber -= 1;
    self.buyNumberLb.text = [NSString stringWithFormat:@"%d",self.info.buyNumber];
    self.priceLb.text = [NSString stringWithFormat:@"%d元",self.info.buyNumber*self.info.price];
       NSLog(@"%@",self.priceLb.text);
   
}

//购买方式的单选
-(void)buyWay:(UIButton*)sender
{
    if (_tmpBtn == nil)
    {
        sender.selected = YES;
        _tmpBtn = sender;
    }
    else if (_tmpBtn != nil && _tmpBtn == sender)
    {
        sender.selected = YES;
        
    }
    else if (_tmpBtn != sender&& _tmpBtn != nil)
    {
        _tmpBtn.selected = NO;
        sender.selected = YES;
        _tmpBtn = sender;
    }
}

#pragma mark-- Setter Or Getter
-(UIScrollView *)scrollView
{
    if (!_scrollView)
    {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
        _scrollView.bounces = NO;
        UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
        NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"http://www.baidu.com"]] ;
        
        [webView loadRequest:request];
        
        [self.scrollView addSubview:webView];
        
    }
    return _scrollView;
}

-(UILabel *)productNameLb
{
    if (!_productNameLb)
    {
        _productNameLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 50, 44)];
        _productNameLb.font = [UIFont systemFontOfSize:12];
    }
    return _productNameLb;
}

-(UIButton *)buyWayFirstBtn
{
    if (!_buyWayFirstBtn)
    {
        _buyWayFirstBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buyWayFirstBtn setBackgroundImage:OrigIMG(@"barItem-back") forState:UIControlStateSelected];
        [_buyWayFirstBtn setBackgroundImage:OrigIMG(@"more_test") forState:UIControlStateNormal];
        _buyWayFirstBtn.frame = CGRectMake(80, 5, 30, 30);
        [_buyWayFirstBtn addTarget:self action:@selector(buyWay:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyWayFirstBtn;
}

-(UILabel *)buyWayFirstlb
{
    if (!_buyWayFirstlb)
    {
        _buyWayFirstlb = [[UILabel alloc]initWithFrame:CGRectMake(115, 0,80, 44)];
        _buyWayFirstlb.text = self.info.buyWayFirst;
    }
    return _buyWayFirstlb;
}

-(UIButton *)buyWaySecondBtn
{
    if (!_buyWaySecondBtn)
    {
        _buyWaySecondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buyWaySecondBtn setBackgroundImage:OrigIMG(@"barItem-back") forState:UIControlStateSelected];
        [_buyWaySecondBtn setBackgroundImage:OrigIMG(@"more_test") forState:UIControlStateNormal];
        _buyWaySecondBtn.frame = CGRectMake(210, 5, 30, 30);
        [_buyWaySecondBtn addTarget:self action:@selector(buyWay:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyWaySecondBtn;
}

-(UILabel *)buyWaySecondLb
{
    if (!_buyWaySecondLb)
    {
        
        _buyWaySecondLb = [[UILabel alloc]initWithFrame:CGRectMake(245, 0,80, 44)];
        _buyWaySecondLb.text = self.info.buyWaySecond;
    }
    return _buyWaySecondLb;
}

-(UILabel *)numberLb
{
    if (!_numberLb)
    {
        _numberLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 44, 50, 45)];
        
        _numberLb.font = [UIFont systemFontOfSize:12];
        _numberLb.text = @"数量";
    }
    return _numberLb;
}

-(UIButton *)addBtn
{
    if (!_addBtn)
    {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setBackgroundImage:OrigIMG(@"more_test") forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(clickAddBtn) forControlEvents:UIControlEventTouchUpInside];
        _addBtn.frame = CGRectMake(150, 49,30, 30);
    }
    return _addBtn;
}

-(UILabel *)buyNumberLb
{
    if (!_buyNumberLb)
    {
        _buyNumberLb = [[UILabel alloc]initWithFrame:CGRectMake(115, 49, 30, 30)];
        _buyNumberLb.textAlignment= NSTextAlignmentCenter;
    }
    return _buyNumberLb;
}

-(UIButton *)deleteBtn
{
    if (!_deleteBtn)
    {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setBackgroundImage:OrigIMG(@"more_test") forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(clickDeleteBtn) forControlEvents:UIControlEventTouchUpInside];
        _deleteBtn.frame = CGRectMake(80, 49,30, 30);
    }
    return _deleteBtn;
}

-(UILabel *)priceLab
{
    if (!_priceLab)
    {
        _priceLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 83, 50, 45)];
        _priceLab.font = [UIFont systemFontOfSize:12];
        _priceLab.text = @"价格";
    }
    return _priceLab;
}

-(UILabel *)priceLb
{
    if (!_priceLb)
    {
        _priceLb = [[UILabel alloc]initWithFrame:CGRectMake(80, 83, SCREEN_WIDTH-100, 45)];
        _priceLb.text = [NSString stringWithFormat:@"%d",self.info.price];
    }
    return _priceLb;
}

-(void)setInfo:(HCProductIntroductionInfo *)info
{
    _info = info;
    _productNameLb.text = self.info.productName;
    _priceLb.text = [NSString stringWithFormat:@"%d元",self.info.price];
    _buyWayFirstlb.text = self.info.buyWayFirst;
    _buyWaySecondLb.text = self.info.buyWaySecond;
    _buyNumberLb.text = [NSString stringWithFormat:@"%d",self.info.buyNumber];
    _priceLb.text = [NSString stringWithFormat:@"%d元",self.info.buyNumber*self.info.price];
    
}


@end
