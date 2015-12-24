//
//  HCNotificationCenterFollowTableViewCell.m
//  Project
//
//  Created by 朱宗汉 on 15/12/23.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCNotificationCenterFollowTableViewCell.h"

@interface HCNotificationCenterFollowTableViewCell ()

@property (nonatomic,strong) UILabel *userNameLab;
@property (nonatomic,strong) UILabel *timeLab;
@property (nonatomic,strong) UILabel *notificationMessageLab;

@end


@implementation HCNotificationCenterFollowTableViewCell


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
    _indexPath = indexPath;
    if (indexPath.section == 0)
    {
        self.userNameLab.text = self.info.userName;
        self.notificationMessageLab.text = _info.notificationMessage;
        self.timeLab.text = _info.time;
        [self.contentView addSubview:self.userNameLab];
        [self.contentView addSubview:self.notificationMessageLab];
        [self.contentView addSubview:self.timeLab];

    }
    else if(indexPath.section == 1)
    {
        if (indexPath.row == 0)
        {
            self.textLabel.text = @"跟进信息";
        }
        else if(indexPath.row == 1)
        {
            self.imageView.backgroundColor = [UIColor redColor];
            self.imageView.frame = CGRectMake(10, 10, 30, 30);
            self.textLabel.text  = @"已经跟进信息";
            self.textLabel.font = FONT(14);
            self.detailTextLabel.font = FONT(14);
            self.textLabel.textColor = [UIColor redColor];
            self.detailTextLabel.text = @"2013-10-24 08:11";
            self.detailTextLabel.textColor = [UIColor redColor];
        }
        else
        {
            self.imageView.backgroundColor = LightGraryColor;
            self.textLabel.font = FONT(14);
            self.detailTextLabel.font = FONT(14);
            self.textLabel.text  = @"已经跟进信息";
            self.textLabel.textColor = LightGraryColor;
            self.detailTextLabel.text = @"2013-10-24 08:11";
            self.detailTextLabel.textColor = LightGraryColor ;
        }
    }
    else
    {
        return ;
    }
    
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
        _notificationMessageLab.text = @"亲爱的Tom，你好，你家保本和你的家人走散了，他现在在上海闵行区集心路168号，请尽快联系我们";
        _notificationMessageLab.font = [UIFont systemFontOfSize:15];
    }
    return _notificationMessageLab;
}


@end
