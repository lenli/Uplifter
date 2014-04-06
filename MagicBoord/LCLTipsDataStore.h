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
extern NSString *const DEFAULT_TIP_TEXT;


@property (strong, nonatomic) LCLTipsDataStore *dataStore;
@property (strong, nonatomic) LCLTip *currentTip;
@property (strong, nonatomic) NSNumber *currentRating;
@property (strong, nonatomic) NSMutableArray *tips;
@property (strong, nonatomic) NSMutableArray *currentUserTips;
@property (strong, nonatomic) NSMutableArray *currentUserUnseenTips;
@property (strong, nonatomic) NSMutableArray *ratings;

+ (instancetype)sharedDataStore;
+ (void)showConnectionError;
- (NSArray *)getLikeButtonArray;
- (NSArray *)getDislikeButtonArray;
- (NSArray *)getTitleTextArray;

- (NSInteger)getRandomLikeButtonIndex;
- (NSString *)getLikeButtonTextWithIndex:(NSInteger)index;
- (NSString *)getRandomLikeButtonText;
- (NSString *)getDislikeButtonTextWithIndex:(NSInteger)index;
- (NSString *)getRandomDislikeButtonText;
- (NSString *)getTitleTextWithIndex:(NSInteger)index;
- (NSString *)getRandomTitleText;

@end
