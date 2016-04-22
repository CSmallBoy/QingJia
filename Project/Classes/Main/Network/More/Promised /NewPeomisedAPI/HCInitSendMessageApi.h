//
//  HCInitSendMessageApi.h
//  Project
//
//  Created by 朱宗汉 on 16/4/21.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

typedef void(^HCInitSendMessageApiBlock)(HCRequestStatus requestStatus, NSString *message, id respone);

@interface HCInitSendMessageApi : HCRequest

@property (nonatomic,strong) NSString *objectId;

-(void)startRequest:(HCInitSendMessageApiBlock)requestBlock;

@end
