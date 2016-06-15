//
//  HCCreateAllFamily.h
//  钦家
//
//  Created by 殷易辰 on 16/6/7.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCCreateAllFamily : NSObject

@property (nonatomic, copy) NSString *familyId;
@property (nonatomic, copy) NSString *isCreator;
@property (nonatomic, copy) NSString *ancestralHome;
@property (nonatomic, copy) NSString *familyNickName;
@property (nonatomic, copy) NSString *familyDescription;
@property (nonatomic, copy) NSString *contactAddr;
@property (nonatomic, copy) NSString *memberCount;
@property (nonatomic, strong) NSMutableArray *members;



@end
