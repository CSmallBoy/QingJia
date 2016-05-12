//
//  NHCDataBase.m
//  钦家
//
//  Created by 朱宗汉 on 16/5/11.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

#import "NHCDataBase.h"

@implementation NHCDataBase
//打开
//
//+(void)openDatabase{
//    //沙盒路径
//    NSString *document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
//    //拼接
//    NSString *dataPath = [document stringByAppendingFormat:@"/database.sqlite"];
//    NSLog(@"data == %@",dataPath);
//    //文件管理
//    NSFileManager *manger = [NSFileManager defaultManager];
//    if (![manger fileExistsAtPath:dataPath])//路径不存在 执行下一步
//    {
//        //获取本地路径
//        NSString *path = [[NSBundle mainBundle]pathForResource:@"database" ofType:@".sqlite"];
//        //复制
//        [manger copyItemAtPath:path toPath:dataPath error:nil];
//    }
//    //创建数据库
//    _db = [[FMDatabase alloc]initWithPath:dataPath];
//    [_db open];
//}
////获取主表的名字
//+(NSArray *)getMainTableName:(int)groupID{
//    NSString *sql = [NSString stringWithFormat:@"Select name from groupTable where id = %d",groupID];
//    NSLog(@"123123123123 ==%d",groupID);
//    FMResultSet *set = [_db executeQuery:sql];
//    [set next];
//    NSString *name = [set stringForColumn:@"name"];
//    // NSLog(@"name == %@",name);
//    NSArray *nameArray = [name componentsSeparatedByString:@"|"];
//    //NSLog(@"name == %@",nameArray);
//    [set close];
//    return nameArray;
//}
////获取头的每个cell的信息
//+(NSArray *)getTabelHeadRowData:(NSString *)name{
//    NSString *sql = [NSString stringWithFormat:@"select * from menuTable where iKind = '%@'",name];
//    FMResultSet *set = [_db executeQuery:sql];
//    NSMutableArray *array = [NSMutableArray array];
//    while ([set next]) {
//        menuModel *menModel = [[menuModel alloc]init];
//        menModel.menuID  = [set intForColumn:@"id"];
//        menModel.groupID = [set intForColumn:@"groupID"];
//        menModel.ikind   = [set stringForColumn:@"iKind"];
//        menModel.name    = [set stringForColumn:@"name"];
//        menModel.price   = [set intForColumn:@"price"];
//        menModel.unit    = [set stringForColumn:@"unit"];
//        menModel.detail  = [set stringForColumn:@"detail"];
//        menModel.picName = [set stringForColumn:@"picName"];
//        [array addObject:menModel];
//        // NSLog(@"name //***//== %@",menModel.name);
//    }
//    [set close];
//    return array;
//}
////点菜
//+(void)getOrderNumber:(menuModel *)model{
//    //先查询  在修改
//    NSString *sql = [NSString stringWithFormat:@"select * from orderTable where id = %d",model.menuID];
//    FMResultSet *set = [_db executeQuery:sql];
//    if ([set next]) {
//        //查到之后获取
//        int number= [set intForColumn:@"menuNum"];
//        NSString *updatesql = [NSString stringWithFormat:@"update orderTable set menuNum = %d where id = %d",number+1,model.menuID];
//        [_db executeUpdate:updatesql];
//    }else{
//        NSString *insretsql = [NSString stringWithFormat:@"insert into orderTable (id,menuName,Price,kind,menuNum,remark ) values (%d,'%@',%d,'%@',%d,'%@')",model.menuID,model.name,model.price,model.ikind,1,@"五星好评"];
//        NSLog(@"inser == %@",insretsql);
//        [_db executeUpdate:insretsql];
//    }
//    [set close];
//    
//}
////有几道菜   不是菜的个数
//+(int)getOrderCount{
//    NSString *sql = [NSString stringWithFormat:@"select count(*) from orderTable "];
//    FMResultSet *set = [_db executeQuery:sql];
//    [set next];//zhingxing
//    int count = [set intForColumnIndex:0];
//    NSLog(@"%d",count);
//    [set close];
//    return count;
//    
//    //    while ([set next]) {
//    //        <#statements#>
//    //    }
//    // NSMutableArray *array =[NSMutableArray array ];
//}
////删除已经选择的菜
//+(void)deleteOrder:(int)orderId{
//    NSString *sql = [NSString stringWithFormat:@"delete from orderTable where id = %d",orderId];
//    [_db executeUpdate:sql];
//}
////取出所有点过的菜  对象
//+(NSArray *)getOrderAll{
//    NSString *sql = [NSString stringWithFormat:@"select * from orderTable "];
//    FMResultSet *set = [_db executeQuery:sql];
//    NSMutableArray *arr = [NSMutableArray array ];
//    while ([set next]) {
//        dainModel *orderModer = [[dainModel alloc]init];
//        orderModer.orderID = [set intForColumn:@"id"];
//        orderModer.menuNamne =[set stringForColumn:@"menuName"];
//        orderModer.Price = [set intForColumn:@"Price"];
//        orderModer.remark = [set stringForColumn:@"remark"];
//        orderModer.menuNum = [set intForColumn:@"menuNum"];
//        orderModer.Ikind = [set stringForColumn:@"kind"];
//        [arr addObject:orderModer];
//        
//    }
//    [set close];
//    return arr;
//}
//
//
//
////插入历史记录
//+(int)insertGroup:(NSString *)date :(NSString*)time :(NSString*)room{
//    NSString *sql = [NSString stringWithFormat:@"insert into group_recordTable (date,time,room) values ('%@','%@','%@')",date,time,room];
//    [_db executeUpdate:sql];
//    NSString *sql2 = [NSString stringWithFormat:@"select MAX(id) from group_recordTable"];
//    FMResultSet *set = [_db executeQuery:sql2];
//    [set next];
//    int mun = [set intForColumnIndex:0];
//    [set close];
//    return mun;
//}
////保存已经点过的菜
//+(void)saveOrderModel:(int)maXID{
//    NSArray *array = [self getOrderAll];
//    for (dainModel *model in array) {
//        NSString *sql = [NSString stringWithFormat:@"insert into recordTable (stateNum,menuName,menuPrice,menuKind,menuNum,menuRemark,groupID) values(0,'%@',%d,'%@',%d,'%@',%d)",model.menuNamne,model.Price,model.Ikind,model.menuNum,model.remark,maXID];
//        [_db executeUpdate:sql];
//    }
//    NSString *sql = @"delete from orderTable";
//    [_db executeUpdate:sql];
//}
////取出所有的历史记录
//+(NSArray *)getHistoryJL{
//    NSString *sql = @"select * from group_recordTable";
//    FMResultSet *set = [_db executeQuery:sql];
//    NSMutableArray *array = [NSMutableArray array];
//    while ([set next]) {
//        group *model = [[group alloc] init];
//        model.groupID = [set intForColumn:@"id"];
//        model.date_str = [set stringForColumn:@"date"];
//        model.time_str = [set stringForColumn:@"time"];
//        model.room_str = [set stringForColumn:@"room"];
//        [array addObject:model];
//    }
//    [set close];
//    return array;
//    
//}
////取出对应记录的菜
//+(NSArray *)getHistoryJLModel:(int)groupId{
//    NSString *sql = [NSString stringWithFormat:@"select * from recordTable where groupID = %d",groupId];
//    FMResultSet *set = [_db executeQuery:sql];
//    NSMutableArray *array = [NSMutableArray array];
//    while ([set next]) {
//        dainModel *model = [[dainModel alloc] init];
//        model.menuNamne = [set stringForColumn:@"menuName"];
//        model.Price = [set intForColumn:@"menuPrice"];
//        model.Ikind = [set stringForColumn:@"menuKind"];
//        model.menuNum = [set intForColumn:@"menuNum"];
//        model.remark = [set stringForColumn:@"menuRemark"];
//        [array addObject:model];
//    }
//    [set close];
//    return array;
//    
//}

@end
