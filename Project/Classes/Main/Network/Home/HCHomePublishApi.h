//
//  HCHomePublishApi.h
//  Project
//
//  Created by 陈福杰 on 15/12/17.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

typedef void(^HCHomePublishBlock)(HCRequestStatus requestStatus, NSString *message, id data);

@interface HCHomePublishApi : HCRequest

- (void)startRequest:(HCHomePublishBlock)requestBlock;

@end
