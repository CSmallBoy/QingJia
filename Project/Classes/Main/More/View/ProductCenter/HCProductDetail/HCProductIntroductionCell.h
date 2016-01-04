//
//  HCProductIntroductionCell.h
//  Project
//
//  Created by 朱宗汉 on 15/12/16.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCProductIntroductionInfo.h"

@protocol HCProductIntroductionInfoDelegate <NSObject>

@optional

-(void)showForbidLabelDelete;
-(void)showForbidHotStampingMachineDelete;

-(void)showForbidLabelAdd;
-(void)showForbidHotStampingMachineAdd;

@end

@interface HCProductIntroductionCell : UITableViewCell

@property(nonatomic,strong) NSIndexPath *indexPath;

@property (nonatomic,strong) HCProductIntroductionInfo *info;
@property (nonatomic, weak) id<HCProductIntroductionInfoDelegate>delegate;

@end
