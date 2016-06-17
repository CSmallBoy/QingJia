//
//  HCScanCardApi.m
//  钦家
//
//  Created by Tony on 16/6/17.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCScanCardApi.h"

@implementation HCScanCardApi

-(void)startRequest:(HCReportBlock)requestBlock
{
    [super startRequest:requestBlock];
}

-(NSString *)requestUrl
{
    return @"CallReply/scanLiveLabel.do";
}

-(id)requestArgument
{
    NSDictionary *head = @{@"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    NSDictionary *para  = @{@"labelGuid":self.labelGuid,
                            @"createLocation":self.createLocation};
    return @{@"Head":head,@"Para":para};
    
}

-(id)formatResponseObject:(id)responseObject
{
    return responseObject;
}


@end
