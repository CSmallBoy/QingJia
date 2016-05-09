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
@property (nonatomic,copy) NSString *imageName;
//点赞人数
@property (nonatomic,copy) NSArray *arring;
- (void)startRequest:(NHCHomeDetailBlock)requestBlock;
@end
