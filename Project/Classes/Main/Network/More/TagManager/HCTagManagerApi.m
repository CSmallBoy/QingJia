//
//  HCTagManagerApi.m
//  Project
//
//  Created by 朱宗汉 on 15/12/27.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCTagManagerApi.h"
#import "HCTagManagerInfo.h"

@implementation HCTagManagerApi
- (void)startRequest:(HCTagManagerBlock)requestBlock
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
    NSMutableArray *tagDetailArr = [NSMutableArray array];
    for (NSInteger i = 0; i < 15; i++)
    {
        HCTagManagerInfo *info = [[HCTagManagerInfo alloc] init];
        info.isShowRow = NO;
        if (i == 0)
        {
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
        }else if (i == 1)
            {
                info.tagUserName = @"张二";
                info.imgArr = @[@"time_picture",@"time_picture",@"time_picture"];
                info.tagNameArr = @[@"书包上的2号标签",@"裤子上的3号标签",@"帽子上的4号标签"];
                info.tagIDArr = @[@"222222",@"333333",@"444444"];
                info.contactImgArr = @[@"cards_but_phone"];
                info.contactNameArr = @[@"张大"];
                info.contactRelationShipArr = @[@"父亲"];
                info.contactPhoneArr = @[@"22222222222"];
                info.cardName = @"啦啦啦";
                info.cardImg = @"110";
                info.userGender = @"女";
                info.userAge = @"13";
                info.userBrithday = @"2015-12-12";
                info.userAddress = @"上海市闵行区梅陇镇集心路268号4号楼201室";
                info.userSchool = @"闵行中心第一小学";
                info.userJob = @"老师";
                info.userHealth = @"健康";
            }else if (i == 2)
            {
                    info.tagUserName = @"赵三";
                    info.imgArr = @[@"time_picture",@"time_picture"];
                    info.tagNameArr = @[@"裤子上的3号标签",@"帽子上的4号标签"];
                    info.tagIDArr = @[@"333333",@"444444"];
                    info.contactImgArr = @[@"cards_but_phone",@"cards_but_phone"];
                    info.contactNameArr = @[@"周一",@"王大"];
                    info.contactRelationShipArr = @[@"母亲",@"父亲"];
                    info.contactPhoneArr = @[@"11111111111",@"22222222222"];
                    info.cardName = @"我是谁";
                    info.cardImg = @"label";
                    info.userGender = @"男";
                    info.userAge = @"15";
                    info.userBrithday = @"2015-12-12";
                    info.userAddress = @"上海市闵行区梅陇镇集心路268号4号楼201室";
                    info.userSchool = @"闵行中心第一小学";
                    info.userJob = @"学生";
                    info.userHealth = @"良好";
            }else if (i == 3)
            {
                info.tagUserName = @"李四";
                info.imgArr = @[@"label"];
                info.tagNameArr = @[@"衬衣上的1号标签"];
                info.tagIDArr = @[@"111111"];
                info.contactImgArr = @[@"time_picture"];
                info.contactNameArr = @[@"周一"];
                info.contactRelationShipArr = @[@"母亲"];
                info.contactPhoneArr = @[@"11111111111"];
                info.cardName = @"我是谁";
                info.cardImg = @"label";
                info.userGender = @"男";
                info.userAge = @"15";
                info.userBrithday = @"2015-12-12";
                info.userAddress = @"上海市闵行区梅陇镇集心路268号4号楼201室";
                info.userSchool = @"闵行中心第一小学";
                info.userJob = @"学生";
                info.userHealth = @"健康";
            }else
            {
                info.tagUserName = @"钱五";
                info.imgArr = @[@"label",@"hopne",@"Calendar",@"110"];
                info.tagNameArr = @[@"衬衣上的1号标签",@"书包上的2号标签",@"裤子上的3号标签",@"帽子上的4号标签"];
                info.tagIDArr = @[@"111111",@"222222",@"333333",@"444444"];
                info.contactImgArr = @[@"label",@"hopne"];
                info.contactNameArr = @[@"周一",@"王大"];
                info.contactRelationShipArr = @[@"母亲",@"父亲"];
                info.contactPhoneArr = @[@"11111111111",@"22222222222"];
                info.cardName = @"我是谁";
                info.cardImg = @"label";
                info.userGender = @"男";
                info.userAge = @"15";
                info.userBrithday = @"2015-12-12";
                info.userAddress = @"上海市闵行区梅陇镇集心路268号4号楼201室";
                info.userSchool = @"闵行中心第一小学";
                info.userJob = @"学生";
                info.userHealth = @"健康";
            }
        
        [tagDetailArr addObject:info];
    }
    
    
    
    return tagDetailArr;
}

@end
