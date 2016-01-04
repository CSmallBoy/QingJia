//
//  HCBuyRecordTableViewCell.m
//  Project
//
//  Created by 朱宗汉 on 15/12/19.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCBuyRecordTableViewCell.h"
#import "KWFormViewQuickBuilder.h"
#import "KWFormView.h"
#import "HCProductIntroductionInfo.h"

@interface HCBuyRecordTableViewCell ()
/**
 *订单编号
 */
@property (nonatomic,strong) UILabel *orderIDLab;
/**
 * 时间
 */
@property (nonatomic,strong) UILabel *timeLab;
/**
 *订购商品
 */
@property (nonatomic,strong) UILabel *orderGoods;
/**
 *商品1（标签）
 */
@property (nonatomic,strong) UILabel *goodsOne;
/**
 *灰线1
 */
@property (nonatomic,strong) UIView *lineViewOne;
/**
 *商品2(烫印机)
 */
@property (nonatomic,strong) UILabel *goodsTwo;
/**
 *灰线2
 */
@property (nonatomic,strong) UIView *lineViewTwo;
/**
 *申请补发
 */
@property (nonatomic,strong) UIButton *applyReissueBtn;
/**
 *申请退货
 */
@property (nonatomic,strong) UIButton *applyReturnBtn;

@end
@implementation HCBuyRecordTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
  
        [self.contentView addSubview:self.orderIDLab];
        [self.contentView addSubview:self.timeLab];
        [self.contentView addSubview:self.orderGoods];
        [self.contentView addSubview:self.goodsOne];
        [self.contentView addSubview:self.goodsTwo];
        [self.contentView addSubview:self.lineViewOne];
        [self.contentView addSubview:self.lineViewTwo];
    }
    return self;
}

#pragma mark---private methods

-(void)clickApplyReissueBtn
{
    if ([self.delegate respondsToSelector:@selector(handleApplyReissue:)])
    {
        [self.delegate handleApplyReissue:_info];
    }
}

-(void)clickApplyReturnBtn
{
    if ([self.delegate respondsToSelector:@selector(handleApplyReturn:)])
    {
        [self.delegate handleApplyReturn:_info];
    }
}

#pragma mark---Setter Or Getter

-(void)setInfo:(HCProductIntroductionInfo *)info
{
    _info = info;
    self.orderIDLab.text = [NSString stringWithFormat:@"订单编号: %@",self.info.orderID];
    self.timeLab.text = self.info.orderTime;
    self.goodsOne.text = @"M-Talk二维码（定制版）";
    self.goodsTwo.text = @"M-Talk二维码（定制版）";
}

-(void)setIndexPath:(NSIndexPath *)indexPath
{
        KWFormViewQuickBuilder *builder = [[KWFormViewQuickBuilder alloc]init];
        [builder addRecord: @[@"标签张数",
                              @"烫印机个数",
                              @"订单总价",
                              @"订单状态"]];
        [builder addRecord:@[
                             [NSString stringWithFormat:@"%d",self.info.buyLabelNumber],
                             [NSString stringWithFormat:@"%d",self.info.buyHotStampingMachineNumber],
                             [NSString stringWithFormat:@"%d",self.info.totalPrice],
                             @""]];
        CGFloat width = SCREEN_WIDTH*0.25;
        KWFormView *formView = [builder startCreatWithWidths:@[@(width), @(width), @(width), @(width)] startPoint:CGPointMake(0, 150)];
        
        NSString *orderStateStr ;
        if (self.info.orderState == 0) {
            orderStateStr = @"待付款";
        }else if(self.info.orderState == 1)
        {
            orderStateStr = @"订单已取消";
        }else if(self.info.orderState == 2)
        {
            orderStateStr = @"待发货";
        }else if(self.info.orderState == 3)
        {
            orderStateStr = @"已发货";
        }else if(self.info.orderState == 4)
        {
            orderStateStr = @"已签收";
            [self.contentView addSubview:self.applyReissueBtn];
            [self.contentView addSubview:self.applyReturnBtn];
        }
        UILabel  *orderStateLb = [[UILabel alloc] initWithFrame:CGRectMake(width*3,50, width,  50)];
        NSAttributedString *attriString = [[NSAttributedString alloc] initWithString: orderStateStr attributes:@{
                                                                                    NSFontAttributeName: [UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor redColor]
                                                                                                        }];
        orderStateLb.attributedText = attriString;
        orderStateLb.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:formView];
        [formView addSubview:orderStateLb];
    
}


