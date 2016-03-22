//
//  HCShopingCarCell.h
//  Project
//
//  Created by 朱宗汉 on 16/3/22.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(changeAllPriceBlock);
@class HCMtalkShopingInfo;
@interface HCShopingCarCell : UITableViewCell

@property (nonatomic,strong) HCMtalkShopingInfo *info;

+(instancetype)cellWithTableView:(UITableView *)tableView;



@end
