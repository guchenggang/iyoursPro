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

+ (BOOL) initDatabase
{
    BOOL flag = YES;
    
    /* 创建数据库  */
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"iyours.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath] ;

    
    if (![db open]) {
        NSLog(@"Could not open db ");
        return NO;
    }
    
    [db executeUpdate:@"create table if not exists course (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,userid VARCHAR(200)  NULL,courseid VARCHAR(50), coursename VARCHAR(100), logourl VARCHAR(200));"];
    
    [db executeUpdate:@"create table if not exists category (id INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT,cateid VARCHAR(200)  NULL,catename VARCHAR(200)  NULL,courseid VARCHAR(200)  NULL,logourl VARCHAR(200));"];
    
    [db executeUpdate:@"create table if not exists resproperty (id INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT,propid VARCHAR(200)  NULL,propname VARCHAR(200)  NULL,parentid VARCHAR(200)  NULL,courseid VARCHAR(200)  NULL,ordernum INTEGER  NULL);"];
    

    [db close];
    
    return flag;
};

@end
