//
//  LCLTip.h
//  MagicBoord
//
//  Created by Leonard Li on 3/14/14.
//  Copyright (c) 2014 Leonard Li. All rights reserved.
//

#import <Parse/Parse.h>

@interface LCLTip : PFObject <PFSubclassing>
+ (NSString *)parseClassName;

@property (strong, nonatomic) NSString *tip;
@property (strong, nonatomic) NSString *tipTitle;
@property (retain) PFRelation *users;
@property (retain) PFRelation *usersLiked;
@property (retain) PFRelation *usersDisliked;
@property (nonatomic) NSInteger startHour;
@property (nonatomic) NSInteger endHour;
@property (strong, nonatomic) NSString *category;

+ (instancetype)tipWithText:(NSString *)tip Category:(NSString *)category;
- (instancetype)initWithClassName:(NSString *)newClassName WithTip:(NSString *)tip WithCategory:(NSString *)category;

+ (instancetype)tipWithText:(NSString *)tip Category:(NSString *)category User:(PFUser *)user;
- (instancetype)initWithClassName:(NSString *)newClassName WithTip:(NSString *)tip WithCategory:(NSString *)category WithUser:(PFUser *)user;

@end
