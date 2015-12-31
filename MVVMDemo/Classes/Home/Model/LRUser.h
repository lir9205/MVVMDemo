//
//  LRUser.h
//  
//
//  Created by 李芮 on 15/12/29.
//
//

#import <Foundation/Foundation.h>
#import "LRLocalizationProtocol.h"

@interface LRUser : NSObject<LRLocalizationProtocol>
@property (nonatomic, copy)NSString *imgUrl;
@property (nonatomic, copy)NSString *introduce;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, strong)NSNumber *userId;
@property (nonatomic, assign) NSInteger gender;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic) float cellHeight;
@end
