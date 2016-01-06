//
//  HCAccountDBMgr.m
//  HealthCloud
//
//  Created by Vincent on 15/9/23.
//  Copyright © 2015年 www.bsoft.com. All rights reserved.
//

#import "HCAccountDBMgr.h"
#import "FMDB.h"

#define kHCDBTableNeedUpdate    @"kHCDBTableNeedUpdate"   //表单是否需要更新
#define kHCDBTableUser          @"UserInfo"
#define kHCDBName               @"MTalk.sqlite"

static HCAccountDBMgr *_sharedManager = nil;

@interface HCAccountDBMgr ()
/**
 *  具有线程安全的数据队列
 */
@property (nonatomic,strong) FMDatabaseQueue *queue;

@end


@implementation HCAccountDBMgr

//创建单例
+ (instancetype)manager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[HCAccountDBMgr alloc] init];
    });
    
    return _sharedManager;
}

/**
 *  数据库队列的初始化：本操作一个
 */
+(void)initialize{
    
    //取出实例
    HCAccountDBMgr *coreFMDB=[HCAccountDBMgr manager];
    
    //在沙盒中存入数据库文件
    NSString *documentFolder=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *folder=[NSString stringWithFormat:@"%@/%@",documentFolder,@"DB"];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:folder isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) )
    {
        [fileManager createDirectoryAtPath:folder withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *dbPath=[folder stringByAppendingPathComponent:kHCDBName];

    DLog(@"dbPath:%@",dbPath);
    //创建队列
    FMDatabaseQueue *queue =[FMDatabaseQueue databaseQueueWithPath:dbPath];
    
    if(queue==nil)  NSLog(@"code=1：创建数据库失败，请检查");
    
    coreFMDB.queue = queue;
    
    //表单已经更新，需要删除重新创建
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL updated = [[defaults objectForKey:kHCDBTableNeedUpdate] boolValue];
    if (!updated) {
        [coreFMDB dropTable];
        [defaults setObject:@"1" forKey:kHCDBTableNeedUpdate];
        [defaults synchronize];
    }
    
    //创建表单
    [coreFMDB createAccountTable];
}

+ (void)clean
{
    _sharedManager = nil;
}

/**
 *  创建表结构
 *  @return 更新语句的执行结果
 */

- (BOOL)createAccountTable
{
    __block BOOL createRes = NO;
    
    [self.queue inDatabase:^(FMDatabase *db) {

        NSString *sql = [NSString stringWithFormat:
                         @"CREATE TABLE IF NOT EXISTS '%@'(\
                         id INTEGER PRIMARY KEY AUTOINCREMENT,\
                         Token TEXT, \
                         UUID TEXT,\
                         PhoneNo TEXT,\
                         UserName TEXT,\
                         TrueName TEXT,\
                         NickName TEXT,\
                         Sex TEXT,\
                         Age TEXT,\
                         IsFMA TEXT,\
                         DefaultFamilyID TEXT,\
                         UserDescription TEXT,\
                         UserId TEXT, \
                         HomeAddress TEXT, \
                         Company TEXT, \
                         Career TEXT, \
                         UserPhoto TEXT);",
                         kHCDBTableUser];
        createRes = [db executeUpdate:sql];
    }];
    
    return createRes;
}

/**
 *  插入一条数据库
 *
 *  @param 用户信息
 *
 *  @return 更新语句的执行结果
 */
- (BOOL)insertLoginInfo:(HCLoginInfo *)loginInfo
{
    //清空表数据
    [self truncateTable];
    
    NSString *insertSql = [NSString stringWithFormat:@"INSERT INTO '%@'(\
                           Token,\
                           UUID,\
                           PhoneNo,\
                           UserName,\
                           TrueName,\
                           NickName,\
                           Sex,\
                           Age,\
                           IsFMA,\
                           DefaultFamilyID,\
                           UserDescription,\
                           UserId,\
                           HomeAddress,\
                           Company,\
                           Career,\
                           UserPhoto)\
                           VALUES ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@');",
                           kHCDBTableUser,
                           loginInfo.Token,
                           loginInfo.UUID,
                           loginInfo.PhoneNo,
                           loginInfo.UserName,
                           loginInfo.TrueName,
                           loginInfo.NickName,
                           loginInfo.Sex,
                           loginInfo.Age,
                           loginInfo.IsFMA,
                           loginInfo.DefaultFamilyID,
                           loginInfo.UserDescription,
                           loginInfo.UserId,
                           loginInfo.HomeAddress,
                           loginInfo.Company,
                           loginInfo.Career,
                           loginInfo.UserPhoto];
    BOOL res = [self executeUpdate:insertSql];
    return res;
}

/**
 *  更新用户信息
 *
 *  @param 用户信息
 *
 *  @return 更新语句的执行结果
 */
- (BOOL)updateLoginInfo:(HCLoginInfo *)info
{
    if (info.Token) {
        
        NSString *modifySql = [NSString stringWithFormat:@"UPDATE '%@' SET UUID = '%@',PhoneNo = '%@',UserName = '%@',TrueName = '%@',NickName = '%@',Sex = '%@',Age = '%@',IsFMA = '%@',DefaultFamilyID = '%@',UserDescription = '%@', UserPhoto = '%@',HomeAddress = '%@',Company = '%@',Career = '%@',Token = '%@' WHERE UserId = '%@';",kHCDBTableUser,info.UUID,info.PhoneNo,info.UserName,info.TrueName,info.NickName,info.Sex,info.Age,info.IsFMA,info.DefaultFamilyID,info.UserDescription,info.UserPhoto, info.HomeAddress, info.Company, info.Career, info.Token, info.UserId];
        
        return [self executeUpdate:modifySql];
    }
    
    return NO;
}

/**
 *  更新用户信息
 *
 *  @param 用户信息
 *
 *  @return 更新语句的执行结果
 */
- (void)queryLastUserInfo:(HCAccountInfo)accountInfo
{
    [self.queue inDatabase:^(FMDatabase *db) {
        
        NSString *sql = [NSString stringWithFormat:@"select * from '%@';",kHCDBTableUser];
        
        FMResultSet *set = [db executeQuery:sql];
        while ([set next]) {
            HCLoginInfo *loginInfo = [[HCLoginInfo alloc] init];
            
            loginInfo.Token = [set stringForColumn:@"Token"];
            loginInfo.UUID = StringFromObject([set stringForColumn:@"UUID"]);
            loginInfo.PhoneNo = StringFromObject([set stringForColumn:@"PhoneNo"]);
            loginInfo.UserName = StringFromObject([set stringForColumn:@"UserName"]);
            loginInfo.TrueName = StringFromObject([set stringForColumn:@"TrueName"]);
            loginInfo.NickName = StringFromObject([set stringForColumn:@"NickName"]);
            
            loginInfo.Sex = [set stringForColumn:@"Sex"];
            loginInfo.Age = StringFromObject([set stringForColumn:@"Age"]);
            loginInfo.IsFMA = StringFromObject([set stringForColumn:@"IsFMA"]);
            loginInfo.DefaultFamilyID = StringFromObject([set stringForColumn:@"DefaultFamilyID"]);
            loginInfo.UserDescription = StringFromObject([set stringForColumn:@"UserDescription"]);
            loginInfo.UserPhoto = StringFromObject([set stringForColumn:@"UserPhoto"]);
            
            loginInfo.UserId = StringFromObject([set stringForColumn:@"UserId"]);
            loginInfo.HomeAddress = StringFromObject([set stringForColumn:@"HomeAddress"]);
            loginInfo.Company = StringFromObject([set stringForColumn:@"Company"]);
            loginInfo.Career = StringFromObject([set stringForColumn:@"Career"]);

            accountInfo(loginInfo);
            [set close];
            
            return;
        }
        
    }];
    //return NO;
}

/**
 *  执行一个更新语句
 *
 *  @param sql 更新语句的sql
 *
 *  @return 更新语句的执行结果
 */
- (BOOL)executeUpdate:(NSString *)sql{
    
    __block BOOL updateRes = NO;
    
    [self.queue inDatabase:^(FMDatabase *db) {
        
        updateRes = [db executeUpdate:sql];
    }];
    
    return updateRes;
}

/**
 *  清空表（但不清除表结构）
 *
 *  @param table 表名
 *
 *  @return 操作结果
 */
- (BOOL)truncateTable {
    
    return [self executeUpdate:[NSString stringWithFormat:@"DELETE FROM '%@'", kHCDBTableUser]];
}

/**
 *  清空表（同时清除表结构）
 *
 *  @param table 表名
 *
 *  @return 操作结果
 */
- (BOOL)dropTable {
    
    return [self executeUpdate:[NSString stringWithFormat:@"DROP TABLE '%@'", kHCDBTableUser]];
}


@end
