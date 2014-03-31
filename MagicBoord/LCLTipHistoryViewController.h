//
//  LCLTipHistoryViewController.h
//  
//
//  Created by Leonard Li on 3/16/14.
//
//

#import <UIKit/UIKit.h>
#import "LCLTipsDataStore.h"
#import "UIViewController+Helpers.h"

@interface LCLTipHistoryViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSArray *ratingsForUser;
@property (strong, nonatomic) LCLTipsDataStore *dataStore;

extern NSInteger const TIMER_WAIT_TIME_SECONDS;

@end
