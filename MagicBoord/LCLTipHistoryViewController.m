//
//  LCLTipHistoryViewController.m
//  
//
//  Created by Leonard Li on 3/16/14.
//
//

#import "LCLTipHistoryViewController.h"
#import "LCLTipTableViewCell.h"

@interface LCLTipHistoryViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UILabel *countdownLabel;
@property (weak, nonatomic) IBOutlet UIView *messageView;

@end

@implementation LCLTipHistoryViewController

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
    [self setupMessageView];
    [self setupTableView];
    self.dataStore = [LCLTipsDataStore sharedDataStore];

    
    [MBProgressHUD showRandomMessage:@"waiting" ForView:self.view];
    if (self.dataStore.currentTip) {
        [LCLRating updateRating:self.dataStore.currentRating ForUser:[LCLUser currentUser] AndTip:self.dataStore.currentTip WithCompletion:^(BOOL success) {
            [self getTipsForUser];
        }];
    } else {
        [self getTipsForUser];
    }

    
}

#pragma mark - IBActions

- (IBAction)shareButtonPressed:(UIButton *)sender
{
    //    NSArray *array = [self.navigationController viewControllers];
    //    NSLog(@"%@", array);
    //    [self.navigationController popToViewController:[array objectAtIndex:0] animated:YES];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:[NSArray arrayWithObjects:@"Check out this cool app called Uplifter:  http://lenli.com", nil] applicationActivities:nil];
    activityVC.excludedActivityTypes = @[ UIActivityTypeAddToReadingList, UIActivityTypeAirDrop, UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll];
    [self presentViewController:activityVC animated:YES completion:nil];
}

#pragma mark - Setup Tableview

- (void)setupMessageView
{
    UIGraphicsBeginImageContext(self.messageView.frame.size);
    [[UIImage imageNamed:@"CheckerBoard.png"] drawAsPatternInRect:self.messageView.bounds];
    UIImage *checkerBG = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.messageView.backgroundColor = [UIColor colorWithPatternImage:checkerBG];
    self.countdownLabel.text = @"";
}
- (void)setupTableView
{
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorColor = [UIColor clearColor];
}

- (void)getTipsForUser
{
    [self getTipsWithCompletion:^(NSArray *ratings) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self startCountdownSinceLastTipForDuration:TIMER_WAIT_TIME_SECONDS];
            self.ratingsForUser = ratings;
            [self.tableview reloadData];
            [MBProgressHUD hideLoadingMessageForView:self.view];
        });
    }];
}

- (void)startCountdownSinceLastTipForDuration:(NSInteger)waitSeconds
{
    NSTimeInterval secondsSinceLastTip = 0;
    NSDate *lastTipDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"tipLastReceivedDate"];
    if (lastTipDate) secondsSinceLastTip = [[NSDate date] timeIntervalSinceDate:lastTipDate];
    
    MZTimerLabel *timer = [[MZTimerLabel alloc] initWithLabel:self.countdownLabel andTimerType:MZTimerLabelTypeTimer];
    timer.timeFormat = @"mm:ss";
    [timer setCountDownTime:waitSeconds-secondsSinceLastTip];
    [timer start];
}

- (void)getTipsWithCompletion:(void (^)(NSArray *))completionBlock
{
    PFQuery *ratingQuery = [LCLRating query];
    [ratingQuery whereKey:@"user" equalTo:[LCLUser currentUser]];
    [ratingQuery orderByDescending:@"createdAt"];
    
    [ratingQuery findObjectsInBackgroundWithBlock:^(NSArray *ratings, NSError *error) {
        if (!error) {
            NSMutableArray *tips = [NSMutableArray new];
            for (LCLRating *rating in ratings) {
                [tips addObject:rating.tip];
            }
            [LCLTip fetchAllIfNeeded:tips];
            completionBlock(ratings);
        } else {
            NSLog(@"Ratings Not Found for User");
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableview Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self ratingsForUser] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"tipCell";
    LCLTipTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    LCLRating *currentRating = [self ratingsForUser][indexPath.row];
    LCLTip *currentTip = currentRating.tip;
    
    cell.userInteractionEnabled = NO;
    cell.textLabel.text = currentTip.tipTitle;
    cell.textLabel.textColor = [UIColor whiteColor];
    
    if ([currentRating.rating integerValue] == 1) {
        [cell setBackgroundColor:[UIColor colorWithRed:(39/255.0) green:(174/255.0) blue:(96/255) alpha:0.25]];
    } else if ([currentRating.rating integerValue] == -1) {
        [cell setBackgroundColor:[UIColor colorWithRed:(230/255.0) green:(196/255.0) blue:(15/255) alpha:0.25]];
    } else {
        [cell setBackgroundColor:[UIColor lightGrayColor]];
    }
    
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableview reloadData];
    return nil;
}

#pragma mark - Helper Methods



@end
