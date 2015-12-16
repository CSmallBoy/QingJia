//
//  HCChangePwdRequest.h
//  HealthCloud
//
//  Created by Jessie on 15/10/9.
//  Copyright © 2015年 www.bsoft.com. All rights reserved.
//

#import "HCRequest.h"

typedef void(^HCChangePwdBlock)(HCRequestStatus requestStatus, NSString *message, id data);

@interface HCChangePwdApi : HCRequest

@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *token;

- (void)startRequest:(HCChangePwdBlock)requestBlock;

@end
