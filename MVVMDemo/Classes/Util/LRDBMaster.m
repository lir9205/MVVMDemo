//
//  DBMaster.m
//  
//
//  Created by 李芮 on 15/12/29.
//
//

#import "LRDBMaster.h"

@interface LRDBMaster ()

@property (nonatomic, strong)FMDatabase *dataBase;

@end

@implementation LRDBMaster

+ (instancetype)sharedDBMaster {
    static LRDBMaster *dbMaster = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dbMaster = [[super alloc] init];
    });
    return dbMaster;
}
- (void)openDBWithDBName:(NSString *)dbName {
    
    NSString *cachDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *dbPath = [cachDirectory stringByAppendingPathComponent:dbName];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL isDirectory = false;
    BOOL isDirectoryExist = [fileManager fileExistsAtPath:dbPath isDirectory:&isDirectory];
    
    if (!(isDirectory && isDirectoryExist)) {
        if (![fileManager createDirectoryAtPath:dbPath withIntermediateDirectories:YES attributes:nil error:nil]) {
            NSLog(@"创建文件失败！");
        }
    }
    NSString *filePath = [dbPath stringByAppendingPathComponent:@"dbdemo.db"];
    self.dataBase = [FMDatabase databaseWithPath:filePath];
    [self.dataBase open];
    [self createUserTable];
    
}
#warning ?????

/*
 *
 对可变参数列表的处理过程一般为：
 1、用va_list定义一个可变参数列表
 2、用va_start获取函数可变参数列表
 3、用va_arg循环处理可变参数列表中的各个可变参数
 4、用va_end结束对可变参数列表的处理
  *
 */
- (BOOL)executeUpdate:(NSString *)sql, ... {
    va_list args;
    NSMutableArray *array = [NSMutableArray array];
    va_start(args, sql);
    id obj;
    int idx = 0;
    int32_t count = [self count:sql];
    while (idx < count) {
        obj = va_arg(args, id);
        if ([obj isKindOfClass:[sql class]] && [obj isEqualToString:sql]) {
            break;
        }
        [array addObject:obj];
        NSLog(@"idx: %d,obj:%@",idx,obj);
        idx++;
    }
    NSLog(@"arguments: %@, count: %d",array, count);
//    #define NSAssert(condition, desc, ...)
//    NSAssert是IOS里的一个宏定义，通常用来调试 condition是条件表达式，值为YES或NO；desc为异常描述，通常为NSString。当conditon为YES时程序继续运行，为NO时，则抛出带有desc描述的异常信息。NSAssert()可以出现在程序的任何一个位置。
//#define AC_Assert(condition) NSAssert(condition, ([NSString stringWithFormat:@"file name = %s ---> function name = %s at line: %d", __FILE__, __FUNCTION__, __LINE__]));
//    
//    AC_Assert这个宏的作用是当程序不满足condition这个条件时，程序终止，并且输出不满足条件的类，以及是类的哪个函数和类中得行数
    NSAssert(array.count == count, @"参数个数不匹配");
    BOOL result ;//= [self.dataBase executeUpdate:sql];
    if (count == 0) {
        result = [self.dataBase executeUpdate:sql];
        //NSLog(@"无参数");
    }
    else if(count == array.count) {
        result = [self.dataBase executeUpdate:sql withArgumentsInArray:array];
        //NSLog(@"有参数");
    }
    //
    
    va_end(args);
    
    
    return result;
}
- (FMResultSet *)excuteQuerry:(NSString *)sql {
    return [self.dataBase executeQuery:sql];
}

- (void)createUserTable {
    [self createTable:@"user" sql:@"create table user (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,userId INTEGER, name TEXT,imgUrl TEXT,introduce TEXT, gender INTEGER, age INTEGER)"];
}
- (void)createTable:(NSString *)tableName sql:(NSString *)sqlStr {
    BOOL isExit = [self.dataBase tableExists:tableName];
    if (!isExit) {
        [self.dataBase executeUpdate:sqlStr];
    }
}
- (int32_t)count:(NSString *)str {
    NSArray *count = [str componentsSeparatedByString:@"?"];
    return (int32_t)count.count-1;
}
@end
