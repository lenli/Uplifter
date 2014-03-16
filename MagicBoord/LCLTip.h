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
@property (strong, nonatomic) NSMutableArray *users;
@property (strong, nonatomic) NSMutableArray *usersLiked;
@property (strong, nonatomic) NSMutableArray *usersDisliked;
@property (nonatomic) NSInteger startHour;
@property (nonatomic) NSInteger endHour;
@property (strong, nonatomic) NSString *category;

+ (instancetype)tipWithText:(NSString *)tip Category:(NSString *)category;
- (instancetype)initWithClassName:(NSString *)newClassName WithTip:(NSString *)tip WithCategory:(NSString *)category;

@end
