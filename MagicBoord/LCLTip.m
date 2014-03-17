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
@synthesize users = _users;
@synthesize usersLiked = _usersLiked;
@synthesize usersDisliked = _usersDisliked;
@dynamic startHour;
@dynamic endHour;
@dynamic category;

# pragma mark - Setters and Getters
+ (NSString *)parseClassName {
    return @"LCLTip";
}

- (void) setUsers:(PFRelation *)users {
    _users = users;
}

- (PFRelation *) users{
    if(_users== nil) {
        _users = [self relationforKey:@"users"];
    }
    return _users;
}

- (void) setUsersLiked:(PFRelation *)usersLiked {
    _usersLiked = usersLiked;
}

- (PFRelation *) usersLiked{
    if(_usersLiked== nil) {
        _usersLiked = [self relationforKey:@"usersLiked"];
    }
    return _usersLiked;
}

- (void) setUsersDisliked:(PFRelation *)usersDisliked {
    _usersDisliked = usersDisliked;
}

- (PFRelation *) usersDisliked{
    if(_usersDisliked== nil) {
        _usersDisliked = [self relationforKey:@"usersDisliked"];
    }
    return _usersDisliked;
}

# pragma mark - Init Methods

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
        self.users = [self relationForKey:@"users"];
        self.usersLiked = [self relationForKey:@"usersLiked"];
        self.usersDisliked = [self relationForKey:@"usersDislike"];
        self.startHour = 0;
        self.endHour = 0;
        self.category = category ? category : @"";
        [self saveInBackground];
    }
    return self;
}

+ (instancetype)tipWithText:(NSString *)tip Category:(NSString *)category User:(PFUser *)user
{
    return [[self alloc] initWithClassName:[LCLTip parseClassName] WithTip:tip WithCategory:category WithUser:user];
}

- (instancetype)initWithClassName:(NSString *)newClassName WithTip:(NSString *)tip WithCategory:(NSString *)category WithUser:(PFUser *)user
{
    self = [super init];
    if (self) {
        self.tip = tip ? tip : @"";
        self.tipTitle = tip ? [self shortenString:tip ToWords:5] : @"";
        self.users = [self relationForKey:@"users"];
        self.usersLiked = [self relationForKey:@"usersLiked"];
        self.usersDisliked = [self relationForKey:@"usersDislike"];
        self.startHour = 0;
        self.endHour = 0;
        self.category = category ? category : @"";
        [self.users addObject:user];
        [self.usersLiked addObject:user];
        [self.usersDisliked addObject:user];
        
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
