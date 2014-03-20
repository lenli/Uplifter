//
//  LCLTipHistoryViewController.h
//  
//
//  Created by Leonard Li on 3/16/14.
//
//

#import <UIKit/UIKit.h>
#import "MBProgressHUDHelpers.h"
#import "LCLUser.h"
#import "LCLTip.h"

@interface LCLTipHistoryViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSArray *tipsForUser;
@property (strong, nonatomic) NSArray *tipsUserLiked;
@property (strong, nonatomic) NSArray *tipsUserDisliked;

@end
