//
//  HCShopingCarCell.h
//  Project
//
//  Created by 朱宗汉 on 16/3/22.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HCMtalkShopingInfo;
typedef void (^changeAllPriceBlock)(void);
@interface HCShopingCarCell : UITableViewCell

@property (nonatomic,strong) HCMtalkShopingInfo *info;

@property (nonatomic,strong) changeAllPriceBlock block1;
@property (nonatomic,strong) changeAllPriceBlock block2;

+(instancetype)cellWithTableView:(UITableView *)tableView;



@end
