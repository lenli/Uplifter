//
//  LCLTipsDataStore.m
//  MagicBoord
//
//  Created by Leonard Li on 3/20/14.
//  Copyright (c) 2014 Leonard Li. All rights reserved.
//

#import "LCLTipsDataStore.h"

@implementation LCLTipsDataStore
NSInteger const TIMER_WAIT_TIME_SECONDS = 1200;
NSString *const DEFAULT_TIP_TEXT = @"Sit down.  Seriously, you’ve seen all our tips.  We love you too, but maybe it’s time you shared this?";

+ (instancetype)sharedDataStore {
    static LCLTipsDataStore *_sharedDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDataStore = [[LCLTipsDataStore alloc] init];
    });
    
    return _sharedDataStore;
}

- (NSArray *)getLikeButtonArray
{
    return @[@"You so funny",
             @"Ha ha nice one",
             @"Not bad",
             @"Me likey",
             @"#Awesome",
             @"Great shot kid",
             @"Beam me up",
             @"Badass",
             @"Yummy",
             @"That’s hot"
             ];
}

- (NSArray *)getDislikeButtonArray
{
    return @[@"Could be better",
             @"Eek <Crickets>",
             @"No good",
             @"Me no likey",
             @"#Fail",
             @"Try again",
             @"No soup for you",
             @"Alrighty then",
             @"Weaksauce",
             @"Lame"
             ];
}

- (NSArray *)getTitleTextArray
{
    return @[@"Uplifter",
             @"Uplifter",
             @"Uplifter",
             @"Uplifter",
             @"Bored?",
             @"Sad?",
             @"Need a laugh?",
             @"Break time?",
             @"Nothing to do?",
             @"Need a smile?",
             @"Why so serious?"
             ];
}

- (NSInteger)getRandomLikeButtonIndex
{
    NSArray *likeButtonText = [self getLikeButtonArray];
    return arc4random_uniform([likeButtonText count]);
}

- (NSString *)getLikeButtonTextWithIndex:(NSInteger)index
{
    NSArray *likeButtonText = [self getLikeButtonArray];
    NSUInteger randomLikeIndex = (index >= 0) ? index : arc4random_uniform([likeButtonText count]);
    return likeButtonText[randomLikeIndex];
}

- (NSString *)getRandomLikeButtonText
{
    return [self getLikeButtonTextWithIndex:-1];
}

- (NSString *)getDislikeButtonTextWithIndex:(NSInteger)index
{
    NSArray *dislikeButtonText = [self getDislikeButtonArray];
    NSUInteger randomLikeIndex = (index >= 0) ? index : arc4random_uniform([dislikeButtonText count]);
    return dislikeButtonText[randomLikeIndex];
}

- (NSString *)getRandomDislikeButtonText
{
    return [self getDislikeButtonTextWithIndex:-1];
}

-(NSInteger)getTitleTextCount
{
    return [[self getTitleTextArray] count];
}

- (NSString *)getTitleTextWithIndex:(NSInteger)index
{
    NSArray *titleText = [self getTitleTextArray];
    NSUInteger randomLikeIndex = (index >= 0) ? index : arc4random_uniform([titleText count]);
    return titleText[randomLikeIndex];
}

-(NSString *)getRandomTitleText
{
    return [self getTitleTextWithIndex:-1];
}

@end
