//
//  NHCDownLoadManyApi.h
//  Project
//
//  Created by 朱宗汉 on 16/4/7.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"
typedef void (^NHCMangDownLoad)(HCRequestStatus requestStatus, NSString *message, NSArray *array);

@interface NHCDownLoadManyApi : HCRequest
@property (nonatomic,copy) NSString * type;
@property (nonatomic,copy) NSString * photoStr;
@property (nonatomic,copy) NSString * TimeID;
-(void)startRequest:(NHCMangDownLoad)requestBlock;
@end
