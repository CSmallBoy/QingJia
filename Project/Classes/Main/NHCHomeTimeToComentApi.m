//
//  NHCHomeTimeToComentApi.m
//  Project
//
//  Created by 朱宗汉 on 16/4/27.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "NHCHomeTimeToComentApi.h"

@implementation NHCHomeTimeToComentApi
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
    NSDictionary *para;

        para = @{@"timesId":_Timesid,
                 @"content":_content,
                 @"parentCommentId":_parentCommentId,
                 @"createLocation":@"30,118",
                 @"createAddrSmall":@"上海市,闵行区",
                 @"createAddr":@"郑州市,中原区,中原路路168号",
                 @"to":_ToUserId};

    
    return @{@"Head":head,@"Para":para};
}
-(id)formatResponseObject:(id)responseObject
{
    return responseObject;
}
@end