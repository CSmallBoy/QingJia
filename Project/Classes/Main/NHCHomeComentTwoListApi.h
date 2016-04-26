//
//  NHCHomeComentTwoListApi.h
//  Project
//
//  Created by 朱宗汉 on 16/4/25.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"
@class HCHomeDetailInfo;

typedef void(^NHCHomecomentTwo)(HCRequestStatus requestStatus, NSString *message, HCHomeDetailInfo *info);
@interface NHCHomeComentTwoListApi : HCRequest

@property (nonatomic,copy) NSString *TimeID;
@property (nonatomic,copy) NSString *imageName;
- (void)startRequest:(NHCHomecomentTwo)requestBlock;
@end
