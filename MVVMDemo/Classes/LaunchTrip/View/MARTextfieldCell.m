//
//  MARTextfieldCell.m
//  ModelArea
//
//  Created by mac on 15/8/29.
//  Copyright (c) 2015年 jinhuadiqigan. All rights reserved.
//

#import "MARTextfieldCell.h"

#define kDEFAULT_BLACKCOLOR [UIColor blackColor]
#define MAFONT_SIZE(size) [UIFont systemFontOfSize:size]

@interface MARTextfieldCell ()



@end

@implementation MARTextfieldCell

+ (instancetype)cellWithTableview:(UITableView *)tableView {
    MARTextfieldCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MARTextfieldCell"];
    if (!cell) {
        cell = [[MARTextfieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MARTextfieldCell"];
    }
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _textField = [[UITextField alloc] init];
        _textField.textColor = kDEFAULT_BLACKCOLOR;
        _textField.font = MAFONT_SIZE(14);
        _textField.adjustsFontSizeToFitWidth = YES;
        _textField.minimumFontSize = 11;
        [self.contentView addSubview:_textField];
    }
    return self;
}

- (void)setShouleMutableTextView:(BOOL)shouleMutableTextView {
    _shouleMutableTextView = shouleMutableTextView;
    if (!shouleMutableTextView) return;
    
    [_textField removeFromSuperview];
    _textView = [[MAPlacehodelerTextView alloc] init];
    _textView.alwaysBounceVertical = YES;
    _textView.font = MAFONT_SIZE(14);
    _textView.placeholder = self.placeholder;
    _textView.textColor = kDEFAULT_BLACKCOLOR;
    [self.contentView addSubview:_textView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.textField.frame = CGRectMake(15, 0, self.frame.size.width-15*2, self.frame.size.height);
    
    if (_otherButton) {
        self.textField.frame = CGRectMake(15, 0, (self.frame.size.width-15*2)/2, self.frame.size.height);
        self.otherButton.frame = CGRectMake(CGRectGetMaxX(_textField.frame), 0, self.textField.frame.size.width, self.frame.size.height);
    }
    
    if (_shouleMutableTextView) {
        self.textView.frame = CGRectMake(15, 0, self.frame.size.width-15*2, self.frame.size.height);
    }
   // NSLog(@"%@", NSStringFromCGRect(self.textField.frame));
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = [placeholder copy];
    
    self.textField.placeholder = placeholder;
}

- (void)setOtherButton:(UIButton *)otherButton {
    _otherButton = otherButton;
    [_otherButton setTitleColor:kDEFAULT_BLACKCOLOR forState:UIControlStateNormal];
    [self.contentView addSubview:otherButton];
}


@end
