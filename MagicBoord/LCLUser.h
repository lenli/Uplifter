//
//  LCLUser.h
//  MagicBoord
//
//  Created by Leonard Li on 3/15/14.
//  Copyright (c) 2014 Leonard Li. All rights reserved.
//

#import <Parse/Parse.h>

@interface LCLUser : PFUser <PFSubclassing>
@property (retain) PFRelation *tips;

+ (instancetype)userWithUsername:(NSString *)username Password:(NSString *)password;
- (instancetype)initWithUsername:(NSString *)username Password:(NSString *)password;

@end
