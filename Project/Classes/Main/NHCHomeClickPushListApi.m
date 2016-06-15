//
//  NHCHomeClickPushListApi.m
//  钦家
//
//  Created by Tony on 16/6/15.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "NHCHomeClickPushListApi.h"

@implementation NHCHomeClickPushListApi

-(void)startRequest:(NHCHomeClickPushListBlock)requestBlock
{
    [super startRequest:requestBlock];
}

-(NSString *)requestUrl
{
    return @"Times/getRemindDetail.do";
}

-(id)requestArgument
{
    NSDictionary *head = @{@"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    NSDictionary *para  = @{@"type":self.type,
                            @"timesId":self.timesId,
                            @"contentImageName":self.contentImageName};
    return @{@"Head":head,@"Para":para};
}

-(id)formatResponseObject:(id)responseObject
{
    return responseObject;
}

@end
