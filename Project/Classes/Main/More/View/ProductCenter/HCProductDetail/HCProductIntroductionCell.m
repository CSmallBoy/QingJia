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


//@property (nonatomic,strong) UILabel *productNameLb;
////购买方式1
//@property (nonatomic,strong) UIButton *buyWayFirstBtn;
//@property (nonatomic,strong) UILabel *buyWayFirstlb;
//购买方式2
//@property (nonatomic,strong) UIButton *buyWaySecondBtn;
//@property (nonatomic,strong) UILabel *buyWaySecondLb;
//标签加减

/**烫印机个数label*/
@property (nonatomic,strong) UILabel* hotStampingMachineNumberLab;
/**增加烫印机个数按钮*/
@property (nonatomic,strong) UIButton *addHotStampingMachineNumBtn ;
/**烫印机购买个数数量*/
@property (nonatomic,strong) UILabel* hotStampingMachineBuyNumberLb;
/**减少烫印机个数按钮*/
@property (nonatomic,strong) UIButton *deleteHotStampingMachineBtn;
/**烫印机价格label*/
@property (nonatomic,strong) UILabel *hotStampingMachinePriceLab;
/**烫印机价格数量*/
@property (nonatomic,strong) UILabel *hotStampingMachinePriceNumLab;


//标签
/**标签张数label*/
@property (nonatomic,strong) UILabel *labelNumberLab;
/**增加标签张数按钮*/
@property (nonatomic,strong) UIButton *addLabelNumBtn ;
/**减少标签张数按钮*/
@property (nonatomic,strong) UIButton *deleteLabelBtn;
/**标签购买张数数量*/
@property (nonatomic,strong) UILabel *labelBuyNumberLb;
//价格
/**标签价格label*/
@property (nonatomic,strong) UILabel *labelPriceLab;
/**标签价格数量*/
@property (nonatomic,strong) UILabel *labelPriceNumLab;


/**总价格*/
@property (nonatomic,strong) UILabel *totalPriceLab;
/**总价格数量*/
@property (nonatomic,strong) UILabel *totalPriceNumLab;


@property (nonatomic,strong) UIButton *tmpBtn;


@property (nonatomic,assign)NSInteger Btntag;
@property(nonatomic,assign)BOOL BtnSelected;

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
        self.hotStampingMachineNumberLab.font = [UIFont systemFontOfSize:15];
        self.hotStampingMachinePriceLab.font = [UIFont systemFontOfSize:15];
        self.labelNumberLab.font = [UIFont systemFontOfSize:15];
        self.labelPriceLab.font = [UIFont systemFontOfSize:15];
        self.totalPriceLab.font = [UIFont systemFontOfSize:15];
        
        [self.contentView
         addSubview: self.hotStampingMachineNumberLab];
        [self.contentView
         addSubview: self.addHotStampingMachineNumBtn];
        [self.contentView
         addSubview: self.deleteHotStampingMachineBtn];
        [self.contentView
         addSubview: self.hotStampingMachineBuyNumberLb];
        [self.contentView
         addSubview: self.hotStampingMachinePriceLab];
        [self.contentView
         addSubview:self.hotStampingMachinePriceNumLab];
        
        [self.contentView addSubview: self.labelNumberLab];
        [self.contentView addSubview: self.addLabelNumBtn];
        [self.contentView addSubview: self.deleteLabelBtn];
        [self.contentView addSubview: self.labelBuyNumberLb];
        [self.contentView addSubview: self.labelPriceLab];
        [self.contentView addSubview:self.labelPriceNumLab];
        
        [self.contentView addSubview:self.totalPriceLab];
        [self.contentView addSubview:self.totalPriceNumLab];
    }
}

#pragma mark - private methods

-(void)clickAddHotStampingMachineBtn
{
    if (self.info.buyHotStampingMachineNumber <5)
    {
           self.info.buyHotStampingMachineNumber += 1;
    }
    else
    {
        if ([self.delegate respondsToSelector:@selector(showForbidHotStampingMachineAdd)])
        {
            [self.delegate showForbidHotStampingMachineAdd];
        }
    }
    self.hotStampingMachineBuyNumberLb.text = [NSString stringWithFormat:@"%d",self.info.buyHotStampingMachineNumber];
    self.hotStampingMachinePriceNumLab.text = [NSString stringWithFormat:@"%d元",self.info.buyHotStampingMachineNumber *self.info.hotStampingMachinePrice];
    self.totalPriceNumLab.text = [NSString stringWithFormat:@"%d元",self.info.hotStampingMachinePrice*self.info.buyHotStampingMachineNumber+self.info.labelPrice*self.info.buyLabelNumber];
}

