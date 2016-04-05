//
//  HCReceiveAddressCell.h
//  Project
//
//  Created by 朱宗汉 on 16/3/24.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^changeDefaultAdressBlock) (NSIndexPath *indexPath);

@class HCAddressInfo;
@interface HCReceiveAddressCell : UITableViewCell

@property (nonatomic,strong) HCAddressInfo *info;
@property (nonatomic,strong) NSIndexPath *indexpath;
@property (nonatomic,strong) changeDefaultAdressBlock block;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
