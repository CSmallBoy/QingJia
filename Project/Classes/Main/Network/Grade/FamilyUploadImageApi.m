//
//  NHCUploadImageApi.m
//  Project
//
//  Created by 朱宗汉 on 16/4/6.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "FamilyUploadImageApi.h"

@implementation FamilyUploadImageApi
- (void)startRequest:(NHCUPImage)requestBlock
{
    [super startRequest:requestBlock];
}

- (NSString *)requestUrl
{
    return @"Photo/uploadOne.do";
}
- (id)requestArgument
{
    NSDictionary *head = @{@"UUID":[HCAccountMgr manager].loginInfo.UUID,
                           @"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token};
    
    NSDictionary *para = @{@"id":_familyId,
                           @"type":@"1",
                           @"photo":_photoStr
                           };
   
    return @{@"Head":head,@"Para":para};

}
- (id)formatResponseObject:(id)responseObject
{
    return responseObject;
}
@end