-(void)clickDeleteHotStampingMachineBtn
{
    if (self.info.buyHotStampingMachineNumber > 0)
    {
        self.info.buyHotStampingMachineNumber -= 1;
    }else
    {
        if ([self.delegate respondsToSelector:@selector(showForbidHotStampingMachineDelete)])
        {
            [self.delegate showForbidHotStampingMachineDelete];

        }
    }
    self.hotStampingMachineBuyNumberLb.text = [NSString stringWithFormat:@"%d",self.info.buyHotStampingMachineNumber];
    self.hotStampingMachinePriceNumLab.text = [NSString stringWithFormat:@"%d元",self.info.buyHotStampingMachineNumber *self.info.hotStampingMachinePrice];
     self.totalPriceNumLab.text = [NSString stringWithFormat:@"%d元",self.info.hotStampingMachinePrice*self.info.buyHotStampingMachineNumber+self.info.labelPrice*self.info.buyLabelNumber];
}


-(void)clickAddLabelBtn
{
    if (self.info.buyLabelNumber < 50)
    {
         self.info.buyLabelNumber += 5;
    }
   else
   {
       if ([self.delegate respondsToSelector:@selector(showForbidLabelAdd)])
       {
           [self.delegate showForbidLabelAdd];
       }
   }
    self.labelBuyNumberLb.text = [NSString stringWithFormat:@"%d",self.info.buyLabelNumber];
    self.labelPriceNumLab.text = [NSString stringWithFormat:@"%d元",self.info.buyLabelNumber *self.info.labelPrice];
     self.totalPriceNumLab.text = [NSString stringWithFormat:@"%d元",self.info.hotStampingMachinePrice*self.info.buyHotStampingMachineNumber+self.info.labelPrice*self.info.buyLabelNumber];
}

-(void)clickDeleteLabelBtn
{
    if (self.info.buyLabelNumber > 10) {
        self.info.buyLabelNumber -= 1;
    }else
    {
        if ([self.delegate respondsToSelector:@selector(showForbidLabelDelete)]) {
            [self.delegate showForbidLabelDelete];
            
        }
    }
    
    self.labelBuyNumberLb.text = [NSString stringWithFormat:@"%d",self.info.buyLabelNumber];
    self.labelPriceNumLab.text = [NSString stringWithFormat:@"%d元",self.info.buyLabelNumber *self.info.labelPrice];
    self.totalPriceNumLab.text = [NSString stringWithFormat:@"%d元",self.info.hotStampingMachinePrice*self.info.buyHotStampingMachineNumber+self.info.labelPrice*self.info.buyLabelNumber];
    
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

-(UILabel *)hotStampingMachineNumberLab
{
    if (!_hotStampingMachineNumberLab)
    {
        _hotStampingMachineNumberLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 45)];
        _hotStampingMachineNumberLab.text = @"烫印机个数";
    }
    return _hotStampingMachineNumberLab;
}

