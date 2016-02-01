//
//  HCApplyReturnOrderCell.m
//  Project
//
//  Created by 朱宗汉 on 15/12/30.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCApplyReturnOrderCell.h"

#import "KWFormViewQuickBuilder.h"
#import "KWFormView.h"
#import "HCProductIntroductionInfo.h"

@interface HCApplyReturnOrderCell ()
/**
 *订单编号
 */
@property (nonatomic,strong) UILabel *orderIDLab;
/**
 *订单时间
 */
@property (nonatomic,strong) UILabel *orderTimeLab;
/**
 *灰线1
 */
@property (nonatomic,strong) UIView *lightViewOne;
/**
 *订购商品
 */
@property (nonatomic,strong) UILabel *orderGoodsNameLab;

@end

@implementation HCApplyReturnOrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        [self.contentView addSubview:self.orderIDLab];
        [self.contentView addSubview:self.orderTimeLab];
        [self.contentView addSubview:self.lightViewOne];
        [self.contentView addSubview:self.orderGoodsNameLab];
        
    }
    return self;
}



-(void)setInfo:(HCProductIntroductionInfo *)info
{
    _info= info;
    _orderIDLab.text = [NSString stringWithFormat:@"订单编号:%@",_info.orderID];
    _orderTimeLab.text = _info.orderTime;
    _orderGoodsNameLab.text = @"订购商品: M-Talk烫印机";
    
    
    KWFormViewQuickBuilder *builder = [[KWFormViewQuickBuilder alloc]init];
    [builder addRecord: @[@"数量",
                          @"价格",
                          @"订单状态"]];
    [builder addRecord:@[
                         [NSString stringWithFormat:@"%d",self.info.buyHotStampingMachineNumber],
                         [NSString stringWithFormat:@"%d",self.info.hotStampingMachinePrice],
                         @""]];
    CGFloat width = SCREEN_WIDTH*0.33;
    KWFormView *formView = [builder startCreatWithWidths:@[@(width), @(width), @(width)] startPoint:CGPointMake(0, 100)];
    
    NSString *orderStateStr ;
    if (self.info.orderState == 0)
    {
        orderStateStr = @"待付款";
    }
    else if(self.info.orderState == 1)
    {
        orderStateStr = @"订单已取消";
    }
    else if(self.info.orderState == 2)
    {
        orderStateStr = @"待发货";
    }
    else if(self.info.orderState == 3)
    {
        orderStateStr = @"已发货";
    }
    else if(self.info.orderState == 4)
    {
        orderStateStr = @"已签收";
    }
    UILabel  *orderStateLb = [[UILabel alloc] initWithFrame:CGRectMake(width*2,50, width,  50)];
    NSAttributedString *attriString = [[NSAttributedString alloc] initWithString: orderStateStr attributes:@{
                                                                                                             NSFontAttributeName: [UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor redColor]
                                                                                                             }];
    orderStateLb.attributedText = attriString;
    orderStateLb.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:formView];
    [formView addSubview:orderStateLb];
    
    
}

#pragma mark---private methods


#pragma mark---Setter Or Getter

-(UILabel *)orderIDLab
{
    if (!_orderIDLab)
    {
        _orderIDLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 180,50)];
        _orderIDLab.textAlignment = NSTextAlignmentLeft;
        _orderIDLab.font = [UIFont systemFontOfSize:14];
        _orderIDLab.textColor = [UIColor blackColor];
    }
    return _orderIDLab;
}

-(UILabel *)orderTimeLab
{
    if (!_orderTimeLab)
    {
        _orderTimeLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-140, 0, 130,50)];
        _orderTimeLab.textAlignment = NSTextAlignmentRight;
        _orderTimeLab.font = [UIFont systemFontOfSize:14];
        _orderTimeLab.textColor = [UIColor blackColor];
    }
    return _orderIDLab;
}

-(UIView *)lightViewOne
{
    if (!_lightViewOne)
    {
        _lightViewOne = [[UIView alloc]initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 0.25)];
        _lightViewOne.backgroundColor = LightGraryColor;
    }
    return _lightViewOne;
}

-(UILabel *)orderGoodsNameLab
{
    if (!_orderGoodsNameLab)
    {
        _orderGoodsNameLab = [[UILabel alloc]initWithFrame:CGRectMake(10,50 , SCREEN_WIDTH-10, 50)];
        _orderGoodsNameLab.textColor = [UIColor blackColor];
        _orderGoodsNameLab.font = [UIFont systemFontOfSize:14];
        _orderGoodsNameLab.textAlignment = NSTextAlignmentLeft;
    }
    return _orderGoodsNameLab;
}

@end
