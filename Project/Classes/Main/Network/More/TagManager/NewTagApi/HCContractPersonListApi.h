//
//  HCContractPersonListApi.h
//  Project
//
//  Created by 朱宗汉 on 16/4/11.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

// -------------------紧急联系人列表----------------------

typedef void(^HCContractPersonListBlock) (HCRequestStatus requestStatus,NSString *message,id respone);

@interface HCContractPersonListApi : HCRequest

-(void)startRequest:(HCContractPersonListBlock)requestBlock;

@end
