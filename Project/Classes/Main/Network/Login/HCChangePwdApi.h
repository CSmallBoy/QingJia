//
//  HCChangePwdRequest.h
//  HealthCloud
//
//  Created by 陈福杰 on 15/11/17.
//  Copyright © 2015年 www.bsoft.com. All rights reserved.
//

#import "HCRequest.h"

typedef void(^HCChangePwdBlock)(HCRequestStatus requestStatus, NSString *message, id data);

@interface HCChangePwdApi : HCRequest

@property (nonatomic, strong) NSString *UserName;
@property (nonatomic, strong) NSString *Token;
@property (nonatomic, strong) NSString *UserPWD;

- (void)startRequest:(HCChangePwdBlock)requestBlock;

@end
