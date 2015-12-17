//
//  HCHomeDetailApi.h
//  Project
//
//  Created by 陈福杰 on 15/12/17.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

typedef void(^HCHomeDetailBlock)(HCRequestStatus requestStatus, NSString *message, NSArray *array);

@interface HCHomeDetailApi : HCRequest

- (void)startRequest:(HCHomeDetailBlock)requestBlock;

@end
