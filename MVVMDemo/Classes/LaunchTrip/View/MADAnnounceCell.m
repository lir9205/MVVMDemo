//
//  MADAnnounceCell.m
//  ModelArea
//
//  Created by mac on 15/10/27.
//  Copyright (c) 2015年 jinhuadiqigan. All rights reserved.
//

#import "MADAnnounceCell.h"

@interface MADAnnounceCell ()



@end

@implementation MADAnnounceCell

+ (instancetype)cellWithTableview:(UITableView *)tableView {
    static NSString *identifier = @"announcecell";
    MADAnnounceCell *cell = [tableView dequeueReusableCellWithIdentifier: identifier];
    if (!cell) {
        cell = [[MADAnnounceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UITextField *field = [[UITextField alloc] init];
        field.font = [UIFont systemFontOfSize:15];
        field.textColor = [UIColor blackColor];        
        [self.contentView addSubview:field];
        _textField = field;
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
   // self.titleLab.frame = CGRectMake(16, 0, 70, self.height);
    
   // CGFloat x = CGRectGetMaxX(_titleLab.frame);
    self.textField.frame = CGRectMake(8, 0, self.frame.size.width-16, self.frame.size.height);
}

@end
