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

static Shoucang *dataBase = nil;
+(Shoucang *)sharedInstance{

    if (dataBase == nil) {
        dataBase = [[Shoucang alloc] init];
    }
    return dataBase;
}
static sqlite3 *database = nil;

//创建数据库表
- (void)createDataBase{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    path = [documentPath stringByAppendingPathComponent:@"shoucang.rdb"];
    NSLog(@"%@",path);

}
//打开数据库表
- (void)openDataBase{
    if (database != nil) {
        return;
    }else{
        [self createDataBase];//创建数据库
    }
    sqlite3_open([path UTF8String], &database);
    int result = sqlite3_open([path UTF8String], &database);
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
    NSString *sql = @"create table shoucang(title text,subTitle text,Titleimage text)";
    char *error = nil;
    sqlite3_exec(database, [sql UTF8String], NULL, NULL, &error);
    
}

//关闭数据库表
- (void)closeDataBase{
    int result =  sqlite3_close(database);
    if (result == SQLITE_OK) {
        NSLog(@"数据库关闭成功");
        database = nil;
    }else{
        NSLog(@"数据库关闭失败");
    }
}

//插入一个新的联系人
-(void)insertIntoNewModel:(Model *)model{
    [self openDataBase];
    sqlite3_stmt *stmt = nil;
    NSString *sql = @"insert into shoucang(title,subTitle,Titleimage)values(?,?,?)";
    int result = sqlite3_prepare_v2(database,sql.UTF8String,-1, &stmt, NULL);
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

//删除
-(void)deleteModelTitle:(NSString *)title{
    [self openDataBase];
    sqlite3_stmt *stmt = nil;
    NSString *sql = @"delete from shoucang where title = ?";
    int resule = sqlite3_prepare_v2(database,[sql UTF8String], -1, &stmt, NULL);
    if (resule == SQLITE_OK) {
        NSLog(@"删除成功");
        //绑定name的值
        sqlite3_bind_text(stmt, 1, [title UTF8String], -1, NULL);
        //执行
        sqlite3_step(stmt);
    }else{
        NSLog(@"删除失败");
    }
    //释放
    sqlite3_finalize(stmt);
    

}

//查询 所有联系人
- (NSMutableArray *)select{
    
    [self openDataBase];
     NSString *sql = @"select *from shoucang";
    sqlite3_stmt *stmt = nil;
    int result = sqlite3_prepare_v2(database,sql.UTF8String,-1, &stmt, NULL);
    NSMutableArray *arr = [NSMutableArray new];
    if (result == SQLITE_OK) {
          while (sqlite3_step(stmt)==SQLITE_ROW) {
              NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
              const unsigned char *title = sqlite3_column_text(stmt, 0);
              const unsigned char *subTitle = sqlite3_column_text(stmt, 1);
              const unsigned char *imag = sqlite3_column_text(stmt, 2);
              NSString *modeltit = [NSString stringWithUTF8String:(const char *)title];
              NSString *modelsub = [NSString stringWithUTF8String:(const char *)subTitle];
              NSString *modelImage =[NSString stringWithUTF8String:(const char *)imag];
              Model *model = [[Model alloc] init];
              model.title = modeltit;
              model.subTitle = modelsub;
              model.Titleimage = modelImage;
              [dic setObject:model.title forKey:@"title"];
              [dic setObject:model.subTitle forKey:@"subTitle"];
              [dic setObject:model.Titleimage forKey:@"imag"];
              [arr addObject:dic];
            }
        
    }else{
        NSLog(@"查询失败");
    }
    sqlite3_finalize(stmt);
    return arr;
}



@end
