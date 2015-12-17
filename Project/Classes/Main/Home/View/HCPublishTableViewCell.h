//
//  HCPublishTableViewCell.h
//  Project
//
//  Created by 陈福杰 on 15/12/17.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HCPublishTableViewCellDelegate <NSObject>

- (void)hcpublishTableViewCellImageViewIndex:(NSInteger)index;

- (void)hcpublishTableViewCellDeleteImageViewIndex:(NSInteger)index;

@end

@class HCPublishInfo;

@interface HCPublishTableViewCell : UITableViewCell

@property (nonatomic, strong) HCPublishInfo *info;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, strong) id<HCPublishTableViewCellDelegate>delegate;

@end
