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
        
        
    }
    return self;
}

- (void)textFieldValueDidChanged:(UITextField *)textField atIndexPath:(NSIndexPath *)indexPath {
    
    if (!_isEdited) {
        _isEdited = YES;
        [self resetProperties];
    }
    
    
    NSString *text = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    switch (indexPath.row) {
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
        case 4:
            _award = text;
            break;
        default:
            break;
    }
}

- (NSMutableDictionary *)save {
    if (!_isEdited) {
        [self resetProperties];
    }
    
    if ([_theme isEqualToString:@""] || [_time isEqualToString:@""] || [_destination isEqualToString:@""]    || [_funds isEqualToString:@""] || [_award isEqualToString:@""]){
        NSLog(@"填写信息不完整");
        return nil;
    }
    
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] initWithCapacity:5];
    [dataDic setValue:_theme forKey:@"theme"];
    [dataDic setValue:_time forKey:@"time"];
    [dataDic setValue:_destination forKey:@"destination"];
    [dataDic setValue:_funds forKey:@"funds"];
    [dataDic setValue:_award forKey:@"award"];
    NSLog(@"savedata:%@",dataDic);
    return dataDic;
}

- (void)resetProperties {
    _theme = @"";
    _time = @"";
    _destination = @"";
    _funds = @"";
    _award = @"";
}
@end
