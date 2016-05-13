//
//  NHCGetFamilyImageApi.m
//  钦家
//
//  Created by 朱宗汉 on 16/5/13.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "NHCGetFamilyImageApi.h"

@implementation NHCGetFamilyImageApi
- (void)startRequest:(HCRequestBlock)requestBlock{
    [super startRequest:requestBlock];
}
- (NSString*)requestUrl{
    return @"Family/getFamilyImageName.do";
}
-(id)requestArgument{
    NSDictionary *head = @{@"platForm": [readUserInfo GetPlatForm],
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID,
                           @"token":[HCAccountMgr manager].loginInfo.Token};
    NSDictionary *para = [NSDictionary dictionary];
    return @{@"Head": head, @"Para": para};
    
}
-(id)formatResponseObject:(id)responseObject{
    return responseObject;
}
@end
