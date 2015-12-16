//
//  HCDictionaryApi.m
//  HealthCloud
//
//  Created by Vincent on 15/11/3.
//  Copyright © 2015年 www.bsoft.com. All rights reserved.
//

#import "HCDictionaryApi.h"

@implementation HCDictionaryApi
{
    NSString *_url;
    NSString *_parentKey;
    NSString *_sliceType;
}

- (instancetype)initWithURL:(NSString *)url
{
    self = [super init];
    if (self) {
        _url = url;
    }
    return self;
}

- (instancetype)initWithURL:(NSString *)url parentKey:(NSString *)parentKey
{
    self = [super init];
    if (self) {
        _url       = url;
        _parentKey = parentKey;
    }
    return self;
}

- (instancetype)initWithURL:(NSString *)url parentKey:(NSString *)parentKey sliceType:(NSString *)sliceType
{
    self = [super init];
    if (self) {
        _url = url;
        _parentKey = parentKey;
        _sliceType = sliceType;
    }
    return self;
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGet;
}

- (NSString *)requestUrl
{
    if (!IsEmpty(_parentKey)) {
        if (!IsEmpty(_sliceType)) {
            return [NSString stringWithFormat:@"%@.dic?parentKey=%@&sliceType=%@", _url, _parentKey, _sliceType];
        }
        else {
            return [NSString stringWithFormat:@"%@.dic?parentKey=%@", _url, _parentKey];
        }
    }
    else {
        return [NSString stringWithFormat:@"%@.dic", _url];
    }
}

- (NSDictionary *)requestHeaderFieldValueDictionary
{
    return @{@"X-Access-Token" : [HCAccountMgr manager].loginInfo.accessToken};
}


@end
