//
//  SCSwipeTableViewCell.h
//  SCSwipeTableViewCell
//
//  Created by Sunc on 15/12/17.
//  Copyright © 2015年 Sunc. All rights reserved.


#import <UIKit/UIKit.h>


//----------------------------------------家庭审核列表cell-----------------------------------------
@class HCCheckInfo;
@protocol SCSwipeTableViewCellDelegate <NSObject>

- (void)SCSwipeTableViewCelldidSelectBtnWithTag:(NSInteger)tag andIndexPath:(NSIndexPath *)indexpath;

- (void)cellOptionBtnWillShow;
- (void)cellOptionBtnWillHide;
- (void)cellOptionBtnDidShow;
- (void)cellOptionBtnDidHide;

- (void)HCCheckTableViewCellSelectedModel:(HCCheckInfo *)info;

@end


@interface NHCCheckTableViewCell : UITableViewCell

@property (nonatomic, strong) HCCheckInfo *info;

@property (nonatomic,assign) BOOL isSaveCell;

@property (nonatomic, weak)id<SCSwipeTableViewCellDelegate>delegate;

/**
 @author Sunc
 
 the option btn you set
 */
@property (nonatomic, retain)NSArray *rightBtnArr;

/**
 @author Sunc
 
 cell back ground color
 */
@property (nonatomic, retain)UIColor *cellBackGroundColor;

/**
 @author Sunc
 
 when SCSwipeTableViewCell is used, the SCContentView is used instead of contentView of cell itself
 */
@property (nonatomic, retain)UIView *SCContentView;

/**
 @author Sunc
 
 the super tableview of cell
 */
@property (nonatomic, retain)UITableView *superTableView;

/**
 @author Sunc
 
 cell init function, you should send the superTabelView of the cell
 
 */

@property (nonatomic, assign, readonly)BOOL isRightBtnShow;

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
           withBtns:(NSArray *)arr
          tableView:(UITableView *)tableView;

@end
