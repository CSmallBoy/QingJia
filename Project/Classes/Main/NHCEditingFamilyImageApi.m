//
//  NHCEditingFamilyImageApi.m
//  钦家
//
//  Created by 朱宗汉 on 16/5/13.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "NHCEditingFamilyImageApi.h"

@implementation NHCEditingFamilyImageApi
- (void)startRequest:(HCRequestBlock)requestBlock{
    [super startRequest:requestBlock];
}
- (NSString*)requestUrl{
    return @"Family/uploadFamilyImageName.do";
}
-(id)requestArgument{
    NSDictionary *head = @{@"platForm": [readUserInfo GetPlatForm],
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID,
                           @"token":[HCAccountMgr manager].loginInfo.Token};
    NSDictionary *para = @{@"imageName":_Fmaily_photo};
    return @{@"Head": head, @"Para": para};
    
}
-(id)formatResponseObject:(id)responseObject{
    return responseObject;
}
@end
