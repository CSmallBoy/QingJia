//
//  HCCustomTagContactTableViewCell.h
//  Project
//
//  Created by 朱宗汉 on 15/12/18.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HCPromisedContactTableViewCellDelegate <NSObject>

@optional
-(void)dismissDatePicker0;
@end

@interface HCPromisedContactTableViewCell : UITableViewCell

@property(nonatomic,assign)BOOL  isEdit;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic,strong) NSMutableArray *contactArr;

@property (nonatomic, weak) id<HCPromisedContactTableViewCellDelegate>delegate;
@end
