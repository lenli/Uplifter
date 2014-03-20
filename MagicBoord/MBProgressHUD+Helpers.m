//
//  MBProgressHUD+Helpers.m
//  MagicBoord
//
//  Created by Leonard Li on 3/20/14.
//  Copyright (c) 2014 Leonard Li. All rights reserved.
//

#import "MBProgressHUD+Helpers.h"

@implementation MBProgressHUD (Helpers)
+ (void)showLoadingMessage:(NSString *)messageString ForView:(UIView *)view;
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = messageString;
}

+ (void)hideLoadingMessageForView:(UIView *)view
{
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
}
@end
