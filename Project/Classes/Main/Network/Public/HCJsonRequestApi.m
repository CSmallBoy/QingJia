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

- (instancetype)initWithBody:(id)body
{
    self = [super init];
    if (self)
    {
        _body = [body copy];
    }
    return self;
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGet;
}


- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeJSON;
}

- (id)requestArgument {
    return _body;
}


@end
