//
//  HCCustomTagUserInfoCell.h
//  Project
//
//  Created by 朱宗汉 on 15/12/17.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HCTagUserInfo;
@protocol HCCustomTagUserInfoCellDelegate <NSObject>

@optional

-(void)addUserHeaderIMG:(UIButton *)button;
-(void)dismissDatePicker;

@end

@interface HCCustomTagUserInfoCell : UITableViewCell

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) HCTagUserInfo *tagUserInfo;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, weak) id<HCCustomTagUserInfoCellDelegate>delegate;
@property (nonatomic,strong)UIImage  *image;
@end
