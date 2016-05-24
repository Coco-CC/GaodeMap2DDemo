//
//  CFDB.m
//  GaodeMap3D
//
//  Created by DIT on 16/5/23.
//  Copyright © 2016年 Coco. All rights reserved.
//

#import "CFDB.h"
#import <sqlite3.h>
@implementation CFDB

static CFDB *manager = nil;
//创建单例
+(instancetype)manager{
    @synchronized(self){
        if (manager == nil) {
            manager = [[CFDB alloc]init];
        }
    }
    return manager;
}
//获取document路径
-(NSString *)documents{
    return NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
}

//创建数据库
static sqlite3 *DB = nil;
-(BOOL)openDB{
    NSString *sqlPath = [[self documents] stringByAppendingPathComponent:@"stuDB.sqlite"];
    NSLog(@"%@",sqlPath);
    int result = sqlite3_open(sqlPath.UTF8String, &DB);
    if (result == SQLITE_OK) {
        NSLog(@"打开数据库成功");
        return YES;
    }else{
        NSLog(@"打开数据库失败");
        return NO;
    }
}
-(void)closeDB{
    //关闭数据库
    int  resutl =  sqlite3_close(DB);
    if (resutl == SQLITE_OK) {
        
        NSLog(@"关闭成功");
    }else{
        NSLog(@"关闭失败");
    }
}
//创建表


-(void)createTable{
    //sqlite中的sql语句不区分大小写，文本类型用单引号
    //创建表，如果表存在则创建失败，IF NOT EXISTS 表示当表不存在时才创建
    NSString *sql = @"CREATE TABLE  IF NOT EXISTS mapLocation (id INTEGER PRIMARY KEY AUTOINCREMENT, gpsLongitude TEXT, gpsLatitude TEXT, gaodeLongitude TEXT,gaodeLatitude TEXT, mapDescription TEXT)";
    //执行sql语句  sqlite3_exec ，返回结果整形
    int result = sqlite3_exec(DB, sql.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"创建表成功");
    }else{
        NSLog(@"创建表失败");
    }
}
-(void)insertDataWithGpsLongitude:(NSString *)gpsLongitude GpsLatitude:(NSString *)gpsLatitude GaodeLongitude:(NSString *)gaodeLongitude GaodeLatitude:(NSString *)gaodeLatitude MapDescription:(NSString *)mapDescription  results:(void(^)())results  ailure:(void(^)())failure{
    //创建sql语句 ，sqlist3——exec(数据库指针，sql语句的utf8，NULL，NULL，NULL) 返回整形结果
    // NSString *sql = @"INSERT INTO student(name,sex,age) VALUES ('张飞','男','18')";
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO mapLocation(gpsLongitude,gpsLatitude,gaodeLongitude,gaodeLatitude,mapDescription) VALUES ('%@','%@','%@','%@','%@')",gpsLongitude,gpsLatitude,gaodeLongitude,gaodeLatitude,mapDescription];
    int result = sqlite3_exec(DB, sql.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        
        NSLog(@"插入成功");
        
        results();
    }else{
        NSLog(@"插入失败");
        failure();
    }
}

@end
