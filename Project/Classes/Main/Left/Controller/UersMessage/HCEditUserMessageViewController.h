//
//  HCEditUserMessageViewController.h
//  Project
//
//  Created by 朱宗汉 on 16/2/25.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCTableViewController.h"
#import "MyselfInfoModel.h"
@protocol userInfoDelegate <NSObject>
-(void)userInfoName:(MyselfInfoModel *)model;
@end
@interface HCEditUserMessageViewController : HCTableViewController

@property (nonatomic,assign)id<userInfoDelegate>delegate;

@end
