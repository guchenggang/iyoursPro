//
//  CourseDBUtils.m
//  iyours
//
//  Created by gcg on 14-12-19.
//  Copyright (c) 2014年 o-star. All rights reserved.
//

#import "CourseDBUtils.h"
#import "FMDB.h"
#import "ResourceCategory.h"
#import "ResProperty.h"

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
   // FMDatabase *db = [FMDatabase databaseWithPath:@"iyours.db"] ;
    
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
    
    NSString *sql=[NSString stringWithFormat:@"delete from courseinfo where userid = '%@'",userId];


   [db executeUpdate:sql];
    
    [db close];

     return flag;
};

+ (BOOL) delAllCategory
{
    
    BOOL flag = YES;
    
    FMDatabase *db = [self openDatabase];
    
    
    if (![db open]) {
        NSLog(@"Could not open db ");
        return NO;
    }
    
    
    
    [db executeUpdate:@"delete from category "];
    
    [db close];
    
    return flag;
};


+ (BOOL) delAllResProperty
{
    BOOL flag = YES;
    
    FMDatabase *db = [self openDatabase];
    
    
    if (![db open]) {
        NSLog(@"Could not open db ");
        return NO;
    }
    
    
    
    [db executeUpdate:@"delete from resproperty "];
    
    [db close];
    
    return flag;
    
}
;

+ (NSArray *) getCourseInfo : (NSString *) userId
{
    
    NSMutableArray  *courseArray = [NSMutableArray arrayWithCapacity:0];
    
    FMDatabase *db = [self openDatabase];
    
    
    if (![db open]) {
        NSLog(@"Could not open db ");
        return nil;
    }
    
    NSString *sql=[NSString stringWithFormat:@"select * from courseinfo where userid = '%@'",userId];

    
    FMResultSet *rs = [db executeQuery:sql];

    while ([rs next]) {
     
        CourseInfo * info = [[CourseInfo alloc] init];
        info.userId = [rs stringForColumnIndex:1];
        info.courseId = [rs stringForColumnIndex:2];
        info.courseName = [rs stringForColumnIndex:3];
        info.logoUrl = [rs stringForColumnIndex:4];
        [courseArray addObject:info];
        
    }
    
    [db close];
    
    return courseArray;
};


+ (NSArray *) getCategory : (NSString *) courseId
{
    
    NSMutableArray  *cateArray = [NSMutableArray arrayWithCapacity:0];
    
    FMDatabase *db = [self openDatabase];
    
    
    if (![db open]) {
        NSLog(@"Could not open db ");
        return nil;
    }
    
    NSString *sql=[NSString stringWithFormat:@"select * from category where courseid = '%@'",courseId];
    
    
    FMResultSet *rs = [db executeQuery:sql];
    
    while ([rs next]) {
        
        ResourceCategory *category = [[ResourceCategory alloc] init];
        category.rescateId = [rs stringForColumnIndex:1];
        category.rescateName = [rs stringForColumnIndex:2];
        category.resId = [rs stringForColumnIndex:3];
        category.logoUrl = [rs stringForColumnIndex:4];
        [cateArray addObject:category];
        
    }
    
    [db close];
    
    return cateArray;
};


+ (NSArray *) getResProperty : (NSString *) courseId

{
    
    NSMutableArray  *propArray = [NSMutableArray arrayWithCapacity:0];
    
    FMDatabase *db = [self openDatabase];
    
    
    if (![db open]) {
        NSLog(@"Could not open db ");
        return nil;
    }
    
    NSString *sql=[NSString stringWithFormat:@"select * from resproperty where courseid = '%@'",courseId];
    
    
    FMResultSet *rs = [db executeQuery:sql];
    
    while ([rs next]) {
        
        ResProperty *resProperty = [[ResProperty alloc] init];
        resProperty.propId = [rs stringForColumnIndex:1];
        resProperty.propName = [rs stringForColumnIndex:2];
        resProperty.parentId = [rs stringForColumnIndex:3];
        resProperty.courseId = [rs stringForColumnIndex:4];
        resProperty.orderNum = [rs stringForColumnIndex:5];
        [propArray addObject:resProperty];
        
    }
    
    [db close];
    
    return propArray;

    
}
;

+ (BOOL) addCourseInfo:(CourseInfo *)info
{
    
    BOOL flag = YES;
    
    FMDatabase *db = [self openDatabase];

    
    if (![db open]) {
        NSLog(@"Could not open db ");
        return NO;
    }
    
    
    
    NSString *sql=[NSString stringWithFormat:@"insert into courseinfo (courseid,coursename,userid,logourl) values ('%@','%@','%@','%@')",info.courseId,info.courseName,info.userId,info.logoUrl];
    
    [db executeUpdate:sql];
    
    [db close];
    
    return flag;
};


+ (BOOL) addCategory : (ResourceCategory *) category
{
    
    BOOL flag = YES;
    
    FMDatabase *db = [self openDatabase];
    
    if (![db open]) {
        NSLog(@"Could not open db ");
        return NO;
    }
    
    
    
    NSString *sql=[NSString stringWithFormat:@"insert into category (cateid,catename,courseid,logourl) values ('%@','%@','%@','%@')",category.rescateId,category.rescateName,category.resId,category.logoUrl];
    
   [db executeUpdate:sql];
    
    [db close];
    
    return flag;
};

+ (BOOL) addResProperty : (ResProperty *) resProperty

{
    
    BOOL flag = YES;
    
    FMDatabase *db = [self openDatabase];
    
    if (![db open]) {
        NSLog(@"Could not open db ");
        return NO;
    }
    
    
    
    NSString *sql=[NSString stringWithFormat:@"insert into resproperty (propid,propname,courseid,parentid,ordernum) values ('%@','%@','%@','%@','%@')",resProperty.propId,resProperty.propName,resProperty.courseId,resProperty.parentId,resProperty.orderNum];
    
    [db executeUpdate:sql];
    
    [db close];
    
    return flag;

    
}
;


@end
