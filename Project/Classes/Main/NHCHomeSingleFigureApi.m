//
//  NHCHomeSingleFigureApi.m
//  Project
//
//  Created by 朱宗汉 on 16/4/18.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "NHCHomeSingleFigureApi.h"

@implementation NHCHomeSingleFigureApi
-(void)startRequest:(HCRequestBlock)requestBlock{
    [super startRequest:requestBlock];
}
-(NSString *)requestUrl{
    // 发表评论
    return @"Times/commentImage.do";
}
-(id)requestArgument{
    NSDictionary *head = @{@"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    NSDictionary *para = @{@"timesId":_TimeID,
                           @"imageName":_ToimageName,
                           @"content":_Content,
                           @"createLocation":@"30,120",
                           @"createAddrSmall":@"123",
                           @"createAddr":@"123",
                           @"to":_toUser};
    return @{@"Head":head,@"Para":para};
}
-(id)formatResponseObject:(id)responseObject
{
    return responseObject;
}
@end
