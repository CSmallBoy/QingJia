//
//  HCBuyRecordTableViewCell.h
//  Project
//
//  Created by 朱宗汉 on 15/12/19.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HCProductIntroductionInfo;


@protocol HCBuyRecordCellDelegate <NSObject>

@optional

-(void)handleApplyReissue:(HCProductIntroductionInfo*)info;

-(void)handleApplyReturn:(HCProductIntroductionInfo*)info;

@end

@interface HCBuyRecordTableViewCell : UITableViewCell



@property (nonatomic,strong) NSIndexPath *indexPath;
@property (nonatomic,strong) HCProductIntroductionInfo *info;


@property (nonatomic, weak) id<HCBuyRecordCellDelegate>delegate;

@end
