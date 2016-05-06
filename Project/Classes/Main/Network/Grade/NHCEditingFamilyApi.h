//
//  NHCEditingFamilyApi.h
//  钦家
//
//  Created by 朱宗汉 on 16/5/6.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCRequest.h"

@interface NHCEditingFamilyApi : HCRequest
@property (nonatomic,copy) NSString * familyId;
@property (nonatomic,copy) NSString * familyNickName;
@property (nonatomic,copy) NSString * imageName;
@property (nonatomic,copy) NSString * ancestralHome;//相当于个性签名  以后再改
@end
