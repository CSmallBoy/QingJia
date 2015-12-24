//
//  HCCreateGradeTableViewCell.h
//  Project
//
//  Created by 陈福杰 on 15/12/24.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HCCreateGradeInfo;

@interface HCCreateGradeTableViewCell : UITableViewCell

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) HCCreateGradeInfo *info;

@property (nonatomic, strong) UITextField *textField;

@end
