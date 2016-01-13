//
//  HCPromisedMedicalCell.h
//  Project
//
//  Created by 朱宗汉 on 16/1/11.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HCPromisedDetailInfo;
@protocol HCPromisedMedicalCellDelegate <NSObject>

@optional
-(void)dismissDatePicker2;
-(void)writeAllergic;
@end

@interface HCPromisedMedicalCell : UITableViewCell
//@property(nonatomic,assign)  BOOL  isEdit;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) HCPromisedDetailInfo *detailInfo;
@property (nonatomic, weak) id<HCPromisedMedicalCellDelegate>delegate;


@end
