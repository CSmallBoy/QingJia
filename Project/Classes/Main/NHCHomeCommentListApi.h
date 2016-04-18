//
//  NHCHomeCommentListApi.h
//  Project
//
//  Created by 朱宗汉 on 16/4/13.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"
@class HCHomeDetailInfo;

typedef void(^NHCHomeDetailBlock)(HCRequestStatus requestStatus, NSString *message, HCHomeDetailInfo *info);

@interface NHCHomeCommentListApi : HCRequest
@property (nonatomic,copy) NSString *TimeID;
- (void)startRequest:(NHCHomeDetailBlock)requestBlock;
@end
