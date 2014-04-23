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
@dynamic number;
@dynamic tip;
@dynamic title;
@dynamic author;
@dynamic category;
@dynamic subcategory;
@dynamic hashtag;


# pragma mark - Setters and Getters
+ (NSString *)parseClassName {
    return @"LCLTip";
}

# pragma mark - Init Methods
+ (instancetype)tipWithText:(NSString *)tip
                     Number:(NSInteger)number
                     Author:(NSString *)author
                   Category:(NSString *)category
                Subcategory:(NSString *)subcategory

{
    return [[self alloc] initWithClassName:[LCLTip parseClassName]
                                   Number:number
                                       Tip:tip
                                    Author:author
                                  Category:category
                               Subcategory:subcategory];
}

- (instancetype)initWithClassName:(NSString *)newClassName
                           Number:(NSInteger)number
                              Tip:(NSString *)tip
                           Author:(NSString *)author
                         Category:(NSString *)category
                      Subcategory:(NSString *)subcategory
{
    self = [super init];
    if (self) {
        self.tip = tip ? tip : @"";
        self.number = [NSString stringWithFormat:@"%04ld", (long)number];
        self.title = tip ? [self shortenString:tip ToWords:4] : @"";
        self.author = author ? author : @"";
        self.category = category ? category : @"";
        self.subcategory = subcategory ? subcategory : @"";
        self.hashtag = [NSString stringWithFormat:@"#%@", self.number];
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
