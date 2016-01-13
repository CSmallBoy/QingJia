//
//  HCPromisedAddSelectAPI.m
//  Project
//
//  Created by 朱宗汉 on 16/1/12.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCPromisedAddSelectAPI.h"
#import "HCPromisedMissInfo.h"
@implementation HCPromisedAddSelectAPI

-(void)startRequest:(HCPromisedSelectBlock)requestBlock
{
    [super startRequest:requestBlock];
}

- (NSString *)requestUrl
{
    return @"AnyCall/AnyCall.ashx";
}


-(id)requestArgument
{
    NSDictionary * head = @{@"Action" : @"CreateWithData",
                            @"Token" : [HCAccountMgr manager].loginInfo.Token,
                            @"UUID":[HCAppMgr manager].uuid};
    NSDictionary  *jsonPara = [_missInfo mj_keyValues];
    NSDictionary *body = @{@"Head" : head,
                           @"Para" : jsonPara};
    
    return @{@"json" :[Utils stringWithObject:body]};
}

- (NSString *)formatMessage:(HCRequestStatus)statusCode
{
    NSString *msg = nil;
    if (statusCode == HCRequestStatusFailure)
    {
        msg = @"加载失败";
    }
    return msg;
}

@end
