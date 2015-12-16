//
//  HCertificateInfo.h
//  HealthCloud
//
//  Created by Vincent on 15/9/22.
//  Copyright © 2015年 www.bsoft.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCertificateInfo : NSObject<NSMutableCopying>

@property (nonatomic, strong) NSString      *certificateNo;     // 证件号，必须
@property (nonatomic, strong) NSString      *certificateType;   // 证件类别代码，必须
@property (nonatomic, strong) NSString      *source;            // 发证机构代码，可选，默认中国
@property (nonatomic, strong) NSString      *certificateTypeText;
@property (nonatomic, strong) NSString      *sourceText;

@end
