//
//  LCLTip.m
//  MagicBoord
//
//  Created by Leonard Li on 3/14/14.
//  Copyright (c) 2014 Leonard Li. All rights reserved.
//

#import "LCLTip.h"
#import <Parse/PFObject+Subclass.h>

@implementation LCLTip
@dynamic tip;
@dynamic tipTitle;
@dynamic users;
@dynamic usersLiked;
@dynamic usersDisliked;
@dynamic startHour;
@dynamic endHour;
@dynamic category;

+ (NSString *)parseClassName {
    return @"LCLTip";
}

+ (instancetype)tipWithText:(NSString *)tip Category:(NSString *)category
{
    return [[self alloc] initWithClassName:[LCLTip parseClassName] WithTip:tip WithCategory:category];
}

- (instancetype)initWithClassName:(NSString *)newClassName WithTip:(NSString *)tip WithCategory:(NSString *)category
{
    self = [super init];
    if (self) {
        self.tip = tip ? tip : @"";
        self.tipTitle = tip ? [self shortenString:tip ToWords:5] : @"";
        self.users = [NSMutableArray new];
        self.usersLiked = [NSMutableArray new];
        self.usersDisliked = [NSMutableArray new];
        self.startHour = 0;
        self.endHour = 0;
        self.category = category ? category : @"";
        [self saveInBackground];
    }
    return self;
}

#pragma mark - Helper Methods

- (NSString *)shortenString:(NSString *)longString ToWords:(NSInteger)numberOfWords
{
    NSArray *stringArray = [longString componentsSeparatedByString:@" "];
    NSInteger shortStringLength = MIN(numberOfWords,[stringArray count]);
    NSArray *shortStringArray = [stringArray subarrayWithRange:NSMakeRange(0, shortStringLength)];
    NSString *shortString = [shortStringArray componentsJoinedByString:@" "];;
    return shortString;
}


@end
