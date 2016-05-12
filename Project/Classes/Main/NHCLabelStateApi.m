//
//  NHCLabelStateApi.m
//  钦家
//
//  Created by 朱宗汉 on 16/5/11.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "NHCLabelStateApi.h"

@implementation NHCLabelStateApi
-(void)startRequest:(HCRequestBlock)requestBlock
{
    [super startRequest:requestBlock];
}
-(NSString *)requestUrl{
    //
    return @"Label/getLabelStatusByScan.do";
}
-(id)requestArgument{
    
    NSDictionary *head = @{@"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    NSDictionary *para = @{@"id":_resultStr};
    
    return @{@"Head":head,@"Para":para};
}

-(id)formatResponseObject:(id)responseObject{
    //NSString *str = responseObject[@"Data"][@"labelInf"][@"status"];
    return responseObject;
}
@end
