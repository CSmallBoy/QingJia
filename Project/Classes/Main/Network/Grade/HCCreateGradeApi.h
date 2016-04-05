//
//  HCCreateGradeApi.h
//  Project
//
//  Created by 陈福杰 on 16/1/12.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

@class HCCreateGradeInfo;

typedef void(^HCCreateGradeBlock)(HCRequestStatus requestStatus, NSString *message,  id respone);

@interface HCCreateGradeApi : HCRequest

@property (nonatomic, strong) HCCreateGradeInfo *gradeInfo;

@property (nonatomic,strong) NSString *token;

- (void)startRequest:(HCCreateGradeBlock)requestBlock;

@end
