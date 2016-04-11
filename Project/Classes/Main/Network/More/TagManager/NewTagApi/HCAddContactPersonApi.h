//
//  HCAddContactPersonApi.h
//  Project
//
//  Created by 朱宗汉 on 16/4/11.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"


// -------------------添加紧急联系人----------------------

@class HCTagContactInfo;

typedef void (^HCAddContactPersonBlock) (HCRequestStatus requesStatus,NSString *message,id respone);

@interface HCAddContactPersonApi : HCRequest

@property (nonatomic,strong)HCTagContactInfo *info;

-(void)startRequest:(HCAddContactPersonBlock)requestBlock;

@end
