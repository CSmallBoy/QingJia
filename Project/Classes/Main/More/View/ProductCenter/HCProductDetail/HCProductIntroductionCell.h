//
//  HCProductIntroductionCell.h
//  Project
//
//  Created by 朱宗汉 on 15/12/16.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCProductIntroductionInfo.h"


@interface HCProductIntroductionCell : UITableViewCell

@property(nonatomic,strong) NSIndexPath *indexPath;

@property (nonatomic,strong) HCProductIntroductionInfo *info;

@end
