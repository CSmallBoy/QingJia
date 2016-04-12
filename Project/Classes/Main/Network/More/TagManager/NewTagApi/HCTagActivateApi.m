//
//  HCTagActivateApi.m
//  Project
//
//  Created by 朱宗汉 on 16/4/11.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCTagActivateApi.h"

// -------------------激活标签----------------------

@implementation HCTagActivateApi

-(void)startRequest:(HCTagActivateBlock)requestBlock
{
    [super startRequest:requestBlock];
}

-(NSString *)requestUrl
{
    return @"Label/activateLabel.do";
}


-(id)requestArgument
{
    NSDictionary *head = @{@"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    
    NSDictionary *para =@{@"labelGuid":_labelGuid,
                          @"imageName":_imageName,
                          @"labelTitle":_labelTitle,
                          @"objectId":_objectId,
                          @"contactorId1":_contactorId1,
                          @"contactorId2":_contactorId2};
    
    return @{@"Head":head,
             @"Para":para};
}

-(id)formatResponseObject:(id)responseObject
{
    return responseObject;
}


@end
