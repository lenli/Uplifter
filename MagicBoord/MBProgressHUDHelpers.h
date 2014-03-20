//
//  MBProgressBarHelpers.h
//  MagicBoord
//
//  Created by Leonard Li on 3/19/14.
//  Copyright (c) 2014 Leonard Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBProgressHUDHelpers : NSObject
+ (void)showLoadingMessageForView:(UIView *)view;
+ (void)hideLoadingMessageForView:(UIView *)view;

@end
