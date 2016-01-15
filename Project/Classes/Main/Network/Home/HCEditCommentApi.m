//
//  HCEditCommentApi.m
//  Project
//
//  Created by 陈福杰 on 15/12/18.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCEditCommentApi.h"
#import "HCEditCommentInfo.h"

@implementation HCEditCommentApi

- (void)startRequest:(HCEditCommentBlock)requestBlock
{
    [super startRequest:requestBlock];
}

- (NSString *)requestUrl
{
    return @"FamilyTimes/FamilyTimesReply.ashx";
}

- (id)requestArgument
{
    NSString *locationf = [NSString stringWithFormat:@"%@,%@", [HCAppMgr manager].latitude, [HCAppMgr manager].longitude];
    
    NSDictionary *head = @{@"Action": @"CommonPublish",
                           @"Token": [HCAccountMgr manager].loginInfo.Token,
                           @"UUID": [HCAccountMgr manager].loginInfo.UUID, @"PlatForm": [HCAppMgr manager].systemVersion};
    NSDictionary *entity = @{@"FTID": [Utils getNumberWithString:_commentInfo.FTID],
                             @"FTContent": _commentInfo.FTContent,
                             @"CreateLocation": locationf,
                             @"CreateAddrSmall": [HCAppMgr manager].addressSmall,
                             @"CreateAddr": [HCAppMgr manager].address
                             };
    NSMutableDictionary *dicM = [NSMutableDictionary dictionaryWithDictionary:entity];
    if (!IsEmpty(_FTImages))
    {
        [dicM setObject:_FTImages forKey:@"FTImages"];
    }
    
    NSDictionary *body = @{@"Head": head, @"Entity": dicM};
    return @{@"json": [Utils stringWithObject:body]};
}

- (id)formatResponseObject:(id)responseObject
{
    return responseObject[@"Data"];
}


@end
