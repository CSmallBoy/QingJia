//
//  HCCheckTableViewCell.h
//  Project
//
//  Created by 陈福杰 on 16/2/24.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HCCheckInfo;

@protocol HCCheckTableViewCellDelegate <NSObject>

- (void)HCCheckTableViewCellSelectedModel:(HCCheckInfo *)info;

@end

@interface HCCheckTableViewCell : UITableViewCell

@property (nonatomic, strong) HCCheckInfo *info;

@property (nonatomic, strong) id<HCCheckTableViewCellDelegate>delegate;

@end
