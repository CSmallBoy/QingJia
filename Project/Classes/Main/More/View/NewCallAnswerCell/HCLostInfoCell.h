//
//  HCLostInfoCell.h
//  钦家
//
//  Created by Tony on 16/5/25.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCNewTagInfo.h"

@interface HCLostInfoCell : UITableViewCell

@property (nonatomic, strong)HCNewTagInfo *info;//储存新建走失者信息
@property (nonatomic, strong)NSIndexPath *indexPath;//赋值刷新

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
