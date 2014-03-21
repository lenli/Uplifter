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
    // Do any additional setup after loading the view.
    [MBProgressHUD showLoadingMessage:@"Randomizing" ForView:self.view];
    
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
    
    PFQuery *tipQuery = [PFQuery queryWithClassName:@"LCLTip"];
    
    [tipQuery findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        if (results) {
            // get random tip
            
            self.dataStore.currentUser = [LCLUser currentUser];
            
            BOOL tipNew = NO;
            while (!tipNew) {
                NSUInteger randomIndex = arc4random_uniform([tipQuery countObjects]);
                self.dataStore.currentTip = results[randomIndex];
                tipNew = [LCLRating checkIfUser:self.dataStore.currentUser HasSeenTip:self.dataStore.currentTip];
                NSLog(@"Checking: %@", self.dataStore.currentTip.tipTitle);
            }
            
            self.tipLabel.text = self.dataStore.currentTip.tip;
            [LCLRating ratingWithUser:self.dataStore.currentUser Tip:self.dataStore.currentTip Rating:@0];
            [MBProgressHUD hideLoadingMessageForView:self.view];
        }
        if (error) {
            NSLog(@"Error Getting Tips: %@", error);
        }
    }];
    
}


#pragma mark - IBActions Methods

- (IBAction)likeButtonPressed:(UIButton *)sender
{
    self.dataStore.currentRating = @1;
    [self performSegueWithIdentifier:@"likeButtonSegue" sender:sender];
}
- (IBAction)dislikeButtonPressed:(UIButton *)sender
{
    self.dataStore.currentRating = @-1;
    [self performSegueWithIdentifier:@"dislikeButtonSegue" sender:sender];
}

@end
