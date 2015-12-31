//
//  LRUserInfoCell.m
//  
//
//  Created by 李芮 on 15/12/29.
//
//

#import "LRUserInfoCell.h"

#import "Masonry.h"

@interface LRUserInfoCell ()


@end
@implementation LRUserInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView {
    _imgView = [UIImageView new];
    [self.contentView addSubview:_imgView];
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(5);
        make.left.equalTo(self.contentView.mas_left).with.offset(8);
        //        make.width.equalTo(@(40));
        //        make.height.equalTo(@(40));
        make.height.and.width.equalTo(@(40));
    }];
    
    _titleLabel = [UILabel new];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(5);
        make.left.equalTo(_imgView.mas_right).with.offset(8);
        make.right.equalTo(self.contentView.mas_right).with.offset(-8);
        make.height.equalTo(@(25));
    }];
    
#warning  //计算Uilabel的preferredMaxLayoutWidth值，多行时必须设置这个值，否则系统无法决定Label的宽度
    CGFloat preferedMaxWidth = [UIScreen mainScreen].bounds.size.width - 8 * 3 + _imgView.frame.size.width;
    
    
    
    
    _contentLabel = [UILabel new];
    
    _contentLabel.preferredMaxLayoutWidth = preferedMaxWidth;
    _contentLabel.numberOfLines = 0;
    [self.contentView addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(5);
        make.left.equalTo(_imgView.mas_right).with.offset(8);
        make.right.equalTo(self.contentView.mas_right).with.offset(-8);
        //make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-5);
        //make.height.priority(UILayoutPriorityRequired);
    }];
    
    //设置内容优先级
    [_contentLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    
}


@end
