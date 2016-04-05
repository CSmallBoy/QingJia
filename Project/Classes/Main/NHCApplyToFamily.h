//
//  NHCApplyToFamily.h
//  Project
//
//  Created by 朱宗汉 on 16/3/25.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"
typedef void(^NHCCreatFamilyID) (HCRequestStatus requestStatus, NSString *message, HCLoginInfo *loginInfo);
@interface NHCApplyToFamily : HCRequest
-(void)startRequest:(NHCCreatFamilyID)requestBlock;
@end
