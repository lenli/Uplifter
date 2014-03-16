//
//  LCLUser.m
//  MagicBoord
///Users/leonardli/Code/ios/SideProjects/MagicBoord/MagicBoord/LCLAppDelegate.m
//  Created by Leonard Li on 3/15/14.
//  Copyright (c) 2014 Leonard Li. All rights reserved.
//

#import "LCLUser.h"

@implementation LCLUser
@dynamic tips;

+ (instancetype)userWithUsername:(NSString *)username Password:(NSString *)password
{
    return [[self alloc] initWithUsername:username Password:password];
}

- (instancetype)initWithUsername:(NSString *)username Password:(NSString *)password
{
    self = [super init];
    if (self) {
        self.username = username;
        self.password = password;
        self.tips = [NSMutableArray new];
        [self signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                // Hooray! Let them use the app now.
                [self saveInBackground];
            } else {
                NSString *errorString = [error userInfo][@"error"];
                NSLog(@"%@", errorString);
                // Show the errorString somewhere and let the user try again.
                
            }
        }];
    }
    return self;
}
@end
