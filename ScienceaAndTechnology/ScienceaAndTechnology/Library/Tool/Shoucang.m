//
//  Shoucang.m
//  ScienceaAndTechnology
//
//  Created by scjy on 16/3/10.
//  Copyright © 2016年 韩苇棋. All rights reserved.
//

#import "Shoucang.h"
#import <sqlite3.h>
@interface Shoucang (){
    NSString *path;
}

@end
@implementation Shoucang

static Shoucang *dbPoint = nil;
+(Shoucang *)sharedInstance{

    if (dbPoint == nil) {
        dbPoint = [[Shoucang alloc] init];
    }
    return dbPoint;
}
static sqlite3 *dataBase = nil;

//创建数据库表
- (void)createDataBase{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    path = [documentPath stringByAppendingPathComponent:@"shoucang.rdb"];
    NSLog(@"%@",path);

}
//打开数据库表
- (void)openDataBase{
    if (dataBase != nil) {
        return;
    }
    [self createDataBase];
    int result = sqlite3_open([path UTF8String], &dataBase);
    if (result == SQLITE_OK) {
        NSLog(@"数据库打开成功");
        //数据库打开之后去创建数据库表
        [self createDataBaseTable];
    }else{
        NSLog(@"数据库打开失败");
    }

}

//创建数据库表
- (void)createDataBaseTable{
    NSString *sql = @"creat table shoucang(title text,subTitle text,Titleimage text)";
    sqlite3_exec(dataBase, sql.UTF8String, NULL, NULL, NULL);
    
}

//关闭数据库表
- (void)closeDataBase{
    int result =  sqlite3_close(dataBase);
    if (result == SQLITE_OK) {
        NSLog(@"数据库关闭成功");
    }else{
        NSLog(@"数据库关闭失败");
    }
}

//插入一个新的联系人
-(void)insertIntoNewModel:(Model *)model{
    [self openDataBase];
    sqlite3_stmt *stmt = nil;
    NSString *sql = @"insert into shoucang(title,subTitle,Titleimage)values(?,?,?)";
    int result = sqlite3_prepare_v2(dataBase,sql.UTF8String,-1, &stmt, NULL);
    if (result == SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, model.title.UTF8String, -1, NULL);
        sqlite3_bind_text(stmt, 2, model.subTitle.UTF8String, -1, NULL);
        sqlite3_bind_text(stmt, 3, model.Titleimage.UTF8String, -1, NULL);
        sqlite3_step(stmt);
        NSLog(@"sql语句没有问题");
        
    }else{
        NSLog(@"sql语句有问题");
    }
    //释放掉
    sqlite3_finalize(stmt);
  

}

//查询 所有联系人
- (NSMutableArray *)select{
    
    [self openDataBase];
     sqlite3_stmt *stmt = nil;
     NSString *sql = @"select *from shoucang";
    int result = sqlite3_prepare_v2(dataBase,sql.UTF8String,-1, &stmt, NULL);
    NSMutableArray *arr = [NSMutableArray new];
    if (result == SQLITE_OK) {
          while (sqlite3_step(stmt)==SQLITE_ROW) {
              NSMutableDictionary *dic = [NSMutableDictionary new];
                //获取数据
//                const unsigned char *title = sqlite3_column_text(stmt,0);
//                const unsigned char *subTitle = sqlite3_column_text(stmt, 1);
//                const unsigned char *Titleimage = sqlite3_column_text(stmt, 2);
              
              NSString *title = [NSString stringWithUTF8String:(const char*)sqlite3_column_text(stmt, 1)];
              [dic setValue:title forKey:@"title"];
              
              NSString *subTitle = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
              [dic setValue:subTitle forKey:@"subTitle"];
              NSString *image = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)];
              [dic setValue:image forKey:@"Titleimage"];
              [arr addObject:dic];
            }
        
    }else{
        NSLog(@"查询失败");
    }
    sqlite3_finalize(stmt);
    return arr;
}

@end
