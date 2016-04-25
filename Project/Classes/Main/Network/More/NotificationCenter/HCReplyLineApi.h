//
//  HCReplyLineApi.h
//  Project
//
//  Created by 朱宗汉 on 16/4/25.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

// --------------------回复线索Api-------------------------------
#import "HCRequest.h"

typedef void(^HCReplyLineBlock) (HCRequestStatus requestStatus,NSString *message ,id respone);

@class HCPromisedCommentInfo;

@interface HCReplyLineApi : HCRequest

@property (nonatomic,strong) NSString *callId;
@property (nonatomic,strong) HCPromisedCommentInfo *info;

-(void)startRequest:(HCRequestBlock)requestBlock;

@end
