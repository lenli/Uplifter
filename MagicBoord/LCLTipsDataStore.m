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

- (NSArray *)getLikeButtonText
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

- (NSArray *)getDislikeButtonText
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

@end
