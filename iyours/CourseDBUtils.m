//
//  CourseDBUtils.m
//  iyours
//
//  Created by gcg on 14-12-19.
//  Copyright (c) 2014年 o-star. All rights reserved.
//

#import "CourseDBUtils.h"
#import "FMDB.h"

@implementation CourseDBUtils


+ (id)openDatabase {
    
    /* 创建数据库  */
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"iyours.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath] ;
    return db;
};

+ (BOOL) initDatabase
{
    BOOL flag = YES;
    
  
    FMDatabase *db = [self openDatabase];
    
    if (![db open]) {
        NSLog(@"Could not open db ");
        return NO;
    }
    
    [db executeUpdate:@"create table if not exists courseinfo (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,userid VARCHAR(200)  NULL,courseid VARCHAR(50), coursename VARCHAR(100), logourl VARCHAR(200));"];
    
    [db executeUpdate:@"create table if not exists category (id INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT,cateid VARCHAR(200)  NULL,catename VARCHAR(200)  NULL,courseid VARCHAR(200)  NULL,logourl VARCHAR(200));"];
    
    [db executeUpdate:@"create table if not exists resproperty (id INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT,propid VARCHAR(200)  NULL,propname VARCHAR(200)  NULL,parentid VARCHAR(200)  NULL,courseid VARCHAR(200)  NULL,ordernum INTEGER  NULL);"];
    

    [db close];
    
    return flag;
};


+ (BOOL) delAllCourseInfo : (NSString *) userId
{

     BOOL flag = YES;
    
    FMDatabase *db = [self openDatabase];
    
    if (![db open]) {
        NSLog(@"Could not open db ");
        return NO;
    }
    
    NSString *sql=[NSString stringWithFormat:@"delete from courseinfo where userid = %@",userId];


   [db executeUpdate:sql];
    
    [db close];

     return flag;
};


+ (BOOL) addCourseInfo : (CourseInfo *) info
{
    
    BOOL flag = YES;
    
    FMDatabase *db = [self openDatabase];
    
    if (![db open]) {
        NSLog(@"Could not open db ");
        return NO;
    }
    
    NSString *sql=[NSString stringWithFormat:@"insert into courseinfo (userid,courseid,coursename,logourl) value (%@,%@,'%@','%@')",info.userId,info.courseId,info.courseName,info.logoUrl];
    
   [db executeUpdate:sql];
    
    [db close];
    
    return flag;
};


@end
