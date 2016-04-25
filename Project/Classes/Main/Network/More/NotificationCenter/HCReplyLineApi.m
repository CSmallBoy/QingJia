//
//  HCReplyLineApi.m
//  Project
//
//  Created by 朱宗汉 on 16/4/25.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCReplyLineApi.h"
#import "HCPromisedCommentInfo.h"

@implementation HCReplyLineApi

-(void)startRequest:(HCReplyLineBlock)requestBlock
{
    [super startRequest:requestBlock];
}

-(NSString *)requestUrl
{
    return @"CallReply/replyClue.do";
}

-(id)requestArgument
{
    NSDictionary *head = @{@"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    
    if (self.info.toId == nil) {
        self.info.toId = @"";
    }
    
    NSDictionary *para = @{@"callId":_callId,
                           @"imageNames":self.info.imageNames,
                           @"content":self.info.content,
                           @"createLocation":@"121.76,31.05",
                           @"toId":self.info.toId};
    
    
    return @{@"Head":head,
             @"Para":para};
    
    
  
}

-(id)formatResponseObject:(id)responseObject
{
    return responseObject;
}

@end
