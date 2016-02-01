//
//  HCAddFriendlistTableViewCell.h
//  Project
//
//  Created by 朱宗汉 on 16/1/29.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HCAddFriendlistTableViewCellDelegate <NSObject>

@optional
-(void)cliclAgreeBtn;
@end

@interface HCAddFriendlistTableViewCell : UITableViewCell

@property (nonatomic,strong) NSIndexPath *indexPath;
@property (nonatomic, weak) id<HCAddFriendlistTableViewCellDelegate>delegate;
@end
