//
//  NHCHomeCommentsApi.h
//  Project
//
//  Created by 朱宗汉 on 16/4/9.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

@interface NHCHomeCommentsApi : HCRequest
@property (nonatomic,copy)NSString *Timesid;
@property (nonatomic,copy)NSString *content;
@property (nonatomic,copy)NSString *createLocation;
@property (nonatomic,copy)NSString *createAddrSmall;
@property (nonatomic,copy)NSString *ToUserId;
@end
