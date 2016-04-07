//
//  applyList.h
//  Project
//
//  Created by 朱宗汉 on 16/4/6.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

typedef void(^applyListBlock) (HCRequestStatus requestStatus,NSString *message,id respone);

@interface HCFamilyapplyList : HCRequest

@property (nonatomic,strong) NSString *endUserId;
@property (nonatomic,strong) NSString *familyId;

-(void)startRequest:(applyListBlock)requestBlock;

@end
