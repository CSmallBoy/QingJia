//
//  HCJsonRequestApi.h
//  HealthCloud
//
//  Created by Vincent on 15/9/11.
//  Copyright (c) 2015年 www.bsoft.com. All rights reserved.
//

#import "HCRequest.h"

@interface HCJsonRequestApi : HCRequest

- (id)initWithserviceId:(NSString *)serviceId method:(NSString *)method body:(id)body;

@end
