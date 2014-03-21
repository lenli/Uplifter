//
//  LCLTipsDataStore.h
//  MagicBoord
//
//  Created by Leonard Li on 3/20/14.
//  Copyright (c) 2014 Leonard Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCLTip.h"
#import "LCLUser.h"
#import "LCLRating.h"
#import "MBProgressHUD+Helpers.h"

@interface LCLTipsDataStore : NSObject
@property (strong, nonatomic) LCLTipsDataStore *dataStore;
@property (strong, nonatomic) LCLUser *currentUser;
@property (strong, nonatomic) LCLTip *currentTip;
@property (strong, nonatomic) NSNumber *currentRating;
+ (instancetype)sharedDataStore;

@end
