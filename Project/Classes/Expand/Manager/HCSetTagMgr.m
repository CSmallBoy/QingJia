//
//  HCSetTagMgr.m
//  钦家
//
//  Created by Tony on 16/5/19.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "HCSetTagMgr.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import "HCCityInfo.h"
#import "JPUSHService.h"
#import "HCSetPushTagApi.h"

static HCSetTagMgr *_sharedManager = nil;

@interface HCSetTagMgr ()<AMapLocationManagerDelegate>

@property (nonatomic,strong) NSMutableArray *allCitysArr;//所有城市
@property (nonatomic,strong) AMapLocationManager *locationManager;//定位
@property (nonatomic,copy)NSString *cityString;//定位的城市
@property (nonatomic,copy)NSString *currentAddress;//地址
@property (nonatomic,copy)NSString *currentLocation;//经纬度

@property (nonatomic,strong)NSTimer *timer;//定时器
@property (nonatomic,assign)NSInteger times;//记录定位的次数

@end


@implementation HCSetTagMgr

+ (instancetype)manager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[HCSetTagMgr alloc] init];
    });
    
    return _sharedManager;
}


#pragma mark - location
- (void)setPushTag
{
//    [AMapLocationServices sharedServices].apiKey = @"20e897d0e7d653770541a040a12065d8";
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager setAllowsBackgroundLocationUpdates:YES];//iOS9(含)以上系统需设置
    [self setupTimeLocation];
}

- (void)setupTimeLocation
{
    self.times = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(startUpdatingLocation) userInfo:nil repeats:YES];
}

- (void)startUpdatingLocation
{
    self.times++;
    if (self.times < 2)
    {
        [self.locationManager startUpdatingLocation];
    }
    else
    {
        [self.timer invalidate];
    }
}

#pragma mark - AMapLocationManager Delegate

- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error
{
    self.cityString = @"上海市";
    self.currentAddress = @"上海市闵行区集心路37号";
    self.currentLocation = @"31.232,37.2242";
    [self getCityFromPlist];
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (!IsEmpty(placemarks))
        {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            self.cityString = placemark.locality;
            self.currentAddress = placemark.name;
            self.currentLocation = [NSString stringWithFormat:@"%f,%f", location.coordinate.longitude, location.coordinate.latitude];
            [self getCityFromPlist];
        }
    }];
    
    [self.locationManager stopUpdatingLocation];
    
}


#pragma mark - getCityFromPlist

- (void)getCityFromPlist
{
    [self.allCitysArr removeAllObjects];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path =[paths objectAtIndex:0];
    NSString *cityList =[path stringByAppendingPathComponent:@"city.plist"];
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:cityList];
    
    //取出所有的城市
    NSArray *allProvinceArr = dic[@"regionData"];
    for (NSDictionary *aDic in allProvinceArr)
    {
        NSString *fullName = aDic[@"regionName"];
        NSString *lastWord = [fullName substringFromIndex:[fullName length]-1];
        if ([lastWord isEqualToString:@"市"])
        {
            HCCityInfo *info = [HCCityInfo mj_objectWithKeyValues:aDic];
            [self.allCitysArr addObject:info];
        }
        else
        {
            NSArray *regions = aDic[@"regions"];
            for (NSDictionary *regionDic in regions)
            {
                HCCityInfo *info = [HCCityInfo mj_objectWithKeyValues:regionDic];
                [self.allCitysArr addObject:info];
            }
        }
    }
    [self startSetPushTag];
}


- (void)startSetPushTag
{
    NSString *userTag = [HCAccountMgr manager].loginInfo.PhoneNo;
    NSString *locationTag = @"";
    for (HCCityInfo *info in self.allCitysArr)
    {
        if ([self.cityString isEqualToString:info.regionName])
        {
            locationTag = [NSString stringWithFormat:@"Location_%@", info.regionId];
        }
    }
    
    NSSet *tags = [NSSet setWithObjects:userTag, locationTag,nil];
    NSSet *set = [JPUSHService filterValidTags:tags];
    [JPUSHService setTags:set alias:nil fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias)
     {
         NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, iTags , iAlias);
         if (iResCode == 0)
         {
             NSString *tag1 = @"";
             NSString *tag2 = @"";
             NSEnumerator *enumerator = [iTags objectEnumerator];
             for (NSString *obj in enumerator)
             {
                 BOOL result = [Utils checkPhoneNum:obj];
                 if (result)
                 {
                     tag1 = obj;
                 }
                 else
                 {
                     tag2 = obj;
                 }
             }
             [self setTagToServiceByUserTag:tag1 locationTag:tag2];
         }
         
     }];
}

- (void)setTagToServiceByUserTag:(NSString *)userTag locationTag:(NSString *)locationTag
{
    HCSetPushTagApi *api = [[HCSetPushTagApi alloc] init];
    api.userTag = userTag;
    api.locationTag = locationTag;
    api.currentAddress = self.currentAddress;
    api.currentLocation = self.currentLocation;
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, id respone) {
        if (requestStatus == HCRequestStatusSuccess)
        {
            NSLog(@"向服务器设置tag成功");
        }
    }];
}

- (NSMutableArray *)allCitysArr
{
    if (_allCitysArr == nil)
    {
        _allCitysArr = [NSMutableArray array];
    }
    return _allCitysArr;
}


@end
