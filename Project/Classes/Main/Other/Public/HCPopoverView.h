//
//  PopoverView.h
//  ArrowView
//
//  Created by guojiang on 4/9/14.
//  Copyright (c) 2014年 LINAICAI. All rights reserved.
//

//CGPoint point = CGPointMake(sender.frame.origin.x + sender.frame.size.width/2, sender.frame.origin.y + sender.frame.size.height);
//NSArray *titles = @[@"item1", @"选项2", @"选项3"];
//NSArray *images = @[@"28b.png", @"28b.png", @"28b.png"];
//PopoverView *pop = [[PopoverView alloc] initWithPoint:point titles:titles images:images];
//pop.selectRowAtIndex = ^(NSInteger index){
//    NSLog(@"select index:%d", index);
//};
//[pop show];

#import <UIKit/UIKit.h>

@interface HCPopoverView : UIView

-(id)initWithPoint:(CGPoint)point titles:(NSArray *)titles images:(NSArray *)images;
-(void)show;
-(void)dismiss;
-(void)dismiss:(BOOL)animated;

@property (nonatomic, assign) BOOL showAngle;
@property (nonatomic, copy) UIColor *borderColor;
@property (nonatomic, copy) void (^selectRowAtIndex) (NSInteger index);

@end
