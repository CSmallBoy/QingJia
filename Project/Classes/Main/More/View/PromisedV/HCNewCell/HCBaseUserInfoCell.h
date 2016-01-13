//
//  HCBaseUserInfoCell.h
//  Project
//
//  Created by 朱宗汉 on 16/1/11.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HCPromisedDetailInfo;
@protocol HCBaseUserInfoCellDelegate <NSObject>

@optional

-(void)addUserHeaderIMG:(UIButton *)button;
-(void)dismissDatePicker;

@end


@interface HCBaseUserInfoCell : UITableViewCell

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) HCPromisedDetailInfo *detailInfo;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, weak) id<HCBaseUserInfoCellDelegate>delegate;

@end
