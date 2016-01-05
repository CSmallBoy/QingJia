//
//  HCLoginApi.h
//  HealthCloud
//
//  Created by Vincent on 15/10/27.
//  Copyright © 2015年 www.bsoft.com. All rights reserved.
//

#import "HCRequest.h"

typedef void (^HCLoginBlock)(HCRequestStatus requestStatus, NSString *message, HCLoginInfo *loginInfo);

@interface HCLoginApi : HCRequest

- (void)startRequest:(HCLoginBlock)requestBlock;

@property (nonatomic, strong) NSString *UserName;
@property (nonatomic, strong) NSString *UserPWD;

@end
