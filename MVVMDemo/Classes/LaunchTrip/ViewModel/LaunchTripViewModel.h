//
//  LaunchTripViewModel.h
//  
//
//  Created by 李芮 on 15/12/31.
//
//

#import "HURequestViewModel.h"
#import <UIKit/UIKit.h>

@interface LaunchTripViewModel : HURequestViewModel

@property (nonatomic, strong) NSString *theme;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *destination;
@property (nonatomic, strong) NSString *funds;
@property (nonatomic, strong) NSString *award;

//@property (nonatomic, strong) NSDictionary *dataDic;

- (void)textFieldValueDidChanged:(UITextField *)textField atIndexPath:(NSIndexPath *)indexPath;
- (NSMutableDictionary *)save;
@end
