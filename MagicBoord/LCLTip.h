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
@property (nonatomic) NSInteger startHour;
@property (nonatomic) NSInteger endHour;
@property (strong, nonatomic) NSString *category;

+ (instancetype)tipWithText:(NSString *)tip Category:(NSString *)category;
+ (instancetype)defaultTipWithText:(NSString *)tip;
- (instancetype)initWithClassName:(NSString *)newClassName WithTip:(NSString *)tip WithCategory:(NSString *)category;
- (instancetype)initNoSaveWithClassName:(NSString *)newClassName WithTip:(NSString *)tip;
@end
