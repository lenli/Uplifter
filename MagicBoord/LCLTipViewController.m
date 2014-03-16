//
//  LCLTipViewController.m
//  MagicBoord
//
//  Created by Leonard Li on 3/15/14.
//  Copyright (c) 2014 Leonard Li. All rights reserved.
//

#import "LCLTipViewController.h"
#import "LCLTip.h"

@interface LCLTipViewController ()
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UIButton *dislikeButton;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (strong, nonatomic) LCLTip *currentTip;
@property (strong, nonatomic) NSArray *allTips;

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
    [self displayLoadingMessage];
    [self getRandomTip];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Helper Methods

- (void)displayLoadingMessage
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading";
}

- (void)hideLoadingMessage
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

- (void)getRandomTip
{
    PFQuery *tipQuery = [PFQuery queryWithClassName:@"LCLTip"];
    NSUInteger randomIndex = arc4random_uniform([tipQuery countObjects]);
    [tipQuery findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        // get random tip
        self.currentTip = [results objectAtIndex:randomIndex];
        self.tipLabel.text = self.currentTip.tip;
        
        // create relations between user and tip
        
        [self hideLoadingMessage];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
