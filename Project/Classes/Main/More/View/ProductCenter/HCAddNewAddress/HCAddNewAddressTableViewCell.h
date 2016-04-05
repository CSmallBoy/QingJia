//
//  HCAddNewAddressTableViewCell.h
//  Project
//
//  Created by 朱宗汉 on 15/12/23.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HCAddressInfo;
@interface HCAddNewAddressTableViewCell : UITableViewCell

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic,strong) HCAddressInfo *info;


@end
