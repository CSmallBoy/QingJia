//
//  HCLogoutApi.h
//  HealthCloud
//
//  Created by Vincent on 15/11/3.
//  Copyright © 2015年 www.bsoft.com. All rights reserved.
//

#import "HCRequest.h"

typedef void(^HCLoginoutBlock)(HCRequestStatus requestStatus, NSString *message, id data);

@interface HCLogoutApi : HCRequest

- (void)startRequest:(HCLoginoutBlock)requestBlock;


@end
