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


@implementation HCCustomerTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
    }
    return self;
}

-(void)setIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0)
    {
        self.textLabel.text = @"订单编号：132380507";
        
        UILabel* timeLab = [[UILabel  alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-10, 50)];
        timeLab.text = @"2015-08-01 12:30";
        timeLab.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.textLabel];
        [self.contentView addSubview:timeLab];
    }else if(indexPath.row == 1)
    {
        self.textLabel.text = @"订购商品:M-Talk二维码（定制版）";
        [self.contentView addSubview:self.textLabel];
    }else
    {
        KWFormViewQuickBuilder *builder = [[KWFormViewQuickBuilder alloc]init];
        
        
        [builder addRecord: @[@"数量",@"价格",@"订单状态"]];
        [builder addRecord:@[@"1",@"88元",@""]];
        CGFloat width = SCREEN_WIDTH*0.33;
        KWFormView *formView = [builder startCreatWithWidths:@[@(width), @(width), @(width), @(width)] startPoint:CGPointMake(0, 0)];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        
        NSString *orderStateStr ;
        
        if (indexPath.section == 0)
        {
            orderStateStr = @"待审核";
        }else if (indexPath.section == 1)
        {
            orderStateStr = @"审核通过";
        }else if (indexPath.section == 2)
        {
            orderStateStr = @"审核不通过";
        }else if (indexPath.section == 3)
        {
            orderStateStr = @"退款成功";
        }
        else{
            orderStateStr = @"退款中";
        }
        
        UILabel  *orderStateLb = [[UILabel alloc] initWithFrame:CGRectMake(width*2,50, width,  50)];
        NSAttributedString *attriString = [[NSAttributedString alloc] initWithString: orderStateStr attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor redColor]}];
        orderStateLb.attributedText = attriString;
        orderStateLb.textAlignment = NSTextAlignmentCenter;
        
        
        [self.contentView addSubview:formView];
        [formView addSubview:orderStateLb];
        
    }
}



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

@end
