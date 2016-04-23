//
//  HCNotificationMessageCallCell.m
//  Project
//
//  Created by 朱宗汉 on 16/1/29.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCNotificationMessageCallCell.h"
#import "HCNotifcationMessageInfo.h"
#import "HCNewTagInfo.h"

#define INTERVAL 10

//---------------------------与我相关 与XXXX通话cell----------------------------------

@interface HCNotificationMessageCallCell ()

@property (nonatomic ,strong) UIImageView   *headIV;
@property (nonatomic,strong)  UILabel       *titleLabel;

@end


@implementation HCNotificationMessageCallCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString  *ID = @"messageCallCell";
    HCNotificationMessageCallCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[HCNotificationMessageCallCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell addSubviews];
    }
   
    return cell;
}

#pragma mark --- private mothods

-(void)addSubviews
{
    for (UIView  *view in self.subviews)
    {
        [view removeFromSuperview];
    }
    
    [self addSubview:self.headIV];
    [self addSubview:self.titleLabel];
}


#pragma mark --- setter Or getter


-(void)setMessageInfo:(HCNewTagInfo *)messageInfo
{
    _messageInfo = messageInfo;
    
    self.titleLabel.text = [NSString stringWithFormat:@"给%@留言",messageInfo.trueName];
    
    NSURL *url = [readUserInfo originUrl:messageInfo.imageName :kkUser];
    [self.headIV sd_setImageWithURL:url placeholderImage:IMG(@"label_Head-Portraits")];
    
}


- (UIImageView *)headIV
{
    if(!_headIV)
    {
        _headIV = [[UIImageView alloc]initWithFrame:CGRectMake(INTERVAL, INTERVAL, 60, 60)];
        _headIV.image = IMG(@"label_Head-Portraits");

    }
    return _headIV;
}


- (UILabel *)titleLabel
{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 25, 150, 30)];
    }
    return _titleLabel;
}


@end
