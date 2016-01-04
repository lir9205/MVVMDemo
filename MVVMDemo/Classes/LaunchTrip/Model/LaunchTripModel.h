//
//  LaunchTripModel.h
//  
//
//  Created by 李芮 on 16/1/4.
//
//

#import "HUBasicViewModel.h"

@interface LaunchTripModel : NSObject
@property (nonatomic, copy) NSString *theme;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *destination;
@property (nonatomic, copy) NSString *funds;
@property (nonatomic, copy) NSString *award;
@property (nonatomic, strong) NSMutableArray *awards;
@property (nonatomic, copy) NSString *remark;//备注
@property (nonatomic, strong) NSMutableArray *works;//作品
@end
