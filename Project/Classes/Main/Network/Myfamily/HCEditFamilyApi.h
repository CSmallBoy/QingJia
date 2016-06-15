//
//  HCEditFamilyApi.h
//  钦家
//
//  Created by 殷易辰 on 16/6/13.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

typedef void(^HCAllFamilyBlock) (HCRequestStatus requestStatus,NSString *message,id respone);

@interface HCEditFamilyApi : HCRequest
@property (nonatomic, copy) NSString *familyId;
@property (nonatomic, copy) NSString *familyNickName;
@property (nonatomic, copy) NSString *familyDescription;
-(void)startRequest:(HCAllFamilyBlock)requestBlock;
@end
