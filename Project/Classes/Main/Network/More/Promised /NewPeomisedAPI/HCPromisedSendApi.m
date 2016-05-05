//
//  HCPromisedSendApi.m
//  Project
//
//  Created by 朱宗汉 on 16/4/21.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCPromisedSendApi.h"
#import "HCNewTagInfo.h"
#import "HCTagContactInfo.h"
@implementation HCPromisedSendApi

-(void)startRequest:(HCPromisedSendBlock)requestBlock
{
    [super startRequest:requestBlock];
}

-(NSString *)requestUrl
{
   return @"CallReply/call.do";
}


-(id)requestArgument
{
    NSDictionary *head = @{@"platForm":[readUserInfo GetPlatForm],
                           @"token":[HCAccountMgr manager].loginInfo.Token,
                           @"UUID":[HCAccountMgr manager].loginInfo.UUID};
    
    if (self.ContractArr.count>0) {

        // 重新绑定了联系人
        
        HCTagContactInfo *info1 = self.ContractArr[0];
        HCTagContactInfo*info2 = self.ContractArr[1];
        
        NSMutableArray *arr  = [NSMutableArray array];
        NSString *str;
        
        if (self.tagArr.count>0) {
            for (HCNewTagInfo *info in self.tagArr) {
                
                [arr addObject:info.labelId];
            }
            
          str = [arr componentsJoinedByString:@","];
        }
        else
        {
           str = @"";
        }
        
        
        NSDictionary *para = @{@"objectId":self.info.objectId,
                               @"relation1":info1.relative,
                               @"contactorId1":info1.contactorId,
                               @"relation2":info2.relative,
                               @"contactorId2":info2.contactorId,
                               @"labelIds":str,
                               @"lossTime":_lossTime,
                               @"callLocation":_callLocation,
                               @"lossAddress":_lossAddress,
                               @"lossDesciption":_lossDesciption,
                               @"lossImageName":_lossImageName,
                               @"openHealthCard":self.info.openHealthCard,
                               @"openHomeAddress":self.info.openHomeAddress};
        
  
        
        [Utils stringWithObject:@{@"Head":head,
                                  @"Para":para}];
        
        return @{@"Head":head,
                @"Para":para};
        
        
    }
    else
    {
        NSMutableArray *arr  = [NSMutableArray array];
        NSString *str;
        
        if (self.tagArr.count>0) {
            for (HCNewTagInfo *info in self.tagArr) {
                
                [arr addObject:info.labelId];
            }
            
            str = [arr componentsJoinedByString:@","];
        }
        else
        {
            str = @"";
        }


        NSDictionary *para = @{@"objectId":self.info.objectId,
                               @"labelIds":str,
                               @"lossTime":_lossTime,
                               @"callLocation":_callLocation,
                               @"lossAddress":_lossAddress,
                               @"lossDesciption":_lossDesciption,
                               @"lossImageName":_lossImageName,
                               @"openHealthCard":self.info.openHealthCard,
                               @"openHomeAddress":self.info.openHomeAddress};
        
        NSDictionary *nody =  @{@"Head":head,
                                @"Para":para};
        
        [Utils stringWithObject:@{@"Head":head,
                                  @"Para":para}];

        
        return nody;
    }
   
}

-(id)formatResponseObject:(id)responseObject
{
    return responseObject;
}


@end
