//
//  HCCustomerTableViewCell.h
//  Project
//
//  Created by 朱宗汉 on 15/12/19.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HCCustomerInfo;
@interface HCCustomerTableViewCell : UITableViewCell


@property (nonatomic,strong) NSIndexPath *indexPath;

@property (nonatomic,strong) HCCustomerInfo *info;
@end