-(UIButton *)deleteHotStampingMachineBtn
{
    if (!_deleteHotStampingMachineBtn)
    {
        _deleteHotStampingMachineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteHotStampingMachineBtn.frame = CGRectMake(110, 18,  30, 30);
        [_deleteHotStampingMachineBtn setBackgroundImage:OrigIMG(@"Products_but_minus") forState:UIControlStateNormal];
        [_deleteHotStampingMachineBtn addTarget:self action:@selector(clickDeleteHotStampingMachineBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteHotStampingMachineBtn;
}

-(UILabel *)hotStampingMachineBuyNumberLb
{
    if (!_hotStampingMachineBuyNumberLb)
    {
        _hotStampingMachineBuyNumberLb = [[UILabel alloc]initWithFrame:CGRectMake(140, 10, 55, 45)];
        _hotStampingMachineBuyNumberLb.textAlignment = NSTextAlignmentCenter;
    }
    return _hotStampingMachineBuyNumberLb;
}

-(UIButton *)addHotStampingMachineNumBtn
{
    if (!_addHotStampingMachineNumBtn)
    {
        _addHotStampingMachineNumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addHotStampingMachineNumBtn setBackgroundImage:OrigIMG(@"Products_but_Plus") forState:UIControlStateNormal];
        _addHotStampingMachineNumBtn.frame = CGRectMake(195, 18, 30, 30);
         [_addHotStampingMachineNumBtn addTarget:self action:@selector(clickAddHotStampingMachineBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addHotStampingMachineNumBtn;
}

-(UILabel *)hotStampingMachinePriceLab
{
    if (!_hotStampingMachinePriceLab)
    {
        _hotStampingMachinePriceLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 65, 100, 45)];
        _hotStampingMachinePriceLab.text = @"烫印机价格";
        _hotStampingMachinePriceLab.textAlignment= NSTextAlignmentLeft;
    }
    return _hotStampingMachinePriceLab;
}

-(UILabel *)hotStampingMachinePriceNumLab
{
    if (!_hotStampingMachinePriceNumLab) {
        _hotStampingMachinePriceNumLab = [[UILabel  alloc]initWithFrame:CGRectMake(110, 65, 120, 45)];
        _hotStampingMachinePriceNumLab.textAlignment = NSTextAlignmentLeft;
    }
    return _hotStampingMachinePriceNumLab;
}

-(UILabel *)labelNumberLab
{
    if (!_labelNumberLab)
    {
        _labelNumberLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 120, 100, 45)];
        _labelNumberLab.text = @"标签张数";
    }
    return _labelNumberLab;
}

-(UIButton *)deleteLabelBtn
{
    if (!_deleteLabelBtn) {
        _deleteLabelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteLabelBtn.frame = CGRectMake(110, 128, 30, 30);
        [_deleteLabelBtn setBackgroundImage:OrigIMG(@"Products_but_minus") forState:UIControlStateNormal];
        [_deleteLabelBtn addTarget:self action:@selector(clickDeleteLabelBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteLabelBtn;
}

-(UILabel *)labelBuyNumberLb
{
    if (!_labelBuyNumberLb)
    {
        _labelBuyNumberLb = [[UILabel alloc]initWithFrame:CGRectMake(140, 120, 55, 45)];
        _labelBuyNumberLb.textAlignment = NSTextAlignmentCenter;
    }
    return _labelBuyNumberLb;
}

-(UIButton *)addLabelNumBtn
{
    if (!_addLabelNumBtn)
    {
        _addLabelNumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addLabelNumBtn setBackgroundImage:OrigIMG(@"Products_but_Plus") forState:UIControlStateNormal];
        [_addLabelNumBtn addTarget:self action:@selector(clickAddLabelBtn) forControlEvents:UIControlEventTouchUpInside];
        _addLabelNumBtn.frame = CGRectMake(195, 128, 30, 30);
    }
    return _addLabelNumBtn;
}

-(UILabel *)labelPriceLab
{
    if (!_labelPriceLab)
    {
        _labelPriceLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 175, 100, 45)];
        _labelPriceLab.text = @"标签价格";
        _labelPriceLab.textAlignment= NSTextAlignmentLeft;
    }
    return _labelPriceLab;
}

-(UILabel *)labelPriceNumLab
{
    if (!_labelPriceNumLab) {
        _labelPriceNumLab = [[UILabel  alloc]initWithFrame:CGRectMake(110, 175, 100, 45)];
        _labelPriceNumLab.textAlignment = NSTextAlignmentLeft;
    }
    return _labelPriceNumLab;
}

-(UILabel *)totalPriceLab
{
    if (!_totalPriceLab) {
        _totalPriceLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 230, 100, 45)];
        _totalPriceLab.textAlignment = NSTextAlignmentLeft;
        _totalPriceLab.text = @"总价格";
    }
    return _totalPriceLab;
}

-(UILabel *)totalPriceNumLab
{
    if (!_totalPriceNumLab) {
        _totalPriceNumLab = [[UILabel alloc]initWithFrame:CGRectMake(110, 230, 100, 45)];
        _totalPriceNumLab.textAlignment = NSTextAlignmentLeft;
    }
    return _totalPriceNumLab;
}

-(void)setInfo:(HCProductIntroductionInfo *)info
{
    _info = info;
    _hotStampingMachineBuyNumberLb.text = [NSString stringWithFormat:@"%d" ,self.info.buyHotStampingMachineNumber];
    _hotStampingMachinePriceNumLab.text = [NSString stringWithFormat:@"%d元",self.info.hotStampingMachinePrice*self.info.buyHotStampingMachineNumber];
    _labelBuyNumberLb.text = [NSString stringWithFormat:@"%d",self.info.buyLabelNumber];
    _labelPriceNumLab.text = [NSString stringWithFormat:@"%d元",self.info.labelPrice*self.info.buyLabelNumber];
    _totalPriceNumLab.text = [NSString stringWithFormat:@"%d元",self.info.hotStampingMachinePrice*self.info.buyHotStampingMachineNumber+self.info.labelPrice*self.info.buyLabelNumber];
    
}
@end
