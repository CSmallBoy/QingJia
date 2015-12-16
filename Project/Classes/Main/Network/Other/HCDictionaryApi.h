//
//  HCDictionaryApi.h
//  HealthCloud
//
//  Created by Vincent on 15/11/3.
//  Copyright © 2015年 www.bsoft.com. All rights reserved.
//

#import "HCRequest.h"

@interface HCDictionaryApi : HCRequest

- (instancetype)initWithURL:(NSString *)url;
- (instancetype)initWithURL:(NSString *)url parentKey:(NSString *)parentKey;
- (instancetype)initWithURL:(NSString *)url parentKey:(NSString *)parentKey sliceType:(NSString *)sliceType;

@end
