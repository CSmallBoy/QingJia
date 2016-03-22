//
//  HCShopingCarCell.m
//  Project
//
//  Created by 朱宗汉 on 16/3/22.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCShopingCarCell.h"
#import "HCMtalkShopingInfo.h"

@interface HCShopingCarCell ()
@property (nonatomic,strong) UIImageView *headIV ;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIButton *flogBtn;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UIView *segmentView;
@property (nonatomic,strong) UILabel *label;
@end

@implementation HCShopingCarCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
     static NSString *ID  = @"shopingCarCellID";
    
    HCShopingCarCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[HCShopingCarCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell addSubviews];
    }
    return cell;
    
}

-(void)addSubviews
{
    for (UIView *view in self.subviews)
    {
        [view removeFromSuperview];
    }
    
    [self addSubview:self.flogBtn];
    [self addSubview:self.headIV];
    [self addSubview:self.titleLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.segmentView];
}


#pragma mark --- getter or setter

-(void)setInfo:(HCMtalkShopingInfo *)info
{
    _info = info;
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:self.info.title];
    [attStr addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName :[UIFont systemFontOfSize:17]} range:NSMakeRange(0, 3)];
    self.titleLabel.attributedText = attStr;
    
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@元",info.price];

    if (info.isSelect) {
        [self.flogBtn setBackgroundImage:IMG(@"buttonSelected") forState:UIControlStateNormal];
    }
    else
    {
    [_flogBtn setBackgroundImage:IMG(@"buttonNormal") forState:UIControlStateNormal];
    }
    
}


- (UIImageView *)headIV
{
    if(!_headIV){
        _headIV = [[UIImageView alloc]initWithFrame:CGRectMake(50, 10, 80, 80)];
        _headIV.image = IMG(@"1");
    }
    return _headIV;
}


- (UILabel *)titleLabel
{
    if(!_titleLabel){
        _titleLabel= [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.headIV.frame) + 10, 10, SCREEN_WIDTH-150, 40)];
        _titleLabel.textColor = [UIColor lightGrayColor];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}


- (UILabel *)priceLabel
{
    if(!_priceLabel){
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.headIV.frame) + 10, 60, 60, 30)];
        _priceLabel.textColor = [UIColor blackColor];
    }
    return _priceLabel;
}


- (UIButton *)flogBtn
{
    if(!_flogBtn){
        _flogBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _flogBtn.frame = CGRectMake(10,30, 30, 30);
        [_flogBtn setBackgroundImage:IMG(@"buttonNormal") forState:UIControlStateNormal];
        
    }
    return _flogBtn;
}


- (UIView *)segmentView
{
    if(!_segmentView){
        _segmentView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-140, 50, 120, 30)];
        _segmentView.layer.borderWidth = 1;
        _segmentView.layer.borderColor = kHCBackgroundColor.CGColor;
        
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [button1 setTitle:@"-" forState:UIControlStateNormal];
        [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button1.layer.borderWidth = 1;
        [button1 addTarget:self action:@selector(minusNum) forControlEvents:UIControlEventTouchUpInside];
        button1.frame = CGRectMake(0, 0, 40, 30);
        
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, 40, 30)];
        self.label.text =@"1";
        self.label.textColor = [UIColor blackColor];
        self.label.textAlignment = NSTextAlignmentCenter;
        
        UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
        [button3 setTitle:@"+" forState:UIControlStateNormal];
        [button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button3 addTarget:self action:@selector(addNum) forControlEvents:UIControlEventTouchUpInside];
        button3.layer.borderWidth =1;
        button3.frame = CGRectMake(80, 0, 40, 30);
        
        [_segmentView addSubview:button1];
        [_segmentView  addSubview:self.label];
        [_segmentView addSubview:button3];
   
    }
    return _segmentView;
}


-(void)minusNum
{
    NSInteger num = [self.label.text integerValue];
    
    if (num==1) {
        return;
    }
    num = num - 1;
    self.info.allPrice = [NSString stringWithFormat:@"%2lf",[self.info.price floatValue] * num];
    self.label.text = [NSString stringWithFormat:@"%ld",num];
}

-(void)addNum
{
    NSInteger num = [self.label.text integerValue];
    num = num+1;
    self.info.allPrice = [NSString stringWithFormat:@"%.2lf",[self.info.price floatValue] * num];
    self.label.text = [NSString stringWithFormat:@"%ld",num];
    
}


@end
