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
@property (strong, nonatomic) LCLTip *currentTip;

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
    
    // Do any additional setup after loading the view.
    [MBProgressHUD showLoadingMessage:@"Loading" ForView:self.view];
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
    NSUInteger randomIndex = arc4random_uniform([tipQuery countObjects]);
    [tipQuery findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        if (results) {
            // get random tip
            self.currentTip = results[randomIndex];
            self.tipLabel.text = self.currentTip.tip;
            [LCLRating ratingWithUser:[LCLUser currentUser] Tip:self.currentTip Rating:@0];
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
    
    [LCLRating updateRating:@1 ForUser:[LCLUser currentUser] AndTip:self.currentTip];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self performSegueWithIdentifier:@"likeButtonSegue" sender:sender];
    });
}
- (IBAction)dislikeButtonPressed:(UIButton *)sender
{
    [LCLRating updateRating:@-1 ForUser:[LCLUser currentUser] AndTip:self.currentTip];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self performSegueWithIdentifier:@"dislikeButtonSegue" sender:sender];
    });
}

@end
