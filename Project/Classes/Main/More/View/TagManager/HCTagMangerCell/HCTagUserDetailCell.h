//
//  HCTagUserDetailCell.h
//  Project
//
//  Created by 朱宗汉 on 16/4/13.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HCNewTagInfo;
@interface HCTagUserDetailCell : UITableViewCell

@property (nonatomic,strong) NSIndexPath *indexPath;
@property (nonatomic,strong) HCNewTagInfo *info;
@property (nonatomic,strong) UIImage *image;
+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
