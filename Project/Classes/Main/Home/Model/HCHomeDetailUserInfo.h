//
//  HCHomeDetailUserInfo.h
//  Project
//
//  Created by 陈福杰 on 15/12/17.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCHomeDetailUserInfo : NSObject

// 用户昵称和uid用来做跳转到某个人的主页
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *nickName;

@end
