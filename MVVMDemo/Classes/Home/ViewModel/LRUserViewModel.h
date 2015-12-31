//
//  LRUserViewModel.h
//  
//
//  Created by 李芮 on 15/12/29.
//
//

#import "HURequestViewModel.h"



@interface LRUserViewModel : HURequestViewModel



//所有在ViewController里需要的内容都在这里声明，viewModel一定只和model有关，与View无关
- (NSString *)nameAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)contentAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)imaUrlAtIndexPath:(NSIndexPath *)indexPath;

- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;

@end
