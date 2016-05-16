//
//  NHCHomepushListApi.m
//  钦家
//
//  Created by 朱宗汉 on 16/5/16.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "NHCHomepushListApi.h"

@implementation NHCHomepushListApi
-(void)startRequest:(HCRequestBlock)requestBlock{
    [super startRequest:requestBlock];
}
-(NSString *)requestUrl{
    
    return @"Times/getRemindSummary.do";
}
-(id)requestArgument{
    NSDictionary *head = @{@"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    NSDictionary *para = [NSDictionary dictionary];
//    
//    para = @{@"timesId":_Timesid,
//             @"content":_content,
//             @"parentCommentId":_parentCommentId,
//             @"createLocation":@"30,118",
//             @"createAddrSmall":@"上海市,闵行区",
//             @"createAddr":@"郑州市,中原区,中原路路168号",
//             @"to":_ToUserId};
    
    
    return @{@"Head":head,@"Para":para};
}
-(id)formatResponseObject:(id)responseObject
{
    return responseObject;
}
@end
