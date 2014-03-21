//
//  LCLTipHistoryViewController.m
//  
//
//  Created by Leonard Li on 3/16/14.
//
//

#import "LCLTipHistoryViewController.h"

@interface LCLTipHistoryViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UILabel *countdownLabel;

@end

@implementation LCLTipHistoryViewController
NSInteger const TIMER_WAIT_TIME_SECONDS = 1200;

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
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.countdownLabel.text = @"";
    self.dataStore = [LCLTipsDataStore sharedDataStore];
    
    [MBProgressHUD showLoadingMessage:@"Loading" ForView:self.view];
    [LCLRating updateRating:self.dataStore.currentRating ForUser:self.dataStore.currentUser AndTip:self.dataStore.currentTip WithCompletion:^(BOOL success) {
        [self getTipsWithCompletion:^(NSArray *ratings) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self startCountdownSinceLastTipForDuration:TIMER_WAIT_TIME_SECONDS];
                self.ratingsForUser = ratings;
                [self.tableview reloadData];
                [MBProgressHUD hideLoadingMessageForView:self.view];
            });
        }];
    } ];
    
}

- (void)startCountdownSinceLastTipForDuration:(NSInteger)waitSeconds
{
    [LCLRating getTimeSinceLastTipForUser:self.dataStore.currentUser WithCompletion:^(NSNumber *seconds) {
        MZTimerLabel *timer = [[MZTimerLabel alloc] initWithLabel:self.countdownLabel andTimerType:MZTimerLabelTypeTimer];
        timer.timeFormat = @"mm:ss";
        [timer setCountDownTime:waitSeconds-[seconds integerValue]];
        [timer start];
    }];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    LCLRating *currentRating = [self ratingsForUser][indexPath.row];
    LCLTip *currentTip = currentRating.tip;
    
    cell.userInteractionEnabled = NO;
    cell.textLabel.text = currentTip.tipTitle;
    cell.textLabel.textColor = [UIColor whiteColor];
    
    if ([currentRating.rating integerValue] == 1) {
        [cell setBackgroundColor:[UIColor colorWithRed:(39/255.0) green:(174/255.0) blue:(96/255) alpha:1]];
    } else if ([currentRating.rating integerValue] == -1) {
        [cell setBackgroundColor:[UIColor colorWithRed:(230/255.0) green:(196/255.0) blue:(15/255) alpha:1]];
    } else {
        [cell setBackgroundColor:[UIColor lightGrayColor]];
    }
    
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableview reloadData];
    return nil;
}


@end
