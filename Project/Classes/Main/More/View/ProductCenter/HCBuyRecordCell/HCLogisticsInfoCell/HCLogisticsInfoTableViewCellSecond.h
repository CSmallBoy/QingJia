//
//  HCLogisticsInfoTableViewCellSecond.h
//  Project
//
//  Created by 朱宗汉 on 15/12/21.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HCLogisticsInfo;
@interface HCLogisticsInfoTableViewCellSecond : UITableViewCell

@property (nonatomic,strong) NSIndexPath *indexPath;

@property (nonatomic,strong) HCLogisticsInfo *info;
@end

