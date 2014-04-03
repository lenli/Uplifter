//
//  LCLMainViewController.m
//  MagicBoord
//
//  Created by Leonard Li on 3/16/14.
//  Copyright (c) 2014 Leonard Li. All rights reserved.
//

#import "LCLMainViewController.h"
#import "LCLTipViewController.h"

@interface LCLMainViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *redButton;
@property (strong, nonatomic) UIImageView *mainButtonFlipped;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UIView *displayView;

@end

@implementation LCLMainViewController

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
    [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(swapTitleText) userInfo:nil repeats:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.redButton setImage:[UIImage imageNamed:@"Lever"] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)resetButtonPressed:(UIButton *)sender
{
    [MBProgressHUD showLoadingMessage:@"Resetting Tips" ForView:self.view];
    
    // Delete last tip date
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"tipLastReceivedDate"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // Delete ratings for user
    PFQuery *ratingQuery = [PFQuery queryWithClassName:@"LCLRating"];
    [ratingQuery whereKey:@"user" equalTo:[LCLUser currentUser]];
    [ratingQuery findObjectsInBackgroundWithBlock:^(NSArray *ratings, NSError *error) {
        if (!error) {
            for (LCLRating *rating in ratings) {
                [rating deleteInBackground];
            }
        } else {
            NSLog(@"Ratings not found for delete");
        }
        [MBProgressHUD hideLoadingMessageForView:self.view];
    }];
    
}

- (IBAction)mainButtonPressed:(UIButton *)sender
{
    [self.redButton setImage:[UIImage imageNamed:@"LeverFlipped"] forState:UIControlStateHighlighted];
    [self.redButton setImage:[UIImage imageNamed:@"LeverFlipped"] forState:UIControlStateSelected];
    [self.redButton setImage:[UIImage imageNamed:@"LeverFlipped"] forState:UIControlStateNormal];

    NSTimeInterval secondsSinceLastTip = 0;
    NSDate *lastTipDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"tipLastReceivedDate"];
    if (lastTipDate) secondsSinceLastTip = [[NSDate date] timeIntervalSinceDate:lastTipDate];
    
    //    [self performSegueWithIdentifier:@"mainToTipSegue" sender:sender];
    
    if (secondsSinceLastTip >= TIMER_WAIT_TIME_SECONDS || secondsSinceLastTip == 0) {
        [self performSegueWithIdentifier:@"mainToTipSegue" sender:sender];
    } else {
        [self performSegueWithIdentifier:@"mainToTipHistorySegue" sender:sender];
    }


}


#pragma mark - Helper Methods
- (void)setupUI
{
    // Set up navbar
    [UIViewController setupNavigationBar:self.navigationController.navigationBar WithFont:@"Avenir-Roman" WithFontSize:28 WithVerticalPosition:3.f];
    
    // Set background for displayView
    [UIViewController setBackgroundImage:[UIImage imageNamed:@"CheckerBoard"] ForView:self.displayView];
    
    // Set up gesture recognizers
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(mainButtonPressed:)];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipeUp];

}

- (void)swapTitleText
{
    [UIView animateWithDuration:1.0
                           delay:0.0  /* starts the animation after 3 seconds */
                         options:UIViewAnimationOptionCurveEaseInOut
                      animations:^ {
                          self.titleLabel.alpha = 0.0;
                          self.subtitleLabel.text = @"[  lift the lever  ]";
                      }
                      completion:^(BOOL finished) {
                          self.titleLabel.text = [self.dataStore getRandomTitleText];
                          self.titleLabel.alpha = 1.0;
                          self.subtitleLabel.text = @"[   lift the lever   ]";
                      }];
    
}


@end
