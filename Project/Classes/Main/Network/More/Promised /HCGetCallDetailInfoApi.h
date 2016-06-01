//
//  HCGetCallDetailInfoApi.h
//  钦家
//
//  Created by Tony on 16/6/1.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^HCRequestBlock) (HCRequestStatus requestStatus,NSString *message,id respone);

@interface HCGetCallDetailInfoApi : HCRequest
@property (nonatomic,copy)NSString *callId;
-(void)startRequest:(HCRequestBlock)requestBlock;

@end
