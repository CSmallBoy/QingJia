//
//  NHCUSerInfoApi.h
//  Project
//
//  Created by 朱宗汉 on 16/3/23.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"
#import "MyselfInfoModel.h"
@class MyselfInfoModel;
typedef void(^NHCUserInfo)(HCRequestStatus requestStatus, NSString *message, NSString *chineseZodiac);
@interface NHCUSerInfoApi : HCRequest
- (void)startRequest:(NHCUserInfo)requestBlock;
@property (nonatomic,strong) MyselfInfoModel *myModel;
@end
