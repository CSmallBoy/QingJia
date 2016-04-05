//
//  HCCreateGradeApi.m
//  Project
//
//  Created by 陈福杰 on 16/1/12.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCCreateGradeApi.h"
#import "HCCreateGradeInfo.h"

@implementation HCCreateGradeApi

- (void)startRequest:(HCCreateGradeBlock)requestBlock
{
    [super startRequest:requestBlock];
}

- (NSString *)requestUrl
{
    return @"Family/create.do";
}

- (id)requestArgument
{

    
    NSDictionary *head = @{@"platForm": @"IOS9.2",
                           @"token":[readUserInfo getReadDic][@"Token"],
                           @"UUID":[readUserInfo GetUUID]};
    
    NSLog(@"%@",[readUserInfo getReadDic][@"Token"]);
    
    
    NSDictionary *para = @{@"ancestralHome":_gradeInfo.ancestralHome,
                           @"familyNickName":_gradeInfo.familyNickName,
                           @"familyDescription":_gradeInfo.familyDescription,
 
                           @"contactAddr":@"上海市，闵行区，集心路168号"};
    
    return @{@"Head":head,@"Para":para};
    
    
   
}

- (id)formatResponseObject:(id)responseObject
{

    
    
    return responseObject;
    
}

@end
