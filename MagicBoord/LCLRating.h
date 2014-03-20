//
//  LCLRating.h
//  MagicBoord
//
//  Created by Leonard Li on 3/19/14.
//  Copyright (c) 2014 Leonard Li. All rights reserved.
//


#import <Parse/Parse.h>

@interface LCLRating : PFUser <PFSubclassing>


+ (instancetype)ratingWithUser:(NSString *)username Password:(NSString *)password;
- (instancetype)initWithUsername:(NSString *)username Password:(NSString *)password;

@end

