//
//  LRLocalizationApi.m
//  
//
//  Created by 李芮 on 15/12/29.
//
//

#import "LRLocalizationApi.h"

@implementation LRLocalizationApi

+(BOOL)saveObject:(id<LRLocalizationProtocol>)obj {
    if ([obj respondsToSelector:@selector(save)]) {
        return [obj save];
    }
    return false;
}

+ (id)querry:(id<LRLocalizationProtocol>)obj {
    if ([obj respondsToSelector:@selector(querry:)]) {
        return [obj querry];
    }
    return nil;
}
@end
