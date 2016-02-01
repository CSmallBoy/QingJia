//
//  HCCustomerTableViewCell.m
//  Project
//
//  Created by 朱宗汉 on 15/12/19.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCCustomerTableViewCell.h"
#import "KWFormViewQuickBuilder.h"
#import "KWFormView.h"
#import "HCCustomerInfo.h"

@interface HCCustomerTableViewCell ()

/**
 *订单编号
 */
@property (nonatomic,strong) UILabel *orderIDLab;
/**
 *订单时间
 */
@property (nonatomic,strong) UILabel *orderTimeLab;
/**
 *补/退货商品
 */
@property (nonatomic,strong) UILabel *goodsNameLab;

/**
 *订单状态
 */
@property (nonatomic,strong) UILabel *orderCustomerStateLab;

/**
 *表格
 */
@property (nonatomic,strong) KWFormView *formView;

/**
 *灰线
 */
@property (nonatomic,strong) UIView *lineView;

@end

@implementation HCCustomerTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self.contentView addSubview:self.orderIDLab];
        [self.contentView addSubview:self.orderTimeLab];
        [self.contentView addSubview:self.goodsNameLab];
        [self.contentView addSubview:self.lineView];
    }
    return self;
}

#pragma mark---Setter  Or Getter

-(void)setInfo:(HCCustomerInfo *)info
{
    _info = info;
    self.orderIDLab.text = [NSString stringWithFormat:@"订单编号:%@",self.info.orderID ];
    self.orderTimeLab.text = [NSString stringWithFormat:@"%@",self.info.orderTime];
    
    if ([self.info.goodsName integerValue] == 1)
    {
        self.goodsNameLab.text = [NSString stringWithFormat:@"补货商品:M-Talk二维码"];//,self.info.goodsName];
    }else
    {
        self.goodsNameLab.text = [NSString stringWithFormat:@"退货商品:M-Talk烫印机"];
    }
   
}

-(void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    KWFormViewQuickBuilder *builder = [[KWFormViewQuickBuilder alloc]init];
    NSString *orderNum ;
    NSString *needNum ;
    if ([self.info.goodsName integerValue] == 1)
    {
        orderNum = @"订单张数";
        needNum = @"补货张数";
    }
    else
    {
        orderNum = @"订单个数";
        needNum = @"退货个数";
    }// self.info.goodsNeedNumb,
        [builder addRecord: @[
                              orderNum,
                             needNum,
                              @"订单总价",
                              @"订单状态"]];
        [builder addRecord:@[
                             self.info.detailOrderGoodsNum,
                             self.info.detailNeedGoodsNum,
                             self.info.orderTotalPrice,
                             @""]];
    CGFloat width = SCREEN_WIDTH*0.25;
    _formView = [builder startCreatWithWidths:@[@(width), @(width), @(width), @(width)] startPoint:CGPointMake(0, 100)];
    [self.contentView addSubview:self.formView];
    
        NSString *orderStateStr ;
        if (self.info.orderCustomerState == 0)
        {
            orderStateStr = @"待审核";
        }else if(self.info.orderCustomerState == 1)
        {
            orderStateStr = @"审核通过";
        }else if(self.info.orderCustomerState == 2)
        {
            orderStateStr = @"审核不通过";
        }else if(self.info.orderCustomerState == 3)
        {
            orderStateStr = @"退款成功";
        }
        UILabel  *orderStateLb = [[UILabel alloc] initWithFrame:CGRectMake(width*3,50, width,  50)];
        NSAttributedString *attriString = [[NSAttributedString alloc] initWithString: orderStateStr attributes:@{
                                                                                                                 NSFontAttributeName: [UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor redColor]
                                                                                                                 }];
        orderStateLb.attributedText = attriString;
        orderStateLb.textAlignment = NSTextAlignmentCenter;
     [_formView addSubview:orderStateLb];
    
}


-(UILabel *)orderIDLab
{
    if (!_orderIDLab)
    {
        _orderIDLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 160, 50)];
        _orderIDLab.textAlignment = NSTextAlignmentLeft;
        _orderIDLab.font = [UIFont systemFontOfSize:14];
    }
    return _orderIDLab;
}

-(UILabel *)orderTimeLab
{
    if (!_orderTimeLab )
    {
        _orderTimeLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-150, 0, 140, 50)];
        _orderTimeLab.font = [UIFont systemFontOfSize:14];
        _orderTimeLab.textAlignment = NSTextAlignmentRight;
    }
    return _orderTimeLab;
}

-(UILabel *)goodsNameLab
{
    if (!_goodsNameLab )
    {
        _goodsNameLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, SCREEN_WIDTH-20, 50)];
        _goodsNameLab.font = [UIFont systemFontOfSize:14];
        _goodsNameLab.textAlignment = NSTextAlignmentLeft;
    }
    return _goodsNameLab;
}

-(UIView *)lineView
{
    if (!_lineView)
    {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 0.5)];
        _lineView.backgroundColor = LightGraryColor;
    }
    return _lineView;
}

#pragma mark--Private method

@end
