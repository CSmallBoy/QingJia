//
//  HCTagChangeObjectApi.m
//  Project
//
//  Created by 朱宗汉 on 16/4/11.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCTagChangeObjectApi.h"

#import "HCNewTagInfo.h"

// -------------------变更对象----------------------

@implementation HCTagChangeObjectApi

-(void)startRequest:(HCTagChangeObjectBlock)requestBlock
{
    [super startRequest:requestBlock];
}


-(NSString *)requestUrl
{
    return @"Label/updateObject.do";
}

-(id)requestArgument
{
    NSDictionary *head = @{@"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    
    NSDictionary *para =@{@"objectId":_objectId,
                          @"imageName":_info.imageName,
                          @"birthDay":_info.birthDay,
                          @"homeAddress":_info.homeAddress,
                          @"school":_info.school,
                          @"height":_info.height,
                          @"weight":_info.weight,
                          @"bloodType":_info.bloodType,
                          @"allergic":_info.allergic,
                          @"cureCondition":_info.cureCondition,
                          @"cureNote":_info.cureNote,
                          @"relation1":_info.relation1,
                          @"contactorId1":_info.contactorId1,
                          @"relation2":_info.relation2,
                          @"contactorId2":_info.contactorId2};
    
    return  @{@"Head":head,
              @"Para":para};
    
}

-(id)formatResponseObject:(id)responseObject
{
    return responseObject;
}

@end
