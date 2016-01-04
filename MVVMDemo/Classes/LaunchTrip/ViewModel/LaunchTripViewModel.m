//
//  LaunchTripViewModel.m
//  
//
//  Created by 李芮 on 15/12/31.
//
//

#import "LaunchTripViewModel.h"
#import <Foundation/Foundation.h>
#import "LaunchTripModel.h"
#import "HUUser.h"
#import "HUUserViewModel.h"
#import "HULocalizationApi.h"


@interface LaunchTripViewModel()
{
    BOOL _isEdited;
}
@end

@implementation LaunchTripViewModel

- (instancetype)initWithModel:(id)model {
    self = [super initWithModel:model];
    if (self) {
        LaunchTripModel *entity = (LaunchTripModel *)model;
        _theme = entity.theme;
        _time = entity.time;
        _destination = entity.destination;
        _funds = entity.funds;
        _award = entity.award;
        _remark = entity.remark;
        _awards = [[NSMutableArray alloc] init];
        _works = [[NSMutableArray alloc] init];
//        _awards = [[HULocalizationApi querryAll:self.model] mutableCopy];
//        _works = [entity.works mutableCopy];
        
    }
    return self;
}

- (NSString *)titleForHeaderInSection:(NSInteger)section {
    return section == 0 ? @"" : (section == 1 ? @"个人作品展示" : @"旅拍备注");
}

- (NSString *)placeholderForRow:(NSInteger)row inSection:(NSInteger)section {
    if (section == 0) {
        switch (row) {
            case 0:
                return _theme;
                break;
            case 1:
                return _time;
                break;
            case 2:
                return _destination;
                break;
            case 3:
                return _funds;
                break;
            case 4:
                return _award;
                break;
            default:
                break;
        }
    }else if (section == 2){
        return _remark;
    }
    return @"";

}


- (void)textFieldValueDidChanged:(NSString *)textValue forRow:(NSInteger)row inSection:(NSInteger)section {
    if (!_isEdited) {
        _isEdited = YES;
        [self resetProperties];
    }
    
    
    NSString *text = [textValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    switch (row) {
        case 0:
            _theme = text;
            break;
        case 1:
            _time = text;
            break;
        case 2:
            _destination = text;
            break;
        case 3:
            _funds = text;
            break;
//        case 4:
//            _award = text;
//            break;
        default:
            break;
    }
}

- (void)textViewValueDidChanged:(NSString *)textValue {
    
    if (!_isEdited) {
        _isEdited = YES;
        [self resetProperties];
    }
    
    NSString *text = [textValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    _remark = text;

}
- (NSMutableDictionary *)save {
    if (!_isEdited) {
        [self resetProperties];
    }
    
    _awards = [[self.userViewModel querryAll] mutableCopy];
    
    if ([_theme isEqualToString:@""] || [_time isEqualToString:@""] || [_destination isEqualToString:@""]    || [_funds isEqualToString:@""] || !_awards || _awards.count == 0){
        NSLog(@"填写信息不完整");
        return nil;
    }
    
    
    
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] initWithCapacity:5];
    [dataDic setValue:_theme forKey:@"theme"];
    [dataDic setValue:_time forKey:@"time"];
    [dataDic setValue:_destination forKey:@"destination"];
    [dataDic setValue:_funds forKey:@"funds"];
    [dataDic setValue:_awards forKey:@"awards"];
    [dataDic setValue:_remark forKey:@"remark"];
    [dataDic setValue:_works forKey:@"works"];
    NSLog(@"savedata:%@",dataDic);
    return dataDic;
}

- (void)resetProperties {
    _theme = @"";
    _time = @"";
    _destination = @"";
    _funds = @"";
    //_award = @"";
    _remark = @"";
    _works = nil;
    _awards = nil;
}


- (HUUserViewModel *)userViewModel {
    HUUser *user = [[HUUser alloc] init];
    user.userId = @1;
    user.name = @"default";
    user.age = 0;
    user.gender  = 1;
    
    return [[HUUserViewModel alloc] initWithModel:user];
}

@end
