//
//  HCNotificationCenterTableViewCell.h
//  Project
//
//  Created by 朱宗汉 on 15/12/22.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCNotificationCenterInfo.h"


@interface HCMyNotificationCenterTableViewCell : UITableViewCell

@property (nonatomic,strong) HCNotificationCenterInfo *info;

@property (nonatomic,strong) NSIndexPath *indexPath;

+(instancetype)cellWithTableView: (UITableView *)tableView;

@end
