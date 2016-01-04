//
//  HCApplyReissueReasonCell.h
//  Project
//
//  Created by 朱宗汉 on 15/12/30.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HCApplyReissueResonInfo;

@protocol HCApplyReissueReasonCellDelegate <NSObject>

- (void)hcpublishTableViewCellImageViewIndex:(NSInteger)index;

- (void)hcpublishTableViewCellDeleteImageViewIndex:(NSInteger)index;

@end
@interface HCApplyReissueReasonCell : UITableViewCell


@property (nonatomic,strong) NSIndexPath *indexPath;

@property (nonatomic, strong) HCApplyReissueResonInfo *info;

@property (nonatomic, strong) id<HCApplyReissueReasonCellDelegate>delegate;
@end
