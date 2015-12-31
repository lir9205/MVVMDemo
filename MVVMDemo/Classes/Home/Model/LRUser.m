//
//  LRUser.m
//  
//
//  Created by 李芮 on 15/12/29.
//
//

#import "LRUser.h"
#import "DBMaster.h"
#import "LRLocalizationProtocol.h"

/*
 @property (nonatomic, copy)NSString *imgUrl;
 @property (nonatomic, copy)NSString *introduce;
 @property (nonatomic, copy)NSString *name;
 @property (nonatomic, strong)NSNumber *userId;
 @property (nonatomic, assign) NSInteger gender;
 @property (nonatomic, assign) NSInteger age;
 */
@implementation LRUser

- (NSString *)description {
    return [NSString stringWithFormat:@"id: %@,imgUrl:%@,name: %@,introduce:%@,gender: %zd,age: %zd",self.userId,self.imgUrl,self.name,self.introduce,self.gender,self.age];
}

- (BOOL)save {
    LRUser *user = [self querry];
    if (user.userId.integerValue == _userId.integerValue) {
        return [[DBMaster sharedDBMaster] executeUpdate:@"update user set name=?,introduce=?,gender=?,age=?,imgUrl=? where userId=?",self.name,self.introduce,@(self.gender),@(self.age),self.userId,self.imgUrl];
    }else{
        return [[DBMaster sharedDBMaster] executeUpdate:@"insert into user(name,introduce,gender,age,imgUrl) values(?,?,?,?,?)",self.name,self.introduce,@(self.gender),@(self.age),self.imgUrl];
    }
}

- (id)querry {
    NSString *sqlStr = [NSString stringWithFormat:@"select * from user where userId=%zd",self.userId.integerValue];
    
    FMResultSet *resultSet = [[DBMaster sharedDBMaster] excuteQuerry:sqlStr];
    LRUser *user = [[LRUser alloc] init];
    if (resultSet.next) {
        user.userId = @([resultSet intForColumn:@"userId"]);
        user.name = [resultSet stringForColumn:@"name"];
        user.introduce = [resultSet stringForColumn:@"introduce"];
        user.imgUrl = [resultSet stringForColumn:@"imgUrl"];
        user.gender = [resultSet intForColumn:@"gender"];
        user.age = [resultSet intForColumn:@"age"];
    }
    [resultSet close];
    NSLog(@"querry:%@",user.description);
    return user;
}
@end
