//
//  HCLodisticsInfoTableViewCell.h
//  Project
//
//  Created by 朱宗汉 on 15/12/21.
//  Copyright © 2015年 com.xxx. All rights reserved.
//物流信息cell

#import <UIKit/UIKit.h>
@class HCLogisticsInfo;
@interface HCLogisticsInfoTableViewCell : UITableViewCell

@property (nonatomic,strong) NSIndexPath *indexPath;

@property (nonatomic,strong) HCLogisticsInfo *info;
@end

