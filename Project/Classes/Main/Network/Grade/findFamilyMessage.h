//
//  findFamilyMessage.h
//  Project
//
//  Created by 朱宗汉 on 16/4/6.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

typedef void(^findFamilyMessageBlock) (HCRequestStatus requestStatus,NSString *message,id respone);

@interface findFamilyMessage : HCRequest

@property (nonatomic,strong) NSString *familyId;

-(void)startRequest:(findFamilyMessageBlock)requestBlock;

@end
