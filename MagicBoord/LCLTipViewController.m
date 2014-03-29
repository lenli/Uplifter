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
    
    [self randomizeWaitMessageText];
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
                
                NSLog(@"Current Tips: %@", currentTips);
            }
            NSLog(@"CurrentUserTips: %@", self.dataStore.currentUserTips);
            NSLog(@"Rating: %@", ratings);
            [self selectRandomTip];
        } else {
            NSLog(@"Ratings Not Found for User");
        }
    }];
}

- (void)selectRandomTip
{
    NSUInteger randomIndex = arc4random_uniform([self.dataStore.tips count]);
    self.dataStore.currentUserUnseenTips = self.dataStore.tips;
    for (LCLTip *tip in self.dataStore.currentUserTips) {
        NSMutableArray *currentUnseen = [NSMutableArray new];
        [self.dataStore.currentUserUnseenTips removeObject:tip];
        NSLog(@"Removing tip: %@", tip.tipTitle);
    }
    
    self.dataStore.currentTip = self.dataStore.currentUserUnseenTips[randomIndex];
    self.tipLabel.text = self.dataStore.currentTip.tip;
    NSLog(@"Selecting tip: %@", self.dataStore.currentTip.tipTitle);
    
    [LCLRating ratingWithUser:[LCLUser currentUser] Tip:self.dataStore.currentTip Rating:@0];
    
    [self.dataStore.currentUserTips addObject:self.dataStore.currentTip];
    NSLog(@"Current Tips: %@", self.dataStore.currentUserTips);
    [self.dataStore.currentUserUnseenTips removeObject:self.dataStore.currentTip];
    NSLog(@"Unseen: %@", self.dataStore.currentUserUnseenTips);
    
    
    [MBProgressHUD hideLoadingMessageForView:self.view];
}

- (void)randomizeWaitMessageText
{
    NSArray *messages = @[@"Randomizing",
                          @"Deciding your fate",
                          @"Rolling the dice",
                          @"Attention on deck",
                          @"All boredom are belong to us",
                          @"Finding the meaning of life",
                          @"Curing cancer",
                          @"Witty wait message here",
                          @"Using the force",
                          @"Searching your feelings",
                          @"Be afraid - Be very afraid",
                          @"Setting thrusters to full"
                          ];
    NSUInteger randomMessageIndex = arc4random_uniform([messages count]);
    [MBProgressHUD showLoadingMessage:messages[randomMessageIndex] ForView:self.view];
}

- (void)randomizeLikeButtonText
{
    NSArray *dislikeText =  @[@"Could be better",
                              @"Eek <Crickets>",
                              @"No good",
                              @"Me no likey",
                              @"#Fail",
                              @"That is why you fail",
                              @"Assimilate this",
                              @"It was... fun...",
                              @"Alrighty then"
                              ];
    NSArray *likeText =  @[@"You so funny",
                           @"Ha ha nice one",
                           @"Not bad",
                           @"Me likey",
                           @"#Awesome",
                           @"Great shot kid",
                           @"Live long and prosper",
                           @"Beam me up",
                           @"Yummy!"
                           ];
    
    NSUInteger randomLikeIndex = arc4random_uniform([likeText count]);
    [self.likeButton setTitle:likeText[randomLikeIndex] forState: UIControlStateNormal];
    [self.dislikeButton setTitle:dislikeText[randomLikeIndex] forState: UIControlStateNormal];
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
