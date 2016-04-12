//
//  HCTagActivateApi.h
//  Project
//
//  Created by 朱宗汉 on 16/4/11.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

// -------------------激活标签----------------------

typedef void (^HCTagActivateBlock) (HCRequestStatus requestStatus,NSString *message,id respone);

@interface HCTagActivateApi : HCRequest

@property (nonatomic,strong) NSString *labelGuid;
@property (nonatomic,strong) NSString *imageName;
@property (nonatomic,strong) NSString *labelTitle;
@property (nonatomic,strong) NSString *objectId;
@property (nonatomic,strong) NSString *contactorId1;
@property (nonatomic,strong) NSString *contactorId2;

-(void)startRequest:(HCTagActivateBlock)requestBlock;

@end
