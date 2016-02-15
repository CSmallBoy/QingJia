//
//  HCAddFriendlistTableViewCell.h
//  Project
//
//  Created by 朱宗汉 on 16/1/29.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>
//@protocol HCAddFriendlistTableViewCellDelegate <NSObject>
//
//@optional
//-(void)cliclAgreeBtn;
//@end
//
//@interface HCAddFriendlistTableViewCell : UITableViewCell
//
//@property (nonatomic,strong) NSIndexPath *indexPath;

@protocol HCAddFriendlistTableViewCellDelegate  <NSObject>
@optional
- (void)SCSwipeTableViewCelldidSelectBtnWithTag:(NSInteger)tag andIndexPath:(NSIndexPath *)indexpath;

- (void)cellOptionBtnWillShow;
- (void)cellOptionBtnWillHide;
- (void)cellOptionBtnDidShow;
- (void)cellOptionBtnDidHide;

-(void)cliclAgreeBtn;

@end

@interface HCAddFriendlistTableViewCell : UITableViewCell

@property (nonatomic, weak)id<HCAddFriendlistTableViewCellDelegate >delegate;


@property (nonatomic, retain)NSArray *rightBtnArr;


@property (nonatomic, retain)UIColor *cellBackGroundColor;


@property (nonatomic, retain)UIView *SCContentView;


@property (nonatomic, retain)UITableView *superTableView;

@property (nonatomic, assign, readonly)BOOL isRightBtnShow;


@property (nonatomic,strong) NSIndexPath *indexPath;


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withBtns:(NSArray *)arr tableView:(UITableView *)tableView;
//@property (nonatomic, weak) id<HCAddFriendlistTableViewCellDelegate>delegate;
//@property (nonatomic,weak) id<HCAddFriendlistTableViewCellDelegate> delegate;
@end
