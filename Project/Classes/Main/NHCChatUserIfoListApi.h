//
//  NHCChatUserIfoListApi.h
//  Project
//
//  Created by 朱宗汉 on 16/4/21.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"
typedef void(^NHCChatUSerList)(HCRequestStatus requestStatus,NSString *message,NSDictionary * dict);

@interface NHCChatUserIfoListApi : HCRequest
-(void)startRequest:(NHCChatUSerList)requestBlock;
@property (nonatomic,copy)NSString *chatNames;
@end
