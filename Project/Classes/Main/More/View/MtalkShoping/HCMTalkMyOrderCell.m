//
//  HCMTalkMyOrderCell.m
//  Project
//
//  Created by 朱宗汉 on 16/3/17.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCMTalkMyOrderCell.h"
#import "HCMtalkMyOrderInfo.h"


@interface HCMTalkMyOrderCell ()
@property (nonatomic,strong) UIImageView * titleIV;
@property (nonatomic,strong) UILabel  * titleLabel;

@property (nonatomic,strong) UIView  *grayLine;

@property (nonatomic,strong) UILabel  *priceLabel;
@property (nonatomic,strong) UIButton  *chooseBtn;
@property (nonatomic,strong) UIButton  *againBtn;

@end

@implementation HCMTalkMyOrderCell

+(instancetype)cellWithTable:(UITableView *)tableView
{
    static NSString *ID = @"M-TalkMyOrderCell";
    
    HCMTalkMyOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell =[[HCMTalkMyOrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell addSubviews];
    }
    
    return cell;
}

-(void)addSubviews
{
    
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    [self addSubview:self.titleIV];
    [self addSubview:self.titleLabel];
    [self addSubview:self.grayLine];
    [self addSubview:self.priceLabel];
    [self addSubview:self.chooseBtn];
    [self addSubview:self.againBtn];
    
  
}

#pragma mark --- setter Or getter


-(void)setInfo:(HCMtalkMyOrderInfo *)info
{
    _info = info;
    
    self.titleLabel.font = [UIFont systemFontOfSize:13];
    self.titleLabel.textColor = [UIColor grayColor];
    
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc]initWithString:info.title ];
    [attStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange(0, 3)];
    self.titleLabel.attributedText = attStr;
    
    self.priceLabel.text = [NSString stringWithFormat:@"实付款：%@",info.price];
    
    [self.chooseBtn setTitle:info.doWhat forState:UIControlStateNormal];
}

- (UIImageView *)titleIV
{
    if(!_titleIV){
        _titleIV = [[UIImageView  alloc]initWithFrame:CGRectMake(10, 10,80, 80)];
        _titleIV.image = IMG(@"1");
    }
    return _titleIV;
}



- (UILabel *)titleLabel
{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.titleIV.frame) +10, 10, SCREEN_WIDTH-130, 40)];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}


- (UIView *)grayLine
{
    if(!_grayLine){
        _grayLine = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleIV.frame) +10, SCREEN_WIDTH, 0.5)];
        _grayLine.backgroundColor = kHCBackgroundColor;
    }
    return _grayLine;
}



- (UILabel *)priceLabel
{
    if(!_priceLabel){
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.titleIV.frame) + 20, 100, 30)];
        _priceLabel.adjustsFontSizeToFitWidth = YES;
        _priceLabel.textColor = [UIColor blackColor];
    }
    return _priceLabel;
}


- (UIButton *)chooseBtn
{
    if(!_chooseBtn){
        _chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _chooseBtn.frame = CGRectMake(SCREEN_WIDTH-165,CGRectGetMaxY(self.grayLine.frame)+10, 70, 30);
        _chooseBtn.layer.borderWidth = 1;
        ViewRadius(_chooseBtn, 5);
        _chooseBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _chooseBtn.layer.borderColor =[UIColor redColor].CGColor;
        [_chooseBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    }
    return _chooseBtn;
}


- (UIButton *)againBtn
{
    if(!_againBtn){
        _againBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        _againBtn.frame = CGRectMake(SCREEN_WIDTH-80, CGRectGetMaxY(self.grayLine.frame) + 10, 70, 30);
        _againBtn.layer.borderWidth = 1;
        _againBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _againBtn.layer.borderColor = [UIColor redColor].CGColor;
        [_againBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_againBtn setTitle:@"再次订购" forState:UIControlStateNormal];
    }
    return _againBtn;
}



@end
