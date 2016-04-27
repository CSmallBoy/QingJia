//
//  lhScanQCodeViewController.h
//  lhScanQCodeTest
//
//  Created by bosheng on 15/10/20.
//  Copyright © 2015年 bosheng. All rights reserved.
//

#import "HCViewController.h"

typedef void(^ScanQCodeBlock) (NSString *message);

@interface lhScanQCodeViewController : HCViewController

@property (nonatomic,assign) BOOL isJoinFamily;
@property (nonatomic,strong) ScanQCodeBlock  block;

@end
