//
//  NHCDownloadImageApi.h
//  Project
//
//  Created by 朱宗汉 on 16/4/6.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"
typedef void(^NHCDownImage)(HCRequestStatus requestStatus, NSString *message, NSString *photostr);
@interface NHCDownloadImageApi : HCRequest
@property (nonatomic,copy) NSString * type;
@property (nonatomic,copy) NSString * photoStr;
- (void)startRequest:(NHCDownImage)requestBlock;
@end
