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
@property (nonatomic,copy) NSString *ture_name;
@property (nonatomic,copy) NSString *sex;
@property (nonatomic,copy) NSString *shuxiang;
@property (nonatomic,copy) NSString *birthday;
@property (nonatomic,copy) NSString *adress;
@property (nonatomic,copy) NSString *professional;
@property (nonatomic,copy) NSString *copany;
@property (nonatomic,copy) NSString *headimage;
@property (nonatomic,copy) NSString *nickName;
@end
