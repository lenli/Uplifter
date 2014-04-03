//
//  UIStoryboardSegue+Helpers.m
//  Uplifter
//
//  Created by Leonard Li on 3/31/14.
//  Copyright (c) 2014 Leonard Li. All rights reserved.
//

#import "UIStoryboardSegue+Helpers.h"

@implementation UIStoryboardSegue (Helpers)

-(void)perform {
    
    UIViewController *sourceViewController = (UIViewController*)[self sourceViewController];
    UIViewController *destinationController = (UIViewController*)[self destinationViewController];
    
    CATransition* transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromBottom;
    
    [sourceViewController.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [sourceViewController.navigationController pushViewController:destinationController animated:NO];
}
@end
