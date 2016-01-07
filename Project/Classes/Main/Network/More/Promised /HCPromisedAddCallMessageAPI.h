//
//  HCPromisedAddCallMessage.h
//  Project
//
//  Created by 朱宗汉 on 16/1/6.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"


typedef void(^HCPromisedCreateCallBlock)(HCRequestStatus requestStatus, NSString *message, id responseObject);


@interface HCPromisedAddCallMessageAPI : HCRequest
@property (nonatomic, strong) NSString *Token;

-(void)startRequest:(HCPromisedCreateCallBlock)requestBlock;

@end
