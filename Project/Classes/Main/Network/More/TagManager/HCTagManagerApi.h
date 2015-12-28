//
//  HCTagManagerApi.h
//  Project
//
//  Created by 朱宗汉 on 15/12/27.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCRequest.h"


typedef void(^HCTagManagerBlock)(HCRequestStatus requestStatus, NSString *message, NSArray *array);

@interface HCTagManagerApi : HCRequest

- (void)startRequest:(HCTagManagerBlock)requestBlock;


@end
