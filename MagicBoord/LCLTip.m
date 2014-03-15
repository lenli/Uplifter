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
@dynamic numberOfLikes;
@dynamic numberOfDislikes;
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

- (instancetype)init
{
    return [self initWithClassName:[LCLTip parseClassName] WithTip:@"" WithCategory:@""];
}

- (instancetype)initWithClassName:(NSString *)newClassName WithTip:(NSString *)tip WithCategory:(NSString *)category
{
    self = [super init];
    if (self) {
        self.tip = tip ? tip : @"";
        self.numberOfLikes = 0;
        self.numberOfDislikes = 0;
        self.startHour = 0;
        self.endHour = 0;
        self.category = category ? category : @"";
        [self saveInBackground];
    }
    return self;
}
@end
