//
//  LCLRating.m
//  MagicBoord
//
//  Created by Leonard Li on 3/19/14.
//  Copyright (c) 2014 Leonard Li. All rights reserved.
//

#import "LCLRating.h"
#import <Parse/PFObject+Subclass.h>

@implementation LCLRating
@dynamic user;
@dynamic tip;
@dynamic rating;

+ (NSString *)parseClassName {
    return @"LCLRating";
}

+ (instancetype)ratingWithUser:(LCLUser *)user Tip:(LCLTip *)tip Rating:(NSNumber *)rating
{
    return [[LCLRating alloc] initWithUser:user Tip:tip Rating:rating];
};


- (instancetype)initWithUser:(LCLUser *)user Tip:(LCLTip *)tip Rating:(NSNumber *)rating
{
    self = [super init];
    if (self) {
        self.user = user;
        self.tip = tip;
        self.rating = rating;
        [self saveInBackground];
    }
    return self;
};

+ (void)updateRating:(NSNumber *)ratingNumber ForUser:(LCLUser *)user AndTip:(LCLTip *)tip WithCompletion:(void (^)(BOOL))completionBlock
{
    PFQuery *ratingQuery = [PFQuery queryWithClassName:@"LCLRating"];
    [ratingQuery whereKey:@"user" equalTo:user];
    [ratingQuery whereKey:@"tip" equalTo:tip];
    [ratingQuery getFirstObjectInBackgroundWithBlock:^(PFObject *ratingObject, NSError *error) {
        if (!error) {
            [ratingObject setObject:ratingNumber forKey:@"rating"];
            [ratingObject saveInBackground];
            completionBlock(YES);
        } else {
            NSLog(@"Could not find Rating For User %@ and Tip %@", user, tip);
        }
    }];
};

@end
