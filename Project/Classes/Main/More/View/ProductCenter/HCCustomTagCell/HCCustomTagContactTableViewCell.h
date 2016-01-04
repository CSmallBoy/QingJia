//
//  HCCustomTagContactTableViewCell.h
//  Project
//
//  Created by 朱宗汉 on 15/12/18.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCTagUserInfo.h"

@protocol HCCustomTagContactTableViewCellDelegate <NSObject>

@optional
-(void)dismissDatePicker0;
@end

@interface HCCustomTagContactTableViewCell : UITableViewCell

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) HCTagUserInfo *tagUserInfo;

@property (nonatomic, weak) id<HCCustomTagContactTableViewCellDelegate>delegate;
@end
