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

+ (void)showRandomMessage:(NSString *)messageType ForView:(UIView *)view
{
    NSArray *messages = [NSArray new];
    if ([messageType isEqualToString:@"randomizing"]) {
        messages = @[ @"Determining your fate",
                      @"Rolling the dice",
                      @"All boredom are belong to us",
                      @"Searching your feelings",
                      @"Reading your mind",
                      @"Prepare to be amused",
                      @"Creative juices flowing"
                      ];
    } else {
        messages = @[ @"Attention on deck",
                      @"Seeking the meaning of life",
                      @"Curing cancer",
                      @"Witty loading message here",
                      @"Using the force",
                      @"Setting thrusters to full"
                      ];
    }
    NSUInteger randomMessageIndex = arc4random_uniform((u_int32_t)[messages count]);
    [MBProgressHUD showLoadingMessage:messages[randomMessageIndex] ForView:view];
}

@end
