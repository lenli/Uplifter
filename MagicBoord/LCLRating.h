//
//  LCLRating.h
//  MagicBoord
//
//  Created by Leonard Li on 3/19/14.
//  Copyright (c) 2014 Leonard Li. All rights reserved.
//


#import <Parse/Parse.h>
#import "LCLTip.h"
#import "LCLUser.h"

@interface LCLRating : PFObject <PFSubclassing>
@property (strong, nonatomic) LCLUser *user;
@property (strong, nonatomic) LCLTip *tip;
@property (strong, nonatomic) NSNumber *rating;


+ (void)updateRating:(NSNumber *)ratingNumber ForUser:(LCLUser *)user AndTip:(LCLTip *)tip WithCompletion:(void (^)(BOOL success))completionBlock;
+ (instancetype)ratingWithUser:(LCLUser *)user Tip:(LCLTip *)tip Rating:(NSNumber *)rating;
- (instancetype)initWithUser:(LCLUser *)user Tip:(LCLTip *)tip Rating:(NSNumber *)rating;
+ (void)getTimeSinceLastTipForUser:(LCLUser *)user WithCompletion:(void (^)(NSNumber *seconds))completionBlock;
+ (BOOL)checkIfUser:(LCLUser *)user HasSeenTip:(LCLTip *)tip;

@end
