//
//  HCCityInfoMgr.m
//  钦家
//
//  Created by Tony on 16/5/27.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCCityInfoMgr.h"
#import "HCCityInfo.h"

static HCCityInfoMgr *_shareManager = nil;

@implementation HCCityInfoMgr

+ (HCCityInfoMgr *)manager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareManager = [[HCCityInfoMgr alloc] init];
    });
    
    return _shareManager;
}


- (NSMutableDictionary *)getAllProvinces
{
    //文件路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path =[paths objectAtIndex:0];
    NSString *cityList =[path stringByAppendingPathComponent:@"city.plist"];
    
    NSDictionary *Dic = [NSDictionary dictionaryWithContentsOfFile:cityList];
    NSArray *provinces = [Dic objectForKey:@"regionData"];
    
    NSMutableDictionary *provincesDic = [NSMutableDictionary dictionary];
    //便利所有的省份
    for (NSDictionary *aDic in provinces)
    {
        //每个省的信息
        HCCityInfo *info = [HCCityInfo mj_objectWithKeyValues:aDic];
        //储存每个省下属的市的信息
        NSMutableDictionary *cityDic = [NSMutableDictionary dictionary];
        //便利每个省下属所有的市
        for (NSDictionary *adic in info.regions)
        {
            //每个市的信息
            HCCityInfo *subInfo = [HCCityInfo mj_objectWithKeyValues:adic];
            //储存每个市下属县的信息
            NSMutableArray *countyArr = [NSMutableArray array];
            //便利每个市下属所有的县
            for (NSDictionary *subDic in subInfo.regions)
            {
                HCCityInfo *countyInfo = [HCCityInfo mj_objectWithKeyValues:subDic];
                [countyArr addObject:countyInfo];
            }
            [cityDic setObject:countyArr forKey:subInfo.regionName];
        }
        
        [provincesDic setObject:cityDic forKey:info.regionName];
    }
    return provincesDic;
}
@end
