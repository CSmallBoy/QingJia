//
//  segmentCell.m
//  Project
//
//  Created by 朱宗汉 on 16/3/18.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "segmentCell.h"

@interface segmentCell ()
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UIView *smallView;
@end
@implementation segmentCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    segmentCell *cell = [[segmentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    [cell addSubviews];
    return cell;
}


-(void)addSubviews
{


    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:@"退货选择  M-Talk烫印机"];
    [attStr addAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(0, 4)];
    self.textLabel.attributedText = attStr;
    
    
    
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(35, 0, 35, 20)];
    self.smallView  =[[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-115, 11, 105, 20)];
    
    self.smallView.layer.borderWidth = 1;
    self.smallView.layer.borderColor = kHCBackgroundColor.CGColor;
    ViewRadius(self.smallView, 5);
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setTitle:@"-" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button1.layer.borderWidth = 1;
    [button1 addTarget:self action:@selector(minusNum) forControlEvents:UIControlEventTouchUpInside];
    button1.frame = CGRectMake(0, 0, 35, 20);
    
    
    self.label.text =@"1";
    self.label.textColor = [UIColor blackColor];
    self.label.textAlignment = NSTextAlignmentCenter;
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button3 setTitle:@"+" forState:UIControlStateNormal];
    [button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button3.layer.borderWidth =1;
    button3.frame = CGRectMake(70, 0, 35, 20);
    
    [self.smallView addSubview:button1];
    [self.smallView  addSubview:self.label];
    [self.smallView  addSubview:button3];
    
    [self addSubview:self.smallView ];

}

@end
