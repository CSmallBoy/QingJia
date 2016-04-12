//
//  NHCHomeCommentsApi.m
//  Project
//
//  Created by 朱宗汉 on 16/4/9.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "NHCHomeCommentsApi.h"

@implementation NHCHomeCommentsApi
-(void)startRequest:(HCRequestBlock)requestBlock{
    [super startRequest:requestBlock];
}
-(NSString *)requestUrl{
    // 发表评论
    return @"Times/comment.do";
}
-(id)requestArgument{
    NSDictionary *head = @{@"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    NSDictionary *para = @{@"timesId":@"",
                           @"content":@"",
                           @"createLocation":@"",
                           @"createAddrSmall":@"",
                           @"to":@""};
    return @{@"Head":head,@"Para":para};
}
-(id)formatResponseObject:(id)responseObject
{
    return responseObject;
}
@end