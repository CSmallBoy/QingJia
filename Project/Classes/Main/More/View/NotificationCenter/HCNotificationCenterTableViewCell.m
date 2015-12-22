//
//  HCNotificationCenterTableViewCell.m
//  Project
//
//  Created by 朱宗汉 on 15/12/22.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCNotificationCenterTableViewCell.h"
#import "HCButtonItem.h"

@interface HCNotificationCenterTableViewCell ()

@property (nonatomic,strong) UIView *deleteView;
@property (nonatomic,strong) UILabel *timeLab;
@end

@implementation HCNotificationCenterTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
//        UIImageView *deleteImageView  = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-20, 0, 44, 44)];
//        deleteImageView.image = OrigIMG(@"Settings_icon_Cache_dis");
//        [self.contentView addSubview:deleteImageView];
        
        [self.contentView addSubview:self.textLabel];
        [self.contentView addSubview:self.detailTextLabel];
        [self.contentView addSubview:self.timeLab];
        [self.contentView addSubview:self.deleteView];
    }
    return self;
}


-(UIView *)deleteView
{
    if (!_deleteView) {
        _deleteView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH-30, 44)];
        HCButtonItem *deleteBtn=[[HCButtonItem alloc]initWithFrame:CGRectMake(0, 0, 0, 50) WithImageName:@"Settings_icon_Cache_dis" WithImageWidth:60 WithImageHeightPercentInItem:.7 WithTitle:NSLocalizedString(@"", nil) WithFontSize:14 WithFontColor:[UIColor blackColor] WithGap:-5];
        deleteBtn.backgroundColor = [UIColor greenColor];
        _deleteView.backgroundColor = [UIColor whiteColor];
        [_deleteView addSubview:deleteBtn];
    }
    return _deleteView;
}


-(UILabel*)timeLab
{
    if (!_timeLab) {
        _timeLab = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width-180, 0,170, 20)];
        _timeLab.textAlignment = NSTextAlignmentRight;
        _timeLab.font = [UIFont systemFontOfSize:12];
        _timeLab.text = [NSString stringWithFormat:@"2015年08月23日 12:10"];
        _timeLab.textColor = [UIColor lightGrayColor];
    }
    return _timeLab;
}

-(void)setInfo:(HCNotificationCenterInfo *)info
{
    _info = info;
    
    self.textLabel.text = info.userName;
    self.detailTextLabel.text = info.notificationMessage;
    self.timeLab.text = info.time;
}
/*
 
 
 cell= [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:unreadID];
 UIView *deletView = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, 44)];
 HCButtonItem *deleteBtn=[[HCButtonItem alloc]initWithFrame:CGRectMake(0, 0, 44, 44) WithImageName:@"Settings_icon_Cache_dis" WithImageWidth:44 WithImageHeightPercentInItem:.7 WithTitle:NSLocalizedString(@"", nil) WithFontSize:14 WithFontColor:[UIColor blackColor] WithGap:-5];
 deletView.backgroundColor = [UIColor whiteColor];
 [deletView addSubview:deleteBtn];
 [cell.contentView addSubview:deletView];
 }
 
 UILabel * timeLab = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-180, 0,170, 20)];
 timeLab.textAlignment = NSTextAlignmentRight;
 timeLab.font = [UIFont systemFontOfSize:12];
 [cell.contentView addSubview:timeLab];
 timeLab.text = [NSString stringWithFormat:@"2015年08月23日 12:10"];
 cell.textLabel.text = @"M-Talk";
 cell.detailTextLabel.text = @"丝状噬菌体表面呈现技术自1985年至今已逐渐成熟，通过将随机核苷酸编码的寡肽插入编码包被蛋白基因的开放读框末端，即可构建含有大量的具有不同结构和组成信息的噬菌体呈现表位文库";
 timeLab.textColor = [UIColor lightGrayColor];
 */
@end
