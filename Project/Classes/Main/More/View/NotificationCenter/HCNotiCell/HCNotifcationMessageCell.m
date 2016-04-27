//
//  HCNotifcationMessageCell.m
//  Project
//
//  Created by 朱宗汉 on 16/1/29.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCNotifcationMessageCell.h"
#import "HCNotifcationMessageInfo.h"
#import "HCNewTagInfo.h"

#define INTERVAL 10

// ----------------------------与我相关 给XXX留言cell--------------------------------

@interface HCNotifcationMessageCell ()

@property (nonatomic,strong) UIImageView  *headIV;
@property (nonatomic,strong) UILabel      *titleLabel;
@property (nonatomic,strong) UILabel      *messageLabel;
@property (nonatomic,strong) UILabel      *timeLabel;

@end



@implementation HCNotifcationMessageCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
   static  NSString   * ID = @"messageCellID";
    HCNotifcationMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[HCNotifcationMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell addSubviews];
    }
    return cell;
    
}



#pragma mark ---- private mothods

-(void)addSubviews
{

    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    [self addSubview:self.headIV];
    [self addSubview:self.timeLabel];
    [self addSubview:self.titleLabel];
    [self addSubview:self.messageLabel];

}


#pragma mark --- getter Or setter


-(void)setMessageInfo:(HCNewTagInfo *)messageInfo
{
    _messageInfo = messageInfo;
    
    self.titleLabel.text = [NSString stringWithFormat:@"给%@留言",messageInfo.trueName];
    self.timeLabel.text = [NSString stringWithFormat:@"留言时间:%@",messageInfo.createTime];
    self.messageLabel.text = messageInfo.lossDesciption;
    
    NSURL *url = [readUserInfo originUrl:messageInfo.imageName :kkObject];
    [self.headIV sd_setImageWithURL:url placeholderImage:IMG(@"label_Head-Portraits")];
}


- (UIImageView *)headIV
{
    if(!_headIV){
        _headIV = [[UIImageView alloc]initWithFrame:CGRectMake(INTERVAL, INTERVAL, 60, 60)];
        _headIV.image = IMG(@"label_Head-Portraits");
        
    }
    return _headIV;
}

- (UILabel *)titleLabel
{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, INTERVAL, 150, 30)];
        _titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _titleLabel;
}

- (UILabel *)timeLabel
{
    if(!_timeLabel){
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH -160, INTERVAL, 150, 20)];
        _timeLabel.font = [UIFont systemFontOfSize:10];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.textColor  = [UIColor lightGrayColor];
    }
    return _timeLabel;
}



- (UILabel *)messageLabel
{
    if(!_messageLabel){
        _messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 40, SCREEN_WIDTH-80, 30)];
        _messageLabel.font = [UIFont systemFontOfSize:12];
    }
    return _messageLabel;
}



@end
