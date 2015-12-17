//
//  HCHomeTableViewCell.h
//  Project
//
//  Created by 陈福杰 on 15/12/16.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HCHomeTableViewCell;

@protocol HCHomeTableViewCellDelegate <NSObject>

@optional

- (void)hcHomeTableViewCell:(HCHomeTableViewCell *)cell indexPath:(NSIndexPath *)indexPath moreImgView:(NSInteger)index; // 多图中的第几张

- (void)hcHomeTableViewCell:(HCHomeTableViewCell *)cell indexPath:(NSIndexPath *)indexPahth functionIndex:(NSInteger)index; // 功能按钮

- (void)hcHomeTableViewCell:(HCHomeTableViewCell *)cell indexPath:(NSIndexPath *)indexPath seleteHead:(UIButton *)headBtn; // 点击了头像

@end

@class HCHomeInfo;

@interface HCHomeTableViewCell : UITableViewCell

@property (nonatomic, strong) HCHomeInfo *info;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, weak) id<HCHomeTableViewCellDelegate> delegate;

@end
