//
//  HCApplyReturnReasonCell.h
//  Project
//
//  Created by 朱宗汉 on 15/12/30.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HCApplyReturnResonInfo;

@protocol HCApplyReturnReasonCellDelegate <NSObject>

- (void)hcpublishTableViewCellImageViewIndex:(NSInteger)index;

- (void)hcpublishTableViewCellDeleteImageViewIndex:(NSInteger)index;

@end

@interface HCApplyReturnReasonCell : UITableViewCell


@property (nonatomic,strong) NSIndexPath *indexPath;

@property (nonatomic, strong) HCApplyReturnResonInfo *info;

@property (nonatomic, strong) id<HCApplyReturnReasonCellDelegate>delegate;
@end
