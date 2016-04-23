//
//  HCGetMedicalApi.h
//  Project
//
//  Created by 朱宗汉 on 16/4/23.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"


typedef void(^HCGetMedicalBlock) (HCRequestStatus requestStatus,NSString *message,id respone);

@interface HCGetMedicalApi : HCRequest

@property (nonatomic,strong) NSString *objectId;

-(void)startRequest:(HCGetMedicalBlock)requestBlock;
@end
