//
//  NHCMySelfTimeListApi.h
//  Project
//
//  Created by 朱宗汉 on 16/4/25.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"
typedef void (^NHCListTime)(HCRequestStatus resquestStatus,NSString *message,id  Data);
@interface NHCMySelfTimeListApi : HCRequest
- (void)startRequest:(NHCListTime)requestBlock;
@property (nonatomic,copy)NSString *start_num;
@property (nonatomic,copy)NSString *home_conut;
//个人时光
@property (nonatomic,copy)NSString *MyselfuserID;
@end
