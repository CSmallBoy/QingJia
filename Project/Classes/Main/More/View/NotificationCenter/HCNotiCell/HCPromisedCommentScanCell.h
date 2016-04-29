//
//  HCPromisedCommentScanCellTableViewCell.h
//  Project
//
//  Created by 朱宗汉 on 16/4/29.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HCPromisedCommentInfo;

@interface HCPromisedCommentScanCell : UITableViewCell

@property (nonatomic,strong) HCPromisedCommentInfo *info;

+(instancetype)CellWithTableView:(UITableView *)tableview;

@end
