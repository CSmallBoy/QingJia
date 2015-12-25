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
 *灰线
 */
@property (nonatomic,strong) UIView *lineView;
/**
 *商品2(烫印机)
 */
@property (nonatomic,strong) UILabel *goodsTwo;



@end
@implementation HCBuyRecordTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
       
    }
    return self;
}

#pragma mark---private methods

-(NSMutableAttributedString *)changeStringColorAndFontWithStart:(NSString *)start smallString:(NSString *)smallStr end:(NSString *)end
{
    NSMutableAttributedString *startString = [[NSMutableAttributedString alloc] initWithString:start];
    
    NSMutableAttributedString *smallString = [[NSMutableAttributedString alloc] initWithString:smallStr];
    [smallString addAttributes:@{NSForegroundColorAttributeName: [UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:10]} range:NSMakeRange(0, smallStr.length)];
    
    
    NSMutableAttributedString *endString= [[NSMutableAttributedString alloc] initWithString:end];
    
    [startString appendAttributedString:smallString];
    [startString appendAttributedString:endString];
    return startString;
}

#pragma mark---Setter Or Getter

-(void)setIndexPath:(NSIndexPath *)indexPath
{
    self.textLabel.font = [UIFont systemFontOfSize:14];
    if (indexPath.row == 0)
    {
        self.orderIDLab.text = [NSString stringWithFormat:@"订单编号: %@",self.info.orderID];
        self.timeLab.text = self.info.orderTime;
        
        [self.contentView addSubview:self.orderIDLab];
        [self.contentView addSubview:self.timeLab];
    }else if(indexPath.row == 1)
    {
        self.goodsOne.text = @"M-Talk二维码（定制版）";
        self.goodsTwo.text = @"M-Talk二维码（定制版）";
        [self.contentView addSubview:self.orderGoods];
        [self.contentView addSubview:self.goodsOne];
        [self.contentView addSubview:self.goodsTwo];
        [self.contentView addSubview:self.lineView];
        
    }else
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
        KWFormView *formView = [builder startCreatWithWidths:@[@(width), @(width), @(width), @(width)] startPoint:CGPointMake(0, 0)];
        
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
}


-(UILabel *)orderIDLab
{
    if (!_orderIDLab)
    {
        _orderIDLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 160,44)];
        _orderIDLab.textAlignment = NSTextAlignmentLeft;
        _orderIDLab.font = [UIFont systemFontOfSize:14];
    }
    return _orderIDLab;
}

-(UILabel *)timeLab
{
    if (!_timeLab )
    {
        _timeLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-150, 0, 140, 44)];
        _timeLab.font = [UIFont systemFontOfSize:14];
        _timeLab.textAlignment = NSTextAlignmentRight;
    }
    return _timeLab;
}

-(UILabel *)orderGoods
{
    if (!_orderGoods)
    {
        _orderGoods = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 70, 44)];
        _orderGoods.text = @"订购商品";
        _orderGoods.font = [UIFont systemFontOfSize:14];
    }
    return _orderGoods;
}

-(UILabel *)goodsOne
{
    if (!_goodsOne)
    {
        _goodsOne = [[UILabel alloc]initWithFrame:CGRectMake(80, 0, 160, 44)];
        _goodsOne.textAlignment = NSTextAlignmentLeft;
        _goodsOne.font = [UIFont systemFontOfSize:14];
    }
    return _goodsOne;
}

-(UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(80, 44, SCREEN_WIDTH-80, 0.5)];
        _lineView.backgroundColor = LightGraryColor;
    }
    return _lineView;
}

-(UILabel *)goodsTwo
{
    if (!_goodsTwo)
    {
        _goodsTwo = [[UILabel alloc]initWithFrame:CGRectMake(80, 44, 160, 44)];
        _goodsTwo.textAlignment = NSTextAlignmentLeft;
        _goodsTwo.font = [UIFont systemFontOfSize:14];
    }
    return _goodsTwo;
}

@end
