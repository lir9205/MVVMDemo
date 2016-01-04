//
//  MADPickImageView.h
//  ModelArea
//
//  Created by mac on 15/10/27.
//  Copyright (c) 2015年 jinhuadiqigan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MADPickImageViewDidTapImageDelegate;

@interface MADPickImageView : UIView

@property (nonatomic, weak) id<MADPickImageViewDidTapImageDelegate>delegate;
@property (nonatomic, strong) NSArray *images;

- (void)addTarget:(id)target action:(SEL)action;

@end

@protocol MADPickImageViewDidTapImageDelegate <NSObject>

- (void)images:(NSArray *)images didSelectImageAtIndex:(NSInteger)index;

@end