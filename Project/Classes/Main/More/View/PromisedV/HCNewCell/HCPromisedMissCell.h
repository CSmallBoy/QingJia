//
//  HCPromisedMissCell.h
//  Project
//
//  Created by 朱宗汉 on 16/1/11.
//  Copyright © 2016年 com.xxx. All rights reserved.
//
#import <UIKit/UIKit.h>

@class HCPromisedMissInfo;
@protocol HCPromisedMissCellDelegate <NSObject>

@optional
-(void)dismissDatePicker2;

-(void)writeLossDesciption;
@end

@interface HCPromisedMissCell : UITableViewCell


@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, strong) HCPromisedMissInfo *missInfo;
@property (nonatomic, weak) id<HCPromisedMissCellDelegate>delegate;


@end
