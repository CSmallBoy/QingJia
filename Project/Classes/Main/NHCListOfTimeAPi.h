//
//  NHCListOfTimeAPi.h
//  Project
//
//  Created by 朱宗汉 on 16/4/7.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"
typedef void (^NHCListTime)(HCRequestStatus resquestStatus,NSString *message,id  Data);
@interface NHCListOfTimeAPi : HCRequest
- (void)startRequest:(NHCListTime)requestBlock;
@property (nonatomic,copy)NSString *start_num;
@end
