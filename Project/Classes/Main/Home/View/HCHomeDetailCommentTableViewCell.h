//
//  HCHomeDetailCommentTableViewCell.h
//  Project
//
//  Created by 陈福杰 on 15/12/18.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HCHomeDetailCommentTableViewCellDelegate <NSObject>

@optional

- (void)hchomeDetailCommentTableViewCellCommentButton;

- (void)hchomeDetailCommentTableViewCellCommentHeight:(CGFloat)commentHeight;

@end

@class HCHomeInfo;

@interface HCHomeDetailCommentTableViewCell : UITableViewCell

@property (nonatomic, strong) HCHomeInfo *info;

@property (nonatomic, strong) UIButton *commentBtn;

@property (nonatomic, weak) id<HCHomeDetailCommentTableViewCellDelegate>delegate;

@end
