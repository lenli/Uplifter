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

+ (instancetype)sharedDataStore {
    static LCLTipsDataStore *_sharedDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDataStore = [[LCLTipsDataStore alloc] init];
    });
    
    return _sharedDataStore;
}


@end
