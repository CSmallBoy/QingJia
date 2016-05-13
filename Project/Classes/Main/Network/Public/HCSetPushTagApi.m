//
//  HCSetPushTagApi.m
//  钦家
//
//  Created by Tony on 16/5/13.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCSetPushTagApi.h"

@implementation HCSetPushTagApi

-(void)startRequest:(HCReportBlock)requestBlock
{
    [super startRequest:requestBlock];
}

-(NSString *)requestUrl
{
    return @"CallReply/setUserTag.do";
}

-(id)requestArgument
{
    NSDictionary *head = @{@"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    NSDictionary *para  = @{@"userTag":self.userTag,
                            @"locationTag":self.locationTag,
                            @"currentAddress":self.currentAddress,
                            @"currentLocation":self.currentLocation};
    return @{@"Head":head,@"Para":para};
    
}

-(id)formatResponseObject:(id)responseObject
{
    return responseObject;
}

@end
