//
//  UIViewController+Helpers.h
//  MagicBoord
//
//  Created by Leonard Li on 3/30/14.
//  Copyright (c) 2014 Leonard Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Helpers)
+ (void)setupNavigationBar:(UINavigationBar *)navBar WithFont:(NSString *)fontString WithFontSize:(NSInteger)fontSize WithVerticalPosition:(CGFloat)verticalPostion;
+ (void)setupSwipeGestureForView:(UIView *)view WithSelector:(NSString *)selectorString ForDirection:(UISwipeGestureRecognizerDirection *)direction;
+ (void)setBackgroundImage:(UIImage *)bgImage ForView:(UIView *)view;

@end
