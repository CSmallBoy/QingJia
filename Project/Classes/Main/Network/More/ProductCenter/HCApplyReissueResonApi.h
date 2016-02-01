//
//  HCApplyReissueResonApi.h
//  Project
//
//  Created by 朱宗汉 on 15/12/30.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCRequest.h"


typedef void(^HCApplyReissueResonBlock)(HCRequestStatus requestStatus, NSString *message, id data);
@interface HCApplyReissueResonApi : HCRequest

- (void)startRequest:(HCApplyReissueResonBlock)requestBlock;

@end
