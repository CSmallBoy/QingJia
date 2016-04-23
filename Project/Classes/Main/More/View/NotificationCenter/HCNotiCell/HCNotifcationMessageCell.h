//
//  HCNotifcationMessageCell.h
//  Project
//
//  Created by 朱宗汉 on 16/1/29.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

// -------------------------------------- 与我相关 给XXX留言cell--------------------------------

@class HCNewTagInfo;

@interface HCNotifcationMessageCell : UITableViewCell

@property (nonatomic,strong) HCNewTagInfo  *messageInfo;

+(instancetype)cellWithTableView:(UITableView  *)tableView;


@end
