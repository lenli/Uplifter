//
//  LCLMainViewController.m
//  MagicBoord
//
//  Created by Leonard Li on 3/16/14.
//  Copyright (c) 2014 Leonard Li. All rights reserved.
//

#import "LCLMainViewController.h"

@interface LCLMainViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *redButton;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)resetButtonPressed:(UIButton *)sender
{
    [MBProgressHUD showLoadingMessage:@"Resetting Tips" ForView:self.view];
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

@end
