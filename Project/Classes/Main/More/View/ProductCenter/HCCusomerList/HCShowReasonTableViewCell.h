//
//  HCShowReasonTableViewCell.h
//  Project
//
//  Created by 朱宗汉 on 15/12/31.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HCCustomerInfo;

@protocol HCShowReasonTableViewCellDelegate <NSObject>

@optional

-(void)passcellHight:(CGFloat)cellheight;

@end
@interface HCShowReasonTableViewCell : UITableViewCell
@property (nonatomic,strong) HCCustomerInfo *info;

@property(nonatomic, weak)id<HCShowReasonTableViewCellDelegate>delegate;
@end
