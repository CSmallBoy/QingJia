//
//  HCFunctionTagView.h
//  Project
//
//  Created by 陈福杰 on 15/12/16.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HCFunctionTagViewDelegate <NSObject>

- (void)hcfunctionTagViewButtonIndex:(NSInteger)index;

@end

@interface HCFunctionTagView : UIView

@property (nonatomic, strong) NSArray *valueArr;

@property (nonatomic,strong) NSMutableArray *valueLableArr;

@property (nonatomic, weak) id<HCFunctionTagViewDelegate>delegate;

- (void)functionTagWithArrary:(NSArray *)array;

@end
