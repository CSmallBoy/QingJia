//
//  HCJsonRequestApi.m
//  HealthCloud
//
//  Created by Vincent on 15/9/11.
//  Copyright (c) 2015年 www.bsoft.com. All rights reserved.
//

#import "HCJsonRequestApi.h"

@implementation HCJsonRequestApi
{
    NSString        *_serviceId;
    NSString        *_method;
    id              _body;
}

- (id)initWithserviceId:(NSString *)serviceId method:(NSString *)method body:(id)body
{
    self = [super init];
    if (self) {
        _serviceId = serviceId;
        _method = method;
        _body = [body copy];
    }
    return self;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (NSString *)requestUrl {
    return @"*.jsonRequest";
}

- (NSDictionary *)requestHeaderFieldValueDictionary {
    
    if ([HCAccountMgr manager].isLogined) {
        return @{@"X-Access-Token":[HCAccountMgr manager].loginInfo.accessToken,
                 @"X-Service-Id":_serviceId,
                 @"X-Service-Method":_method,
                 @"Content-Type":@"application/json"};
    }
    else {
        return @{@"Content-Type":@"application/json",
                 @"X-Service-Id":_serviceId,
                 @"X-Service-Method":_method};
    }
}

- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeJSON;
}

- (id)requestArgument {
    return _body;
}


@end
