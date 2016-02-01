//
//  HCNotifcationMessageCell.h
//  Project
//
//  Created by 朱宗汉 on 16/1/29.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HCNotifcationMessageInfo;

@interface HCNotifcationMessageCell : UITableViewCell

@property (nonatomic,strong) HCNotifcationMessageInfo  *messageInfo;

+(instancetype)cellWithTableView:(UITableView  *)tableView;


@end
