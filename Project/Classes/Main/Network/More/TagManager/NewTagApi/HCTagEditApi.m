//
//  HCTagEditApi.m
//  Project
//
//  Created by 朱宗汉 on 16/4/11.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCTagEditApi.h"

// -------------------编辑标签----------------------

@implementation HCTagEditApi

-(void)startRequest:(HCTagEditBlock)requestBlock
{
    [super startRequest:requestBlock];
}

-(NSString *)requestUrl
{
    return @"Label/editLabel.do";
}

-(id)requestArgument
{
    NSDictionary *head = @{@"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    
    NSDictionary *para = @{@"labelId":_labelId,
                           @"imageName":_imageName,
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
