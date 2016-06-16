//
//  HCMemberApi.h
//  钦家
//
//  Created by 殷易辰 on 16/6/14.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"
typedef void(^NHCGetMemerinfo) (HCRequestStatus requestStatus, NSString *message, id response);
@interface HCMemberApi : HCRequest
-(void)startRequest:(NHCGetMemerinfo)requestBlock;
@property (nonatomic, copy) NSString *memberId;
@end
