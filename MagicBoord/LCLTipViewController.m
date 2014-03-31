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
@property (weak, nonatomic) IBOutlet UIView *displayView;
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
    [self setupUI];
    
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
            
            NSMutableSet *currentTips = [NSMutableSet new];
            for (LCLRating *rating in ratings) {
                [currentTips addObject:rating.tip.objectId];
                
            }
            
            NSMutableArray *unseenTips = [NSMutableArray new];
            NSMutableArray *seenTips = [NSMutableArray new];
            
            for (LCLTip *tip in self.dataStore.tips) {
                if ([currentTips containsObject:tip.objectId]) {
                    [seenTips addObject:tip];
                } else {
                    [unseenTips addObject:tip];
                }
            }
            self.dataStore.currentUserUnseenTips = unseenTips;
            self.dataStore.currentUserTips = seenTips;
            
            [LCLTip fetchAllIfNeeded:seenTips];
            [self selectRandomTip];
        } else {
            NSLog(@"Ratings Not Found for User");
        }
    }];
}

- (void)selectRandomTip
{
    // Find unseen tips
    if ([self.dataStore.currentUserUnseenTips count] > 0 ) {
        // Get Random Tip From Unseen
        NSUInteger randomIndex = arc4random_uniform([self.dataStore.currentUserUnseenTips count]);
        self.dataStore.currentTip = self.dataStore.currentUserUnseenTips[randomIndex];
        self.tipLabel.text = self.dataStore.currentTip.tip;
        [LCLRating ratingWithUser:[LCLUser currentUser] Tip:self.dataStore.currentTip Rating:@0];
    } else {
        // Create Default Tip
        self.tipLabel.text = @"Sit down.  Seriously, you’ve seen all our tips.  We love you too, but maybe it’s time you shared this?";
        self.dataStore.currentTip = nil;
    }
    
    // Save Last Tip Date
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"tipLastReceivedDate"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
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
                           @"Yummy",
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
-(void)setupUI
{
    [UIViewController setBackgroundImage:[UIImage imageNamed:@"CheckerBoard.png"] ForView:self.displayView];
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
