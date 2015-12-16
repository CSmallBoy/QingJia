//
//  HCRequest.m
//  HealthCloud
//
//  Created by Vincent on 15/10/27.
//  Copyright © 2015年 www.bsoft.com. All rights reserved.
//

#import "HCRequest.h"
#import "YTKNetworkAgent.h"


//私有定义
//来自服务端定义
#define KCodeStatus           @"code"
#define KMessage              @"msg"
#define KBody                 @"body"
#define kXAuthFailedCode      @"X-Auth-Failed-Code"


@implementation HCRequest

#pragma mark - override Getters

- (NSTimeInterval)requestTimeoutInterval
{
    return 15;
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodPost;
}

- (YTKRequestSerializerType)requestSerializerType
{
    return YTKRequestSerializerTypeJSON;
}

- (NSString *)formatMessage:(HCRequestStatus)statusCode
{
    return @"";
}

/// (封装层) 解析，把服务器返回数据转换想要的数据
//默认返回原 data
//通常解析body内数据
- (id)formatResponseObject:(id)responseObject
{
    return responseObject;
}

#pragma mark - override Methods

- (void)startRequest:(HCRequestBlock)requestBlock
{
    DLog(@"\n%@\n%@\n%@\n",
          [[YTKNetworkAgent sharedInstance] buildRequestUrl:self],
          self.requestHeaderFieldValueDictionary,
          self.requestArgument);
    
    [self startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        [self handleSuccess:requestBlock
             responseObject:request.responseJSONObject
            responseHeaders:request.responseHeaders];
        
    } failure:^(YTKBaseRequest *request) {
        
        [self handleFailure:requestBlock
                      error:request.requestOperation.error
            responseHeaders:request.responseHeaders];
        
    }];
}

#pragma mark - private Method

- (void)handleSuccess:(HCRequestBlock)requestBlock
       responseObject:(id)responseObject
      responseHeaders:(NSDictionary *)responseHeaders
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self printResponseData];
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            // message不可用时为@"", responseObject不可用时为nil
            HCRequestStatus status = [[responseObject objectForKey:KCodeStatus] integerValue];
            
            // 返回错误时, 需要解析message。服务器返回的错误没有用, 因为客户端需要显示中文。
            NSString *message = @"";
            if (status != HCRequestStatusSuccess) {
                message = [self formatMessage:status];
            }
            id object = [self formatResponseObject:responseObject];
            
            if (requestBlock) {
                requestBlock(status, message, object);
            }
        }
    });
}

- (void)handleFailure:(HCRequestBlock)requestBlock error:(NSError *)error responseHeaders:(NSDictionary *)responseHeaders
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (requestBlock) {
            
            DLog(@"\n error: \n %@", error);
            
            // 判断accessToken是否过期
            if (!IsEmpty(responseHeaders[kXAuthFailedCode])) {
                [[NSNotificationCenter defaultCenter] postNotificationName:kHCAccessTokenExpiredNotification object:nil];
                return;
            }
            
            NSString *msg = @"服务器异常，请稍候再试!";
            switch (error.code) {
                case -1000:
                case -1002:
                    msg = @"系统异常，请稍后再试";
                    break;
                case -1001:
                    msg = @"请求超时，请检查您的网络!";
                    break;
                case -1005:
                case -1006:
                case -1009:
                    msg = @"网络异常，请检查您的网络!";
                    break;
                default:
                    break;
            }
            
            requestBlock(HCRequestStatusFailure, msg, nil);
        }
    });
}

#pragma mark - 

- (void)printResponseData
{
    NSData *jsonData;
    if (self.responseJSONObject) {
        jsonData = [NSJSONSerialization dataWithJSONObject:self.responseJSONObject options:NSJSONWritingPrettyPrinted error:nil];
    }
    
    NSString *jsonString;
    if (jsonData) {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }else {
        jsonString = self.responseString;
    }
    
    DLog(@"\n%@\n%@",self.responseHeaders,jsonString);
}


@end
