//
//  HCTagAddObjectApi.m
//  Project
//
//  Created by 朱宗汉 on 16/4/11.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCTagAddObjectApi.h"
#import "HCNewTagInfo.h"

// -------------------添加对象----------------------

@implementation HCTagAddObjectApi

-(void)startRequest:(HCTagAddObjectBlock)requestBlock
{
    [super startRequest:requestBlock];
}

-(NSString *)requestUrl
{
   return @"Label/createObject.do";
}

-(id)requestArgument
{
    NSDictionary *head = @{@"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    
    NSDictionary *para = @{@"trueName":_info.trueName,
                           @"imageName":_info.imageName,
                           @"sex":_info.sex,
                           @"birthDay":_info.birthDay,
                           @"homeAddress":_info.homeAddress,
                           @"school":_info.school,
                           @"height":_info.height,
                           @"weight":_info.weight,
                           @"bloodType":_info.bloodType,
                           @"allergic":_info.allergic,
                           @"cureCondition":_info.cureCondition,
                           @"cureNote":_info.cureNote};
    
    return @{@"Head":head,
             @"Para":para};
}

-(id)formatResponseObject:(id)responseObject
{
    return responseObject;
}

@end
