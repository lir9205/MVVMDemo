//
//  LaunchTripModel.m
//  
//
//  Created by 李芮 on 16/1/4.
//
//

#import "LaunchTripModel.h"

@implementation LaunchTripModel

- (instancetype) init {
    self = [super init];
    if (self) {
        _theme = @"填写旅拍主题(限10字)";
        _time = @"选择旅拍时间";
        _destination = @"选择旅拍目的地";
        _funds = @"填写需要募集的资金";
        _award = @"选择相应的奖励";
    }
    return self;
}

@end
