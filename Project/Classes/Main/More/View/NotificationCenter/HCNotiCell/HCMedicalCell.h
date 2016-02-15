//
//  HCMedicalCell.h
//  Project
//
//  Created by 朱宗汉 on 16/2/3.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HCMedicalFrameIfo;
@interface HCMedicalCell : UITableViewCell

@property (nonatomic,strong) HCMedicalFrameIfo  *info;
@property (nonatomic,strong) NSIndexPath    *indexPath;

+(instancetype)cellWithTableView:(UITableView *)tableView;


@end