-(UILabel *)orderIDLab
{
    if (!_orderIDLab)
    {
        _orderIDLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 160,50)];
        _orderIDLab.textAlignment = NSTextAlignmentLeft;
        _orderIDLab.font = [UIFont systemFontOfSize:14];
    }
    return _orderIDLab;
}

-(UILabel *)timeLab
{
    if (!_timeLab )
    {
        _timeLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-150, 0, 140, 50)];
        _timeLab.font = [UIFont systemFontOfSize:14];
        _timeLab.textAlignment = NSTextAlignmentRight;
    }
    return _timeLab;
}

-(UILabel *)orderGoods
{
    if (!_orderGoods)
    {
        _orderGoods = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, 70, 50)];
        _orderGoods.text = @"订购商品";
        _orderGoods.font = [UIFont systemFontOfSize:14];
    }
    return _orderGoods;
}

-(UIView *)lineViewOne
{
    if (!_lineViewOne)
    {
        _lineViewOne = [[UIView alloc]initWithFrame:CGRectMake(80, 50, SCREEN_WIDTH-80, 0.5)];
        _lineViewOne.backgroundColor = LightGraryColor;
    }
    return _lineViewOne;
}

-(UILabel *)goodsOne
{
    if (!_goodsOne)
    {
        _goodsOne = [[UILabel alloc]initWithFrame:CGRectMake(80, 50, 160, 50)];
        _goodsOne.textAlignment = NSTextAlignmentLeft;
        _goodsOne.font = [UIFont systemFontOfSize:14];
    }
    return _goodsOne;
}

-(UIButton *)applyReissueBtn
{
    if (!_applyReissueBtn) {
        _applyReissueBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-120,50 , 110, 50)];
        [_applyReissueBtn setTitle:@"申请补货" forState:UIControlStateNormal];
        _applyReissueBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        _applyReissueBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_applyReissueBtn setTitleColor: [UIColor redColor]forState:UIControlStateNormal] ;
        [_applyReissueBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 50, 0, 0)];
        [_applyReissueBtn addTarget:self action:@selector(clickApplyReissueBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _applyReissueBtn;
}

-(UIView *)lineViewTwo
{
    if (!_lineViewTwo) {
        _lineViewTwo = [[UIView alloc]initWithFrame:CGRectMake(80, 100, SCREEN_WIDTH-80, 0.5)];
        _lineViewTwo.backgroundColor = LightGraryColor;
    }
    return _lineViewTwo;
}

-(UILabel *)goodsTwo
{
    if (!_goodsTwo)
    {
        _goodsTwo = [[UILabel alloc]initWithFrame:CGRectMake(80, 100, 160, 50)];
        _goodsTwo.textAlignment = NSTextAlignmentLeft;
        _goodsTwo.font = [UIFont systemFontOfSize:14];
    }
    return _goodsTwo;
}

-(UIButton *)applyReturnBtn
{
    if (!_applyReturnBtn) {
        _applyReturnBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-120,100 , 110, 50)];
        [_applyReturnBtn setTitle:@"申请退货" forState:UIControlStateNormal];
        [_applyReturnBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 50, 0, 0)];
        _applyReturnBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_applyReturnBtn setTitleColor: [UIColor redColor]forState:UIControlStateNormal];
        [_applyReturnBtn addTarget:self action:@selector(clickApplyReturnBtn) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _applyReturnBtn;
}

@end
