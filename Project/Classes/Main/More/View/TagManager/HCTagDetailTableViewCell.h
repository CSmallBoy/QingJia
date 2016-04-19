//
//  HCTagDetailTableViewCell.h
//  Project
//
//  Created by 朱宗汉 on 15/12/28.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HCNewTagInfo;

@interface HCTagDetailTableViewCell : UITableViewCell

@property (nonatomic,strong) NSIndexPath *indexPath;
@property (nonatomic,strong) HCNewTagInfo *info;


@end
