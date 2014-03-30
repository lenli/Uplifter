//
//  LCLTipViewController.m
//  MagicBoord
//
//  Created by Leonard Li on 3/15/14.
//  Copyright (c) 2014 Leonard Li. All rights reserved.
//

#import "LCLTipViewController.h"

@interface LCLTipViewController ()
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UIButton *dislikeButton;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@end

@implementation LCLTipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataStore = [LCLTipsDataStore sharedDataStore];
    
    [MBProgressHUD showRandomMessage:@"randomizing" ForView:self.view];
    [self randomizeLikeButtonText];
    [self getRandomTip];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Helper Methods
- (void)getRandomTip
{
    [self fetchTipsAndRatingsAndSelectRandomTip];
    
}

- (void)fetchTipsAndRatingsAndSelectRandomTip
{
    // Fetch tips into datastore tips
    PFQuery *tipQuery = [PFQuery queryWithClassName:@"LCLTip"];
    [tipQuery findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        if (results) {
            self.dataStore.tips = [NSMutableArray arrayWithArray:results];
            [self fetchRatings];
        }
        if (error) {
            NSLog(@"Error Getting Tips: %@", error);
        }
    }];
}

- (void)fetchRatings
{
    // Fetch ratings and determine user's seen tips into datastore currentTips
    PFQuery *ratingQuery = [LCLRating query];
    [ratingQuery whereKey:@"user" equalTo:[LCLUser currentUser]];
    [ratingQuery orderByDescending:@"createdAt"];
    
    [ratingQuery findObjectsInBackgroundWithBlock:^(NSArray *ratings, NSError *error) {
        if (!error) {
            for (LCLRating *rating in ratings) {
                NSMutableArray *currentTips = [[NSMutableArray alloc] init];
                [currentTips addObject:rating.tip];
                self.dataStore.currentUserTips = currentTips;
                [LCLTip fetchAllIfNeeded:currentTips];
            }
            [self selectRandomTip];
        } else {
            NSLog(@"Ratings Not Found for User");
        }
    }];
}

- (void)selectRandomTip
{
    // Find unseen tips
    self.dataStore.currentUserUnseenTips = self.dataStore.tips;
    [self.dataStore.currentUserUnseenTips removeObjectsInArray:self.dataStore.currentUserTips];
    
    NSUInteger randomIndex = arc4random_uniform([self.dataStore.currentUserUnseenTips count]);
    self.dataStore.currentTip = self.dataStore.currentUserUnseenTips[randomIndex];
    self.tipLabel.text = self.dataStore.currentTip.tip;
    [LCLRating ratingWithUser:[LCLUser currentUser] Tip:self.dataStore.currentTip Rating:@0];
    NSLog(@"Selecting tip: %@", self.dataStore.currentTip.tipTitle);
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"tipLastReceivedDate"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.dataStore.currentUserTips addObject:self.dataStore.currentTip];
    NSLog(@"Current Tips: %@", self.dataStore.currentUserTips);
    [self.dataStore.currentUserUnseenTips removeObject:self.dataStore.currentTip];
    NSLog(@"Unseen: %@", self.dataStore.currentUserUnseenTips);
    
    self.likeButton.hidden = NO;
    self.dislikeButton.hidden = NO;
    [MBProgressHUD hideLoadingMessageForView:self.view];
}

- (void)randomizeLikeButtonText
{
    NSArray *likeText =  @[@"You so funny",
                           @"Ha ha nice one",
                           @"Not bad",
                           @"Me likey",
                           @"#Awesome",
                           @"Great shot kid",
                           @"Beam me up",
                           @"Badass",
                           @"Yummy!",
                           @"That’s hot"
                           ];
    
    NSUInteger randomLikeIndex = arc4random_uniform([likeText count]);

    NSString *likeString = [NSString stringWithFormat:@"%@ %@", likeText[randomLikeIndex], @"\u2713"];
    [self.likeButton setTitle:likeString forState: UIControlStateNormal];
    
    NSArray *dislikeText =  @[@"Could be better",
                              @"Eek <Crickets>",
                              @"No good",
                              @"Me no likey",
                              @"#Fail",
                              @"Try again",
                              @"No soup for you",
                              @"Alrighty then",
                              @"Weaksauce",
                              @"Lame"
                              ];
    
    NSString *dislikeString = [NSString stringWithFormat:@"%@ %@", dislikeText[randomLikeIndex], @"\u2715"];
    [self.dislikeButton setTitle:dislikeString forState: UIControlStateNormal];
}

#pragma mark - IBActions Methods

- (IBAction)likeButtonPressed:(UIButton *)sender
{
    self.dataStore.currentRating = @1;
}
- (IBAction)dislikeButtonPressed:(UIButton *)sender
{
    self.dataStore.currentRating = @-1;
}

@end
