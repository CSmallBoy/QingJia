//
//  HCGradeManagerTableViewCell.h
//  Project
//
//  Created by 陈福杰 on 15/12/23.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HCCreateGradeInfo;

@protocol HCGradeManagerTableViewCellDelegate <NSObject>

- (void)HCGradeManagerTableViewCellSelectedTag:(NSInteger)tag;

@end

@interface HCGradeManagerTableViewCell : UITableViewCell

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic,strong) UIImage *image;
@property (nonatomic, strong) UITextField *textField;
//推送显示的消息数
@property (nonatomic, strong) UILabel *number;

@property (nonatomic,strong) HCCreateGradeInfo *info;
@property (nonatomic, weak) id<HCGradeManagerTableViewCellDelegate>delegate;

@property (nonatomic,assign) BOOL IsAble;

@property (nonatomic,assign) BOOL IsEditingPhoto;

@end
