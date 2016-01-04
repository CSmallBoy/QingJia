//
//  HCNotificationCenterTableViewCell.m
//  Project
//
//  Created by 朱宗汉 on 15/12/22.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCNotificationCenterUnreadTableViewCell.h"


@interface HCNotificationCenterUnreadTableViewCell ()

@property (nonatomic,strong) UILabel *userNameLab;
@property (nonatomic,strong) UILabel *timeLab;
@property (nonatomic,strong) UILabel *notificationMessageLab;

@property (nonatomic,strong) UIImageView *deleteIMGV;
@property (nonatomic,strong) UIView *redVIew;

@end

@implementation HCNotificationCenterUnreadTableViewCell

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

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.redVIew.frame = CGRectMake(WIDTH(self), 0,WIDTH(self.contentView), self.contentView.frame.size.height);
    self.deleteIMGV.frame = CGRectMake(0, 0, 75 , HEIGHT(self.redVIew));
    self.userNameLab.frame = CGRectMake(10, 0, 120, 30);
    self.notificationMessageLab.frame = CGRectMake(10, 35, WIDTH(self)-20, 40);
    self.timeLab.frame = CGRectMake(self.contentView.frame.size.width-150, 5, 140, 20);
}

-(UIView *)redVIew
{
    if (!_redVIew)
    {
        _redVIew = [[UIView alloc]init];
        _redVIew.backgroundColor = [UIColor redColor];
    }
    return  _redVIew;
}

-(UIImageView *)deleteIMGV
{
    if (!_deleteIMGV)
    {
        _deleteIMGV = [[UIImageView alloc]init];
        [_deleteIMGV setImage:OrigIMG(@"Notification-Center_delete")];
    }
    return _deleteIMGV;
    
}

-(UILabel *)userNameLab
{
    if (!_userNameLab)
    {
        _userNameLab = [[UILabel alloc]init];
        _userNameLab.textAlignment = NSTextAlignmentLeft;
        _userNameLab.font = [UIFont systemFontOfSize:15];
        _userNameLab.textColor  = [UIColor blackColor];
    }
    return _userNameLab;
}

-(UILabel*)timeLab
{
    if (!_timeLab)
    {
        _timeLab = [[UILabel alloc]init];
        _timeLab.textAlignment = NSTextAlignmentRight;
        _timeLab.font =      [UIFont systemFontOfSize:10];
        _timeLab.textColor = [UIColor lightGrayColor];
    }
    return _timeLab;
}

-(UILabel *)notificationMessageLab
{
    if (!_notificationMessageLab)
    {
        _notificationMessageLab = [[UILabel alloc]init];
        _notificationMessageLab.textAlignment = NSTextAlignmentLeft;
        _notificationMessageLab.textColor = [UIColor blackColor];
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
