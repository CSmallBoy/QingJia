//
//  HCNotificationCentereReadTableViewCell.m
//  Project
//
//  Created by 朱宗汉 on 15/12/23.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCNotificationCentereReadTableViewCell.h"

@interface HCNotificationCentereReadTableViewCell ()

@property (nonatomic,strong) UILabel *userNameLab;
@property (nonatomic,strong) UILabel *timeLab;
@property (nonatomic,strong) UILabel *notificationMessageLab;

@end
@implementation HCNotificationCentereReadTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self.contentView addSubview:self.userNameLab];
        [self.contentView addSubview:self.notificationMessageLab];
        [self.contentView addSubview:self.timeLab];
    }
    return self;
}

-(UILabel *)userNameLab
{
    if (!_userNameLab) {
        _userNameLab = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 120, 30)];
        _userNameLab.textAlignment = NSTextAlignmentLeft;
        _userNameLab.font = [UIFont systemFontOfSize:15];
        _userNameLab.text = @"清海浮生";
        _userNameLab.textColor  = [UIColor blackColor];
    }
    return _userNameLab;
}

-(UILabel*)timeLab
{
    if (!_timeLab) {
        _timeLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-200, 5,170, 20)];
        _timeLab.textAlignment = NSTextAlignmentRight;
        _timeLab.font = [UIFont systemFontOfSize:10];
        _timeLab.text = [NSString stringWithFormat:@"2015年08月23日 12:10"];
        _timeLab.textColor = [UIColor lightGrayColor];
    }
    return _timeLab;
}

-(UILabel *)notificationMessageLab
{
    if (!_notificationMessageLab) {
        _notificationMessageLab = [[UILabel alloc]initWithFrame:CGRectMake(10,35 , SCREEN_WIDTH-40, 40)];
        _notificationMessageLab.textAlignment = NSTextAlignmentLeft;
        _notificationMessageLab.textColor = [UIColor blackColor];
        _notificationMessageLab.text = @"阿福口角是非将卡双方就开始大部分建设步伐加快双边说";
        _notificationMessageLab.font = [UIFont systemFontOfSize:15];
    }
    return _notificationMessageLab;
}

-(void)setInfo:(HCNotificationCenterInfo *)info
{
    _info = info;
    
    self.userNameLab.text = info.userName;
    self.notificationMessageLab.text = info.notificationMessage;
    self.timeLab.text = info.time;
}

@end
