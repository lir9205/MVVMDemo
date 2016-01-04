//
//  MARTextfieldCell.h
//  ModelArea
//
//  Created by mac on 15/8/29.
//  Copyright (c) 2015年 jinhuadiqigan. All rights reserved.
//

//#import "MAConfigCell.h"
#import "MAPlacehodelerTextView.h"

@interface MARTextfieldCell : UITableViewCell

+ (instancetype)cellWithTableview:(UITableView *)tableView;

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong)  MAPlacehodelerTextView *textView;

@property (nonatomic, copy) NSString *placeholder;

@property (nonatomic, assign) BOOL shouleMutableTextView;

@property (nonatomic, strong) UIButton *otherButton;


@end
