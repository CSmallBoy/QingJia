//
//  HCAddFriendTableViewCell.h
//  Project
//
//  Created by 朱宗汉 on 16/1/29.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HCAddFriendTableViewCell : UITableViewCell

@property (nonatomic,strong) NSIndexPath *indexPath;
@property (nonatomic,strong) NSString *nameStr;
//头像
@property (nonatomic,copy) NSString * ImageName;
//显示昵称或者手机号
@property (nonatomic,copy) NSString *nickName;
//住址
@property (nonatomic,copy)NSString * adress;
//个性签名
@property (nonatomic,copy)NSString * sign;
@end
