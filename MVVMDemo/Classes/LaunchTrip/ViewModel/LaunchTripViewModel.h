//
//  LaunchTripViewModel.h
//  
//
//  Created by 李芮 on 15/12/31.
//
//

#import "HUBasicViewModel.h"

@class HUUserViewModel;
@interface LaunchTripViewModel : HUBasicViewModel

@property (nonatomic, copy) NSString *theme;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *destination;
@property (nonatomic, copy) NSString *funds;
@property (nonatomic, copy) NSString *award;
@property (nonatomic, strong) NSMutableArray *awards;
@property (nonatomic, copy) NSString *remark;//备注
@property (nonatomic, strong) NSMutableArray *works;//作品

@property (nonatomic, readonly, strong) HUUserViewModel *userViewModel;

- (NSString *)titleForHeaderInSection:(NSInteger)section;
- (NSString *)placeholderForRow:(NSInteger)row inSection:(NSInteger)section;

- (void)textViewValueDidChanged:(NSString *)textValue;
- (void)textFieldValueDidChanged:(NSString *)textValue forRow:(NSInteger)row inSection:(NSInteger)section;
- (NSMutableDictionary *)save;
@end
