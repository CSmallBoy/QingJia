//
//  HCHomeDetailTableViewCell.h
//  Project
//
//  Created by 陈福杰 on 15/12/17.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HCHomeDetailTableViewCellDelegate <NSObject>

@optional

- (void)hchomeDetailTableViewCellHeight:(CGFloat)cellHeight;

- (void)hchomeDetailTableViewCellSelectedImage:(NSInteger)index;

- (void)hchomeDetailTableViewCellSelectedTagWithUserid:(NSInteger)index;

@end

@class HCHomeInfo, HCHomeDetailInfo;

@interface HCHomeDetailTableViewCell : UITableViewCell

@property (nonatomic, strong) HCHomeInfo *info;
@property (nonatomic, strong) NSArray *praiseArr; // 点赞的用户
@property (nonatomic, assign) CGFloat praiseHeight;
@property (nonatomic, assign) BOOL isDelete;//是否要删除

@property (nonatomic, weak) id<HCHomeDetailTableViewCellDelegate>delegates;

@end
