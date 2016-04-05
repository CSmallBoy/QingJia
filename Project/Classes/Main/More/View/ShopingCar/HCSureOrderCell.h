//
//  HCSureOrderCell.h
//  Project
//
//  Created by 朱宗汉 on 16/3/24.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HCMtalkShopingInfo;
typedef void (^changeAllPriceBlock)(NSInteger num);
@interface HCSureOrderCell : UITableViewCell

@property (nonatomic,strong) HCMtalkShopingInfo *info;

@property (nonatomic,strong) changeAllPriceBlock block;

+(instancetype)cellWithTableView:(UITableView *)tableView;



@end
