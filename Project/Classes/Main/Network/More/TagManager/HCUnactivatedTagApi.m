//
//  HCUnactivatedTagApi.m
//  Project
//
//  Created by 朱宗汉 on 15/12/28.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCUnactivatedTagApi.h"
#import "HCTagManagerInfo.h"

@implementation HCUnactivatedTagApi

- (void)startRequest:(HCUnactivatedTagBlock)requestBlock
{
    [super startRequest:requestBlock];
}

- (NSString *)requestUrl
{
    return @"Label/Label.ashx";
}

- (id)requestArgument
{
    NSDictionary *head = @{@"Action" : @"GetList" ,
                           @"Token":[HCAccountMgr manager].loginInfo.Token ,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    
    NSDictionary *para = @{@"LabelStatus": _LabelStatus};
    NSDictionary *result = @{@"Start" : @(_Start), @"Count" : @(_Count)};
    NSDictionary *bodyDic = @{@"Head" : head, @"Para" : para, @"Result" : result};
    
    return @{@"json": [Utils stringWithObject:bodyDic]};
}

- (id)formatResponseObject:(id)responseObject
{
    HCTagManagerInfo *info = [[HCTagManagerInfo alloc] init];
    info.tagUserName = @"王一";
    info.imgArr = @[@"time_picture",@"time_picture",@"time_picture",@"time_picture"];
    info.tagNameArr = @[@"衬衣上的1号标签",@"书包上的2号标签",@"裤子上的3号标签",@"帽子上的4号标签"];
    info.tagIDArr = @[@"111111",@"222222",@"333333",@"444444"];
    info.contactImgArr = @[@"cards_but_phone",@"cards_but_phone"];
    info.contactNameArr = @[@"周一",@"王大"];
    info.contactRelationShipArr = @[@"母亲",@"父亲"];
    info.contactPhoneArr = @[@"11111111111",@"22222222222"];
    info.cardName = @"我是谁";
    info.cardImg = @"label";
    info.userGender = @"男";
    info.userAge = @"15";
    info.userBrithday = @"2015-12-12";
    info.userAddress = @"上海市闵行区梅陇镇集心路168号4号楼201室";
    info.userSchool = @"闵行中心第一小学";
    info.userJob = @"学生";
    info.userHealth = @"健康";
    
    return info;
}

@end
