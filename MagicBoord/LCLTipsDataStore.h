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
extern NSInteger const TIMER_WAIT_TIME_SECONDS;

@property (strong, nonatomic) LCLTipsDataStore *dataStore;
@property (strong, nonatomic) LCLTip *currentTip;
@property (strong, nonatomic) NSNumber *currentRating;
@property (strong, nonatomic) NSMutableArray *tips;
@property (strong, nonatomic) NSMutableArray *currentUserTips;
@property (strong, nonatomic) NSMutableArray *currentUserUnseenTips;
@property (strong, nonatomic) NSMutableArray *ratings;

+ (instancetype)sharedDataStore;

@end
