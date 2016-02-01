//
//  HCpromisedNormalImageCell.h
//  Project
//
//  Created by 朱宗汉 on 16/1/6.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^textFieldTextBlock1) (NSString * textFieldText ,NSIndexPath * indexPath);

@interface HCpromisedNormalImageCell : UITableViewCell

@property(nonatomic,assign)NSIndexPath *  indexPath;
@property(nonatomic,strong)NSString * title;
@property(nonatomic,strong)NSString * detail;
@property(nonatomic,assign)BOOL   isBlack;
@property(nonatomic,strong)textFieldTextBlock1  textFieldBlock;
@property(nonatomic,copy)NSString  *text;
+(instancetype)CustomCellWithTableView:(UITableView *)tableView;


@end
