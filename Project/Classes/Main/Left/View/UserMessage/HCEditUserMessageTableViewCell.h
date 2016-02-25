//
//  HCEditUserMessageTableViewCell.h
//  Project
//
//  Created by 朱宗汉 on 16/2/25.
//  Copyright © 2016年 com.xxx. All rights reserved.
//  -------------------------- 个人信息编辑cell----------------------

#import <UIKit/UIKit.h>

@interface HCEditUserMessageTableViewCell : UITableViewCell

@property (nonatomic,strong) NSIndexPath   * indexPath;


+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
