//
//  HCMyOrderFollowCell.h
//  Project
//
//  Created by 朱宗汉 on 16/3/18.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>


@class  HCMyOrderFollowInfo;
@interface HCMyOrderFollowCell : UITableViewCell

@property (nonatomic,strong) HCMyOrderFollowInfo *info;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
