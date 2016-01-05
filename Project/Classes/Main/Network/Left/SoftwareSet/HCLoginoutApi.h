//
//  HCLoginoutApi.h
//  Project
//
//  Created by 陈福杰 on 16/1/5.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

typedef void(^HCLoginoutBlock)(HCRequestStatus requestStatus, NSString *message, id data);

@interface HCLoginoutApi : HCRequest

- (void)startRequest:(HCLoginoutBlock)requestBlock;

@end
