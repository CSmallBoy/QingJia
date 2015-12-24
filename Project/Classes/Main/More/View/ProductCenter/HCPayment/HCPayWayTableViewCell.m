//
//  HCPayWayTableViewCell.m
//  Project
//
//  Created by 朱宗汉 on 15/12/19.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCPayWayTableViewCell.h"

@interface HCPayWayTableViewCell()

@property (nonatomic,strong) NSArray *payWayArr;

@property (nonatomic,strong) UILabel *payLab;
@property (nonatomic,strong) UIButton *payButton;
@property (nonatomic,strong) UIView *payView;

@end
@implementation HCPayWayTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier

{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        

    }
    return self;
}

-(void)setIndexPath:(NSIndexPath *)indexPath
{
    self.payLab.text = self.payWayArr[indexPath.row];
    [self.contentView addSubview:self.payButton];
    [self.contentView addSubview:self.payView];
    [self.contentView addSubview:self.payLab];
}

-(UILabel *)payLab
{
    if (!_payLab) {
        _payLab = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, WIDTH(self), 40)];
        _payLab.font = [UIFont systemFontOfSize:14];
        _payLab.textColor = [UIColor blackColor];
    }
    return _payLab;
}

-(UIView *)payView
{
    if (!_payView) {
        _payView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 40)];
        _payView.backgroundColor = CLEARCOLOR;
        ViewBorderRadius(_payView, 0, 1, LightGraryColor);
    }
    return _payView;
}

-(UIButton *)payButton
{
    if (!_payButton) {
        _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _payButton;
}

-(NSArray *)payWayArr
{
    if (!_payWayArr) {
        _payWayArr = @[@"支付宝",@"微信支付",@"银联支付"];
        
    }
    return _payWayArr;
}
@end
