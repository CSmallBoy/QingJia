//
//  HCApplyReturnDetailCell.h
//  Project
//
//  Created by 朱宗汉 on 15/12/30.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HCApplyReturnResonInfo;
@interface HCApplyReturnDetailCell : UITableViewCell

@property (nonatomic, strong) HCApplyReturnResonInfo *info;
@property (nonatomic,strong) NSIndexPath *indexPath;
@end
