//
//  NHCApplyToFamily.m
//  Project
//
//  Created by 朱宗汉 on 16/3/25.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "NHCApplyToFamily.h"

@implementation NHCApplyToFamily
- (void)startRequest:(NHCCreatFamilyID)requestBlock{
    [super startRequest:requestBlock];
}
- (NSString*)requestUrl{
    return @"Family/create.do";
}
-(id)requestArgument{
    NSDictionary *head = @{@"platForm": @"IOS9.3", @"UUID": @"3284F4E0-80CE-4F14-AEA8-1361066BFBBB",@"token":@""};
    NSDictionary *para = @{@"familyId":@"1000000012" , @"joinMessage":@"验证消息"};
    return @{@"Head": head, @"Para": para};
    
}
-(id)formatResponseObject:(id)responseObject{
    return responseObject;
}
@end
