//
//  ValidationJoinApply.h
//  Project
//
//  Created by 朱宗汉 on 16/4/6.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

typedef void (^ValidationJoinApplyBlock) (HCRequestStatus statusStatus,NSString *message,id respone);

@interface HCFamilyValidationJoinApply : HCRequest

@property (nonatomic,strong) NSString *applyUserId;

-(void)startRequest:(ValidationJoinApplyBlock)requestBlock;

@end
