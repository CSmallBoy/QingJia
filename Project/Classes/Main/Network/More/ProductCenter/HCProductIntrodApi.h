//
//  HCProductIntrodApi.h
//  Project
//
//  Created by 朱宗汉 on 15/12/16.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

@class HCProductIntroductionInfo;

typedef void(^HCProductBlock)(HCRequestStatus requestStatus, NSString *message, HCProductIntroductionInfo *info);

@interface HCProductIntrodApi : HCRequest

- (void)startRequest:(HCProductBlock)requestBlock;
@end
