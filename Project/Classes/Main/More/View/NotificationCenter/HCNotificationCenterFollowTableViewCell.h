//
//  HCNotificationCenterFollowTableViewCell.h
//  Project
//
//  Created by 朱宗汉 on 15/12/23.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCNotificationCenterInfo.h"

@interface HCNotificationCenterFollowTableViewCell : UITableViewCell
@property (nonatomic,strong) HCNotificationCenterInfo *info;

@property (nonatomic,strong) NSIndexPath *indexPath;

@end
