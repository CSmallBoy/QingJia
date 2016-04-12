//
//  NHCReleaseTimeApi.h
//  Project
//
//  Created by 朱宗汉 on 16/4/7.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

typedef void(^NHCReleaseTime)(HCRequestStatus requestStatus,NSString *message,NSString * Tid);
@interface NHCReleaseTimeApi : HCRequest
-(void)startRequest:(NHCReleaseTime)requestBlock;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *openAddress;
@property(nonatomic,copy)NSString *permitType;
@property(nonatomic,copy)NSString *createLocation;
@property(nonatomic,copy)NSString *createAddrSmall ;
@property(nonatomic,copy)NSString *createAddr;
@property(nonatomic,copy)NSString *imageNames;
@end
