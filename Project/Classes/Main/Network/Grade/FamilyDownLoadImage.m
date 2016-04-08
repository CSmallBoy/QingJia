//
//  FamilyDownLoadImage.m
//  Project
//
//  Created by 朱宗汉 on 16/4/7.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "FamilyDownLoadImage.h"


@implementation FamilyDownLoadImage

-(void)startRequest:(FamilyDownLoadImageBlock)requestBlock
{
    [super startRequest:requestBlock];
}

-(NSString *)requestUrl
{
    return @"Photo/downloadOne.do";
}

-(id)requestArgument
{
    NSDictionary *head = @{@"UUID":[HCAccountMgr manager].loginInfo.UUID,
                           @"platForm":@"IOS9.2",
                           @"token":[HCAccountMgr manager].loginInfo.Token};
    
    NSDictionary *para = @{@"Id":_familyId,
                           @"type":@"1"};
    
    return @{@"Head":head,
             @"Para":para};
   
}


-(id)formatResponseObject:(id)responseObject
{
    return responseObject;
}

@end
