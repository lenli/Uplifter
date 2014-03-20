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
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    [MBProgressHUDHelpers showLoadingMessageForView:self.view];
    [self getTipsForKey:@"users" Completion:^(NSArray *tips) {
        self.tipsForUser = tips;
        [self getTipsForKey:@"usersLiked" Completion:^(NSArray *tips) {
            self.tipsUserLiked = tips;
            [self getTipsForKey:@"usersDisliked" Completion:^(NSArray *tips) {
                self.tipsUserDisliked = tips;
                [self.tableview reloadData];
                [MBProgressHUDHelpers hideLoadingMessageForView:self.view];
            }];
        }];
    }];


    
    // Do any additional setup after loading the view.
}

- (void)getTipsForKey:(NSString *)keyString Completion:(void (^)(NSArray *))completionBlock
{
    PFQuery *tipQuery = [LCLTip query];
    [tipQuery whereKey:keyString equalTo:[PFUser currentUser]];
    
    [tipQuery findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        if (results) {
            completionBlock(results);
        } else {
            completionBlock(@[]);
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self tipsForUser] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"tipCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    LCLTip *currentTip = [self tipsForUser][indexPath.row];
    
    cell.userInteractionEnabled = NO;
    cell.textLabel.text = currentTip.tipTitle;
//    if ([self.tipsUserDisliked containsObject:currentTip]) {
//        cell.textLabel.textColor = [UIColor whiteColor];
//        [cell setBackgroundColor:[UIColor colorWithRed:(230/255.0) green:(196/255.0) blue:(15/255) alpha:1]];
//    } else if ([self.tipsUserLiked containsObject:currentTip]) {
        cell.textLabel.textColor = [UIColor whiteColor];
        [cell setBackgroundColor:[UIColor colorWithRed:(39/255.0) green:(174/255.0) blue:(96/255) alpha:1]];
//    }
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

@end
