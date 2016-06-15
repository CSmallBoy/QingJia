//
//  HCFamilyUserInfoViewController.h
//  钦家
//
//  Created by 朱宗汉 on 16/5/26.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCTableViewController.h"
#import "HCFriendMessageInfo.h"
@interface HCFamilyUserInfoViewController : HCTableViewController

@property (nonatomic, retain) HCFriendMessageInfo *info;
@property (nonatomic, copy) NSString *memberId;

@end
