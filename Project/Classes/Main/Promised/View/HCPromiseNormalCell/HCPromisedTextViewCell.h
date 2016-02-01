//
//  HCPromisedTextViewCell.h
//  Project
//
//  Created by 朱宗汉 on 16/1/6.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCFeedbackTextView.h"
typedef void(^textFieldTextBlock) (NSString * textFieldText ,NSIndexPath * indexPath);

@interface HCPromisedTextViewCell : UITableViewCell

@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *detail;
@property(nonatomic,assign)BOOL   isBlack;
@property(nonatomic,strong)textFieldTextBlock  textFieldBlock;
@property(nonatomic,strong)NSString  *text;
@property(nonatomic,strong) HCFeedbackTextView  *textView;

+(instancetype)CustomCellWithTableView:(UITableView *)tableView;


@end
