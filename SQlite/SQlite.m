//
//  SQlite.m
//  SQlite
//
//  Created by 冯麟 on 15/12/19.
//  Copyright (c) 2015年 Lusyfa. All rights reserved.
//

#import "SQlite.h"
#import <sqlite3.h>
#import "Student.h"

static SQlite * database = nil;
@implementation SQlite{
    sqlite3 * sqliteDatabase;
}

+(instancetype)shareDataBase{
    
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        database = [[SQlite alloc]init];
    });
    
    return database;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    if (database == nil) {
        database = [super allocWithZone:zone];
    }
    
    return database;
}

-(void)openDB{
    
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    
    NSString * filePath = [path stringByAppendingPathComponent:@"hehe.db"];
    
    
    int is = sqlite3_open([filePath UTF8String], &sqliteDatabase);
    
    if (is == SQLITE_OK) {
        NSLog(@"打开数据库成功");
        
        [self initTable];
        
    }else{
        NSLog(@"打开数据库失败");
    }
    
}


-(void)initTable{

    const char * sqString = "CREATE TABLE student(sid INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,age TEXT,sex TEXT)";
    
    sqlite3_stmt * statement;
    
    sqlite3_prepare_v2(sqliteDatabase, sqString, -1, &statement, nil);
    
    int is = sqlite3_step(statement);
    if (is == SQLITE_OK) {
        NSLog(@"创建表格成功");
    }else{
        NSLog(@"创建表格失败");
    }

    sqlite3_finalize(statement);
    
}


-(void)addMesage:(Student *)model{
    
    const char * sqString = "INSERT INTO student(null,?,?,?)";
    
    sqlite3_stmt * statement;
    
    sqlite3_prepare_v2(sqliteDatabase, sqString, -1, &statement, nil);
    
    sqlite3_bind_text(statement, 1, [model.name UTF8String], -1, SQLITE_TRANSIENT);
    
    sqlite3_bind_text(statement, 2, [model.age UTF8String], -1, SQLITE_TRANSIENT);

    sqlite3_bind_text(statement, 3, [model.sex UTF8String], -1, SQLITE_TRANSIENT);

    
    int is = sqlite3_step(statement);
    if (is == SQLITE_OK) {
        NSLog(@"添加成功");
    }else{
        NSLog(@"添加失败");
    }
    
    sqlite3_finalize(statement);
    [self closeDB];

}


-(void)deleteDB:(int) num{
    
    const char * sqString = "DELETE FROM student WHERE sid = ?";
    
    sqlite3_stmt * statement;

    sqlite3_prepare_v2(sqliteDatabase, sqString, -1, &statement, nil);

    
    sqlite3_bind_int(statement, 1, num);
    
    int is = sqlite3_step(statement);
    if (is == SQLITE_OK) {
        NSLog(@"删除成功");
    }else{
        NSLog(@"删除失败");
    }
    
    sqlite3_finalize(statement);
    [self closeDB];

    
}

-(void)editDB:(Student *)model{

    const char * sqString = "UPDATE student SET name = ?,age = ?,sex = ? WHERE sid = ?";
    
    sqlite3_stmt * statement;

    sqlite3_prepare_v2(sqliteDatabase, sqString, -1, &statement, nil);

    
    sqlite3_bind_text(statement, 1, [model.name UTF8String], -1, SQLITE_TRANSIENT);
    
    sqlite3_bind_text(statement, 2, [model.age UTF8String], -1, SQLITE_TRANSIENT);

    sqlite3_bind_text(statement, 3, [model.sex UTF8String], -1, SQLITE_TRANSIENT);

    sqlite3_bind_int(statement, 4, model.ID);
    
    
    int is = sqlite3_step(statement);
    if (is == SQLITE_OK) {
        NSLog(@"删除成功");
    }else{
        NSLog(@"删除失败");
    }
    
    sqlite3_finalize(statement);

    [self closeDB];

}


-(NSArray *)getDB{

    const char * sqString = "SELECT * FROM studen";
    
    sqlite3_stmt * statement;

    sqlite3_prepare_v2(sqliteDatabase, sqString, -1, &statement, nil);

    NSMutableSet * set = [[NSMutableSet alloc]init];
    
    while (sqlite3_step(statement) == SQLITE_ROW) {
        
        Student * student = [[Student alloc]init];
        
        student.ID = sqlite3_column_int(statement, 0);
        
        char * name = (char*)sqlite3_column_text(statement, 1);
        student.name = [NSString stringWithUTF8String:name];
        
        
        char * age = (char*)sqlite3_column_text(statement, 2);
        student.age = [NSString stringWithUTF8String:age];
        
        char * sex = (char*)sqlite3_column_text(statement, 3);
        student.sex = [NSString stringWithUTF8String:sex];
        
        [set addObject:student];
    }
    
    sqlite3_step(statement);
    
    sqlite3_finalize(statement);

    [self closeDB];
    
    return [[set allObjects]copy];
    
}


-(void)closeDB{
    sqlite3_close(sqliteDatabase);
}



@end
