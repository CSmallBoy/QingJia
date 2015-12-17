//
//  HCHomeDetailTableViewCell.h
//  Project
//
//  Created by 陈福杰 on 15/12/17.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HCHomeInfo, HCHomeDetailInfo;

@interface HCHomeDetailTableViewCell : UITableViewCell

@property (nonatomic, strong) HCHomeInfo *info;
@property (nonatomic, strong) HCHomeDetailInfo *detailInfo;

@end
