//
//  HCNotificationCenterTableViewCell.m
//  Project
//
//  Created by 朱宗汉 on 15/12/22.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCMyNotificationCenterTableViewCell.h"
#define INTERVAL 10

@interface HCMyNotificationCenterTableViewCell ()

@property (nonatomic,strong) UIButton  *button;
@property (nonatomic,strong) UILabel   *NameSexAgeLB;
@property (nonatomic,strong) UILabel   *sendLabel;
@property (nonatomic,strong) UILabel   *missLabel;


@end

@implementation HCMyNotificationCenterTableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
   static  NSString * notiID = @"myNotiID";
    HCMyNotificationCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:notiID];
    if (!cell) {
        cell = [[HCMyNotificationCenterTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:notiID];
        [cell addSubviews];
        

    }
    return cell;
}

#pragma mark --- provite mothods

-(void)addSubviews
{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    [self addSubview:self.button];
    [self addSubview:self.NameSexAgeLB];
    [self addSubview:self.sendLabel];
    [self addSubview:self.missLabel];
}

#pragma mark --- getter Or setter

-(void)setInfo:(HCNotificationCenterInfo *)info
{
    _info = info;
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@ %@岁",info.trueName,info.sex,info.age]];
    [attStr addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13], NSForegroundColorAttributeName: [UIColor lightGrayColor]} range:NSMakeRange(attStr.length-4, 4)];
    [attStr addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} range:NSMakeRange(0, attStr.length-4)];
    self.NameSexAgeLB.attributedText = attStr;
    
    self.sendLabel.text = [NSString stringWithFormat:@"发布时间：%@",info.createTime];
    
    self.missLabel.text = [NSString stringWithFormat:@"走失描述：%@",info.lossDesciption];
  
}

-(void)buttonClick:(UIButton *)button
{
    UIImage *image = [button backgroundImageForState:UIControlStateNormal];
    NSDictionary *dic = @{@"image" : image};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"显示头像" object:nil userInfo:dic];

}

// 头像的宽度为60
- (UIButton *)button
{
    if(!_button){
        _button  = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(INTERVAL, INTERVAL, 60, 60);
        [_button setBackgroundImage:[UIImage imageNamed:@"label_Head-Portraits"] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

// 姓名 性别 年龄 的宽度  150
- (UILabel *)NameSexAgeLB
{
    if(!_NameSexAgeLB){
        _NameSexAgeLB = [[UILabel alloc]initWithFrame:CGRectMake(80, INTERVAL, 150, 30)];
    }
    return _NameSexAgeLB;
}

// 发布时间 宽度  150
- (UILabel *)sendLabel
{
    if(!_sendLabel){
        _sendLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH -150, INTERVAL, 150, 20)];
        _sendLabel.font = [UIFont systemFontOfSize:12];
        _sendLabel.textColor = [UIColor lightGrayColor];
        _sendLabel.textAlignment = NSTextAlignmentRight;
    }
    return _sendLabel;
}


- (UILabel *)missLabel
{
    if(!_missLabel){
        _missLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 40, SCREEN_WIDTH-80, 30)];
        _missLabel.font = [UIFont systemFontOfSize:14];
    }
    return _missLabel;
}



@end
