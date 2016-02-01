//
//  HCNotificationCenterFollowTableViewCell.m
//  Project
//
//  Created by 朱宗汉 on 15/12/23.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCNotificationCenterFollowTableViewCell.h"
#import "HCNotificationCenterInfo.h"
@interface HCNotificationCenterFollowTableViewCell ()

@end

@implementation HCNotificationCenterFollowTableViewCell

-(void)setIndexPath:(NSIndexPath *)indexPath
{
    self.textLabel.font = [UIFont systemFontOfSize:15];
    self.detailTextLabel.font = [UIFont systemFontOfSize:12];
    self.textLabel.text = _info.followInfoArr[indexPath.row-1];
    self.detailTextLabel.text = _info.followTimeArr[indexPath.row-1];
    if (indexPath.row == 1)
    {
        self.imageView.image = OrigIMG(@"redPointAndLine");
        self.textLabel.textColor = [UIColor redColor];
        self.detailTextLabel.textColor = [UIColor redColor];
    }
    else if (indexPath.row == _info.followTimeArr.count+1)
    {
        self.imageView.image = OrigIMG(@"lightGrayPointAndLine2");

    }else
    {
        self.imageView.image = OrigIMG(@"lightGrayPointAndLine1");
    }
}

@end
