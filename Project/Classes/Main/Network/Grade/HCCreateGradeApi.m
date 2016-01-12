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
    return @"Family/Create.ashx";
}

- (id)requestArgument
{
    NSDictionary *head = @{@"Action": @"Create", @"Token": [HCAccountMgr manager].loginInfo.Token, @"UUID": [HCAccountMgr manager].loginInfo.UUID, @"Address": [HCAppMgr manager].address, @"PlatForm": [HCAppMgr manager].systemVersion};
    
    NSDictionary *entity = @{@"FamilyName": _gradeInfo.FamilyName, @"FamilyNickName": _gradeInfo.FamilyNickName, @"FamilyPhoto": _gradeInfo.FamilyPhoto, @"VisitPassWord": _gradeInfo.VisitPassWord, @"ContactAddr": _gradeInfo.ContactAddr};
    NSDictionary *body = @{@"Head": head, @"Entity": entity};
    
    DLog(@"json----%@", [Utils stringWithObject:body]);
    
    return @{@"json": [Utils stringWithObject:body]};
}

- (id)formatResponseObject:(id)responseObject
{
    NSDictionary *dic = responseObject[@"Data"][@"FamilyInf"];
    return [HCCreateGradeInfo mj_objectWithKeyValues:dic];
}

@end
