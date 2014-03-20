//
//  MBProgressBarHelpers.m
//  MagicBoord
//
//  Created by Leonard Li on 3/19/14.
//  Copyright (c) 2014 Leonard Li. All rights reserved.
//

#import "MBProgressHUDHelpers.h"

@implementation MBProgressHUDHelpers
+ (void)showLoadingMessageForView:(UIView *)view
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = @"Loading";
}

+ (void)hideLoadingMessageForView:(UIView *)view
{
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
}
@end
