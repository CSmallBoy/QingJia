//
//  HCTagManagerTableViewCell.h
//  Project
//
//  Created by 朱宗汉 on 15/12/27.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HCTagManagerInfo;

@protocol HCTagManagerTableViewCellDelegate <NSObject>

- (void)HCTagManagerTableViewCell:(NSIndexPath *)indexPath tag:(NSInteger)tag;

@end

@interface HCTagManagerTableViewCell : UITableViewCell

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic,strong) HCTagManagerInfo *info;
@property (nonatomic, weak) id<HCTagManagerTableViewCellDelegate>delegate;

@end
