//
//  HCCustomTagUserInfoCell.h
//  Project
//
//  Created by 朱宗汉 on 15/12/17.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCTagUserInfo.h"

@protocol HCCustomTagUserInfoCellDelegate <NSObject>

@optional

-(void)addUserHeaderIMG;
-(void)dismissDatePicker;
@end

@interface HCCustomTagUserInfoCell : UITableViewCell

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) HCTagUserInfo *tagUserInfo;

@property (nonatomic, weak) id<HCCustomTagUserInfoCellDelegate>delegate;

@end
