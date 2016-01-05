//
//  HCCustomTagApi.m
//  Project
//
//  Created by 朱宗汉 on 15/12/17.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCCustomTagApi.h"
#import "HCTagUserInfo.h"

@implementation HCCustomTagApi


- (void)startRequest:(HCResumeBlock)requestBlock
{
    [super startRequest:requestBlock];
}

- (id)requestArgument
{
    NSDictionary *jsonDic = [_info mj_keyValues];
    
    [jsonDic setValue:[_info.contactInfoArr componentsJoinedByString:@","] forKey:@"contactInfo"];
    
    NSDictionary *dic = @{@"t": @"User,info", @"uid": [HCAccountMgr manager].loginInfo.Token, @"update": jsonDic};
    return dic;
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
