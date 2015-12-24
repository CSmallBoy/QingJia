//
//  HCLodisticsInfoTableViewCell.m
//  Project
//
//  Created by 朱宗汉 on 15/12/21.
//  Copyright © 2015年 com.xxx. All rights reserved.
//物流信息cell

#import "HCLogisticsInfoTableViewCell.h"
#import "KWFormViewQuickBuilder.h"
#import "KWFormView.h"
#import "HCLogisticsInfo.h"

@interface HCLogisticsInfoTableViewCell ()


@end

@implementation HCLogisticsInfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.textLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}


-(void)setIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        [self.contentView removeAllSubviews];
        if (indexPath.row == 0)
        {
            self.textLabel.text = @"订单编号:1231242143";
            UILabel *timeLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-300, 0, 290, 44)];
            timeLab.textAlignment = NSTextAlignmentRight;
            timeLab.text = @"2015-08-01 12:30";
            timeLab.font = [UIFont systemFontOfSize:14];
            [self.contentView addSubview:timeLab];
        }else if (indexPath.row == 1)
        {
            self.textLabel.text = @"订购商品: M-Talk二维码(定制版)";
        }else
        {
        KWFormViewQuickBuilder *builder = [[KWFormViewQuickBuilder alloc]init];
        [builder addRecord: @[@"数量",@"价格",@"订单状态"]];
        [builder addRecord:@[@"1",@"88元",@""]];
        CGFloat width = SCREEN_WIDTH*0.33;
        KWFormView *formView = [builder startCreatWithWidths:@[@(width), @(width), @(width), @(width)] startPoint:CGPointMake(0, 0)];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        
        NSString *orderStateStr ;
            orderStateStr = @"已发货";
      
        UILabel  *orderStateLb = [[UILabel alloc] initWithFrame:CGRectMake(width*2,50, width,  50)];
        NSAttributedString *attriString = [[NSAttributedString alloc] initWithString: orderStateStr attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor redColor]}];
        orderStateLb.attributedText = attriString;
        orderStateLb.textAlignment = NSTextAlignmentCenter;
        
        
        [self.contentView addSubview:formView];
        [formView addSubview:orderStateLb];
        }
    }
 
}



@end
