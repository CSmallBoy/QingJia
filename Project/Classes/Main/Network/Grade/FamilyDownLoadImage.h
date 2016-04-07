//
//  FamilyDownLoadImage.h
//  Project
//
//  Created by 朱宗汉 on 16/4/7.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"
typedef void(^FamilyDownLoadImageBlock)(HCRequestStatus requestStatus, NSString *message, id respone);
@interface FamilyDownLoadImage : HCRequest

@property (nonatomic,strong) NSString *familyId ;

-(void)startRequest:(FamilyDownLoadImageBlock)requestBlock;

@end
