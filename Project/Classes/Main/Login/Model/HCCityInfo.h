//
//  HCCityInfo.h
//  钦家
//
//  Created by Tony on 16/5/18.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCCityInfo : NSObject

@property (nonatomic,copy)NSString *regionId;//城市ID
@property (nonatomic,copy)NSString *regionName;//城市名
@property (nonatomic,strong)NSArray *regions;//下属地区

@end
