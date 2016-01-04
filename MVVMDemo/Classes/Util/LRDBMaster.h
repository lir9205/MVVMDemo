//
//  DBMaster.h
//  
//
//  Created by 李芮 on 15/12/29.
//
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>


@interface LRDBMaster : NSObject

+ (instancetype)sharedDBMaster;

- (void)openDBWithDBName:(NSString *)dbName;
- (BOOL)executeUpdate:(NSString *)sql,...;
- (FMResultSet *)excuteQuerry:(NSString *)sql;



@end
