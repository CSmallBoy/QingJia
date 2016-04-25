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

@property (nonatomic,strong) UIImageView  *headIV;
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
    
    [self addSubview:self.headIV];
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
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlag =  NSMonthCalendarUnit | NSDayCalendarUnit |NSHourCalendarUnit| NSMinuteCalendarUnit|NSSecondCalendarUnit ;
    NSDateComponents *cmp = [calendar components:unitFlag fromDate:[NSDate dateWithTimeIntervalSince1970:[info.createTime integerValue]]];
    NSDateComponents *cmp1 = [calendar components:unitFlag fromDate:[NSDate date]];
    
    
    if ([cmp minute] == [cmp1 minute]) {
        self.sendLabel.text = @"发布时间：刚刚";
    }
    else if([cmp hour] == [cmp1 hour])
    {
        self.sendLabel.text= [NSString stringWithFormat:@"发布时间：%ld分钟前",cmp.minute];
    }
    else  if([cmp day] == [cmp1 day])
    {
        self.sendLabel.text = [NSString stringWithFormat:@"发布时间：%ld小时前",cmp1.hour- cmp.hour];
    }
    else if(cmp1.day-cmp.day ==1)
    {
        self.sendLabel.text = @"发布时间：昨天";
    }
    else
    {
        self.sendLabel.text = [NSString stringWithFormat:@"发布时间：%ld月%ld日",cmp.month,cmp.day];
    }
    
    self.missLabel.text = [NSString stringWithFormat:@"走失描述：%@",info.lossDesciption];

    NSURL *url = [readUserInfo originUrl:self.info.imageName :kkUser];
    [_headIV sd_setImageWithURL:url placeholderImage:IMG(@"Head-Portraits")];
  
}

-(void)tap:(UITapGestureRecognizer *)tap
{
    UIImage *image = _headIV.image;
    NSDictionary *dic = @{@"image" : image};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"显示头像" object:nil userInfo:dic];
    
}

// 头像的宽度为60
- (UIImageView *)headIV
{
    if(!_headIV){
        _headIV  = [[UIImageView alloc]initWithFrame:CGRectMake(INTERVAL, INTERVAL, 60, 60)];

        _headIV.userInteractionEnabled = YES;
        UITapGestureRecognizer*tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [_headIV addGestureRecognizer:tap];
        
    }
    return _headIV;
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
