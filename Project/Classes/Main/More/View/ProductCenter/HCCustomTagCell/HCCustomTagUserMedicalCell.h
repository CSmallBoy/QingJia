//
//  HCCustomTagUserMedicalCell.h
//  Project
//
//  Created by 朱宗汉 on 15/12/18.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HCTagUserInfo;
@protocol HCCustomTagUserMedicalCellDelegate <NSObject>

@optional
-(void)dismissDatePicker2;

-(void)writeAllergic;
@end

@interface HCCustomTagUserMedicalCell : UITableViewCell

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, strong) HCTagUserInfo *tagUserInfo;
@property (nonatomic, weak) id<HCCustomTagUserMedicalCellDelegate>delegate;


@end
