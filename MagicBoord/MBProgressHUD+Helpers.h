//
//  MBProgressHUD+Helpers.h
//  MagicBoord
//
//  Created by Leonard Li on 3/20/14.
//  Copyright (c) 2014 Leonard Li. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Helpers)
+ (void)showLoadingMessage:(NSString *)messageString ForView:(UIView *)view;
+ (void)hideLoadingMessageForView:(UIView *)view;
+ (void)showRandomMessage:(NSString *)messageType ForView:(UIView *)view;

@end
