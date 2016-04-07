//
//  NHCUploadImageApi.h
//  Project
//
//  Created by 朱宗汉 on 16/4/6.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"
typedef void(^NHCUPImage)(HCRequestStatus requestStatus, NSString *message, NSArray *array);
@interface FamilyUploadImageApi : HCRequest
@property (nonatomic,copy) NSString * familyId;
@property (nonatomic,copy) NSString * type;
@property (nonatomic,copy) NSString * photoStr;
- (void)startRequest:(NHCUPImage)requestBlock;
@end
