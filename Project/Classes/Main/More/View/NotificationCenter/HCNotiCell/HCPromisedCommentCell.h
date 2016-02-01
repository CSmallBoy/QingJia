//
//  HCPromisedCommentCell.h
//  Project
//
//  Created by 朱宗汉 on 16/2/1.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HCPromisedCommentFrameInfo;
@interface HCPromisedCommentCell : UITableViewCell

@property (nonatomic,strong) HCPromisedCommentFrameInfo  *commnetFrameInfo;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
