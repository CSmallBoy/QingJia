//
//  NHCChatGroupInfoApi.h
//  Project
//
//  Created by 朱宗汉 on 16/5/1.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"
typedef void(^NHCChatGroup)(HCRequestStatus requestStatus,NSString *message,NSArray * arr);
@interface NHCChatGroupInfoApi : HCRequest
-(void)startRequest:(NHCChatGroup)requestBlock;
@property (nonatomic,copy)NSString *chatNames;
@end
