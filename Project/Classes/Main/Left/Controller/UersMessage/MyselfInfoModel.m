//
//  MyselfInfoModel.m
//  Project
//
//  Created by 朱宗汉 on 16/3/25.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "MyselfInfoModel.h"

@implementation MyselfInfoModel
-(id)mutableCopyWithZone:(NSZone*)zone{
    MyselfInfoModel *model = [[[self class]allocWithZone:zone]init];
    model.nickName = [_nickName mutableCopy];
    model.age = [_age mutableCopy];
    model.birday = [_birday mutableCopy];
    model.adress = [_adress mutableCopy];
    model.company = [_company mutableCopy];
    model.professional = [_professional mutableCopy];
    model.PhotoStr = [_professional mutableCopy];
    return model;
    
}
@end
