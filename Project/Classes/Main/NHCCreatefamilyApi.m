//
//  NHCCreatefamilyApi.m
//  Project
//
//  Created by 朱宗汉 on 16/3/25.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "NHCCreatefamilyApi.h"

@implementation NHCCreatefamilyApi
- (void)startRequest:(NHCCreatFamilyID)requestBlock{
    [super startRequest:requestBlock];
}
- (NSString*)requestUrl{
    return @"Family/create.do";
}
-(id)requestArgument{
    NSDictionary *head = @{@"platForm": @"IOS9.3",
                           @"token":[readUserInfo getReadDic][@"Token"],
                           @"UUID":[readUserInfo GetUUID]};
    NSDictionary *para = @{@"ancestralHome":@"祖籍" , @"familyNickName":@"个性签名" ,@"familyPhoto":@"头像",@"photoType":@"jpg",@"contactAddr":@"上海市,闵行区,集心路168号"};
    return @{@"Head": head, @"Para": para};
  
}
-(id)formatResponseObject:(id)responseObject{
    return responseObject;
}
@end
