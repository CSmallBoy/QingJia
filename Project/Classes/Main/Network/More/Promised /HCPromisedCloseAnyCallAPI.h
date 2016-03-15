//
//  HCPromisedCloseAnyCall.h
//  Project
//
//  Created by 朱宗汉 on 16/3/9.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

typedef void(^HCPromisedCloseBlock1)(HCRequestStatus requestStatus,NSString *message,NSDictionary *dic);
@interface HCPromisedCloseAnyCallAPI : HCRequest

@property(nonatomic,assign)int CallId;

-(void)startRequest:(HCPromisedCloseBlock1)requestBlock;
@end
