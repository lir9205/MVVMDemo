//
//  MADPickImageView.m
//  ModelArea
//
//  Created by mac on 15/10/27.
//  Copyright (c) 2015年 jinhuadiqigan. All rights reserved.
//

#import "MADPickImageView.h"

static const CGFloat kItemWH = 70;

@interface MADPickImageView () 
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIButton *button;

@property (nonatomic, strong) NSMutableArray *imageViews;

@end

@implementation MADPickImageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"register_add_icon"] forState:UIControlStateNormal];
        [self addSubview:button];
        _button = button;
        
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.showsHorizontalScrollIndicator = NO;
        //scrollView.backgroundColor = kDEFAULT_GRAYCOLOR;
        [self addSubview:scrollView];
        _scrollView = scrollView;
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.button.frame = CGRectMake(15, (self.frame.size.height-kItemWH)/2, kItemWH, kItemWH);
    
    CGFloat x = CGRectGetMaxX(_button.frame) + 8;
    self.scrollView.frame = CGRectMake(x, 0, self.frame.size.width - x, self.frame.size.height);
    
    if (self.imageViews && self.imageViews.count >0) {
        [self.imageViews enumerateObjectsUsingBlock:^(UIImageView *obj, NSUInteger idx, BOOL *stop) {
            obj.frame = CGRectMake((kItemWH+8)*idx, (_scrollView.frame.size.height-kItemWH)/2, kItemWH, kItemWH);
        }];
        
        CGFloat width = _imageViews.count*(kItemWH+8);
        self.scrollView.contentSize = CGSizeMake(width, 0);
    }
    
   
}

- (void)addTarget:(id)target action:(SEL)action {
    [self.button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

- (void)setImages:(NSArray *)images {
    _images = images;
    _imageViews = [NSMutableArray arrayWithCapacity:images.count];
    
    for (NSInteger i=0; i<images.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.userInteractionEnabled = YES;
        imageView.tag = i;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandle:)];
        
        [imageView addGestureRecognizer:tapGesture];
        imageView.image = images[i];
        [_scrollView addSubview:imageView];
        [self.imageViews addObject:imageView];
    }
    
    [self setNeedsLayout];
}

- (void)tapHandle:(UITapGestureRecognizer *)recognizer {
    NSInteger page = recognizer.view.tag;
    
//    UIImageView *imageView = (UIImageView *)recognizer.view;
    
    [self.delegate images:_images didSelectImageAtIndex:page];
}


@end
