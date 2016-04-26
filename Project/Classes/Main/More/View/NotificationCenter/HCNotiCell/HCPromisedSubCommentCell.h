//
//  HCPromisedCommentCell.h
//  Project
//
//  Created by 朱宗汉 on 16/2/1.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

// -------------------------------------留言子评论cell----------------------------------------


typedef void(^HCPromisedCommentCellBlock)(UIButton  *button) ;
typedef void (^subCommentBlock)(NSIndexPath *indexPath);

@class HCPromisedCommentFrameInfo;
@interface HCPromisedSubCommentCell : UITableViewCell

@property (nonatomic,strong) HCPromisedCommentFrameInfo  *commnetFrameInfo;
@property (nonatomic,strong) HCPromisedCommentCellBlock block;

@property (nonatomic,strong) subCommentBlock subBlock;
@property (nonatomic,strong) NSIndexPath  *indexPath;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
