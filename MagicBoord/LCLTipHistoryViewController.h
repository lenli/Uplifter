//
//  LCLTipHistoryViewController.h
//  
//
//  Created by Leonard Li on 3/16/14.
//
//

#import <UIKit/UIKit.h>
#import "LCLUser.h"
#import "LCLTip.h"
#import "LCLRating.h"
#import "MBProgressHUD+Helpers.h"

@interface LCLTipHistoryViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSArray *ratingsForUser;

@end
