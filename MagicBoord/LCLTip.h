//
//  LCLTip.h
//  MagicBoord
//
//  Created by Leonard Li on 3/14/14.
//  Copyright (c) 2014 Leonard Li. All rights reserved.
//

#import <Parse/Parse.h>

@interface LCLTip : PFObject <PFSubclassing>

@property (strong, nonatomic) NSString *number;
@property (strong, nonatomic) NSString *tip;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) NSString *subcategory;
@property (strong, nonatomic) NSString *hashtag;

+ (NSString *)parseClassName;

+ (instancetype)tipWithText:(NSString *)tip
                     Number:(NSInteger)number
                     Author:(NSString *)author
                   Category:(NSString *)category
                Subcategory:(NSString *)subcategory;

- (instancetype)initWithClassName:(NSString *)newClassName
                           Number:(NSInteger)number
                              Tip:(NSString *)tip
                           Author:(NSString *)author
                         Category:(NSString *)category
                      Subcategory:(NSString *)subcategory;
@end
