//
//  HCMTalkMyOrderCell.h
//  Project
//
//  Created by 朱宗汉 on 16/3/17.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HCMtalkMyOrderInfo;
@interface HCMTalkWaitPayCell : UITableViewCell

@property (nonatomic,strong)HCMtalkMyOrderInfo *info;

+(instancetype)cellWithTable:(UITableView *)tableView;


@end
