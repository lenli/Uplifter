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
        if (results) {
            // get random tip
            self.currentTip = results[randomIndex];
            self.tipLabel.text = self.currentTip.tip;
            
            // create relations between user and tip
            [self addTip:results[randomIndex] ToCurrentUserForRelation:@"tips"];
            [self addCurrentUserToTip:results[randomIndex] ForRelation:@"users"];
            
            [self hideLoadingMessage];
        }
    }];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"likeButtonSegue"]) {
        [self addCurrentUserToTip:self.currentTip ForRelation:@"usersLiked"];
    } else if ([segue.identifier isEqualToString:@"dislikeButtonSegue"]) {
        [self addCurrentUserToTip:self.currentTip ForRelation:@"usersDisliked"];
    }
}


#pragma mark - Helper Methods

- (void)addTip:(LCLTip *)tip ToCurrentUserForRelation:(NSString *)tipRelationString
{
    PFRelation *userTip = [[LCLUser currentUser] relationForKey:tipRelationString];
    [userTip addObject:tip];
    [[LCLUser currentUser] save];
}

- (void)addCurrentUserToTip:(LCLTip *)tip ForRelation:(NSString *)userRelationString
{
    PFRelation *tipUser = [tip relationForKey:userRelationString];
    [tipUser addObject:[LCLUser currentUser]];
    [tip save];
}

@end
