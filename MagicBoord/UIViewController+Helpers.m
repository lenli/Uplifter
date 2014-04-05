//
//  UIViewController+Helpers.m
//  MagicBoord
//
//  Created by Leonard Li on 3/30/14.
//  Copyright (c) 2014 Leonard Li. All rights reserved.
//

#import "UIViewController+Helpers.h"

@implementation UIViewController (Helpers)
+ (void)setupNavigationBar:(UINavigationBar *)navBar WithFont:(NSString *)fontString WithFontSize:(NSInteger)fontSize WithVerticalPosition:(CGFloat)verticalPostion
{
    
    NSDictionary *navBarAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                      [UIFont fontWithName:fontString size:fontSize], NSFontAttributeName,
                                      nil];
    [navBar setTitleTextAttributes:navBarAttributes];
    [navBar setTitleVerticalPositionAdjustment:verticalPostion forBarMetrics:UIBarMetricsDefault];
}

+ (void)setBackgroundImage:(UIImage *)bgImage ForView:(UIView *)view
{
    // Set up checkboard background
    UIGraphicsBeginImageContext(view.frame.size);
    [bgImage drawAsPatternInRect:view.bounds];
    UIImage *bgNewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    view.backgroundColor = [UIColor colorWithPatternImage:bgNewImage];
}



@end
