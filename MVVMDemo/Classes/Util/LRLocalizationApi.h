//
//  LRLocalizationApi.h
//  
//
//  Created by 李芮 on 15/12/29.
//
//

#import <Foundation/Foundation.h>
#import "LRLocalizationProtocol.h"


@interface LRLocalizationApi : NSObject<LRLocalizationProtocol>

+ (BOOL)saveObject:(id<LRLocalizationProtocol>)obj;
+ (id)querry:(id<LRLocalizationProtocol>)obj;

@end
