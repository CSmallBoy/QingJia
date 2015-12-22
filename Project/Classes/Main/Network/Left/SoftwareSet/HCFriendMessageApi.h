//
//  HCFriendMessageApi.h
//  Project
//
//  Created by 陈福杰 on 15/12/22.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

typedef void(^HCFriendMessageBlock)(HCRequestStatus requestStatus, NSString *message, NSArray *array);

@interface HCFriendMessageApi : HCRequest

- (void)startRequest:(HCFriendMessageBlock)requestBlock;

@end
