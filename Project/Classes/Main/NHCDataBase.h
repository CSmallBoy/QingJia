//
//  NHCDataBase.h
//  钦家
//
//  Created by 朱宗汉 on 16/5/11.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
@interface NHCDataBase : NSObject


//打开数据库
+(void)openDatabase;
//获取头的组
+(NSArray *)getMainTableName:(int)groupID;
//获取每行内容
+(NSArray *)getTabelHeadRowData:(NSString *)name;
//点菜的数量
//+(void)getOrderNumber:(menuModel *)model;
//huoqu 点菜数量
+(int)getOrderCount;
//取出所有点过的菜
+(NSArray*)getOrderAll;
//修改指定的id 的菜的数量
+(void)updateOrder:(int)menuNum : (int)orderID;
//修改指定的id 的菜的备注信息
+(void)updateOrderRemark:(NSString *)remark :(int)orderID;
//删除已经点过的某道菜
+(void)deleteOrder:(int)orderId;

//插入历史记录
+(int)insertGroup:(NSString *)date :(NSString*)time :(NSString*)room;
//保存已经点过的菜
+(void)saveOrderModel:(int)maXID;
//取出所有的历史记录
+(NSArray *)getHistoryJL;
//取出对应记录的菜
+(NSArray *)getHistoryJLModel:(int)groupId;
@end
