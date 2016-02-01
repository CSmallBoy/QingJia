//
//  HCNotificationCenter.h
//  Project
//
//  Created by 朱宗汉 on 15/12/22.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCNotificationCenterInfo : NSObject

@property (nonatomic,strong) NSString *KeyId;
@property (nonatomic,strong) NSString *SendUser;

@property (nonatomic,strong) NSString *SysLevel;
@property (nonatomic,strong) NSString *NoticeType;
@property (nonatomic,strong) NSString *NTitle;
@property (nonatomic,strong) NSString *NContent;

/**
 *时间
 */
@property (nonatomic,strong) NSString *AddTime;
@property (nonatomic,strong) NSString *Address;
@property (nonatomic,strong) NSString *AddressCode;

///**
// *具体通知信息
// */
//@property (nonatomic,strong) NSString *notificationMessage;

/**
 *跟进信息内容
 */
@property (nonatomic,strong) NSArray *followInfoArr;
/**
 *跟进时间
 */
@property (nonatomic,strong) NSArray *followTimeArr;


// --------------- 后添加的属性————————————————
/**
 *  图片网址
 */
@property (nonatomic,strong) NSString  *image;
/**
 *  姓名
 */
@property (nonatomic,strong) NSString  *name;
/**
 *  性别
 */
@property (nonatomic,strong) NSString  *sex;
/**
 *  年龄
 */
@property (nonatomic,strong) NSString  *age;
/**
 *  发布时间
 */
@property (nonatomic,strong) NSString  *sendTime;

/**
 *  走失描述
 */
@property (nonatomic,strong) NSString *missDesc;

@end
