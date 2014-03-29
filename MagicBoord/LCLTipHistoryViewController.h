//
//  LCLTipHistoryViewController.h
//  
//
//  Created by Leonard Li on 3/16/14.
//
//

#import <UIKit/UIKit.h>
#import "LCLTipsDataStore.h"

@interface LCLTipHistoryViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSArray *ratingsForUser;
@property (strong, nonatomic) LCLTipsDataStore *dataStore;
@property (strong, nonatomic) NSUserDefaults *standardUserDefaults;

extern NSInteger const TIMER_WAIT_TIME_SECONDS;

@end
