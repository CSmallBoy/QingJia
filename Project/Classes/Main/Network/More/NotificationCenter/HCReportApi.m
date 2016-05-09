//
//  HCReportApi.m
//  钦家
//
//  Created by Tony on 16/5/8.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCReportApi.h"

@implementation HCReportApi


-(void)startRequest:(HCReportBlock)requestBlock
{
    [super startRequest:requestBlock];
}

-(NSString *)requestUrl
{
    return @"Other/report.do";
}

-(id)requestArgument
{
    NSDictionary *head = @{@"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    NSDictionary *para  = @{@"type":@"1",
                            @"id":self.callId,
                            @"imageNames":self.imageNames,
                            @"content":self.content};
    return @{@"Head":head,@"Para":para};
    
}

-(id)formatResponseObject:(id)responseObject
{
    return responseObject;
}

@end
