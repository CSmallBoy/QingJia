//
//  HCPromisedAddCallMessage.m
//  Project
//
//  Created by 朱宗汉 on 16/1/6.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCPromisedAddCallMessageAPI.h"
#import "HCPromisedDetailInfo.h"
#import "HCPromisedMissInfo.h"
@implementation HCPromisedAddCallMessageAPI

-(void)startRequest:(HCPromisedAddCallMessageBlock)requestBlock
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
    
    NSDictionary  *jsonEntity = [_info mj_keyValues];
    
    NSDictionary  *jsonPara = [_missInfo mj_keyValues];
    
    
    NSDictionary *body = @{@"Head" : head,
                           @"Entity" : jsonEntity,
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
