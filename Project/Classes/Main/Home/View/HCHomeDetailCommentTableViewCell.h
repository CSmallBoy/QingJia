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

@property (nonatomic, strong) NSIndexPath *indexpath;

//第几张图 的位置
@property (nonatomic, copy) NSString *image_num;
//图片详情的那张图片的名字
@property (nonatomic, copy) NSString *image_name;
//这个时光的timeid
@property (nonatomic, copy) NSString *pic_time_id;
//subrows子评论
@property (nonatomic,strong)NSArray *subRows;
//时光的id
@property (nonatomic,copy)NSString *timeID;
// 对谁的回复
@property (nonatomic,copy)NSString *toUSer;
@property (nonatomic, weak) id<HCHomeDetailCommentTableViewCellDelegate>delegate;

@end
