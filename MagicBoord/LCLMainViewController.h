//
//  LCLMainViewController.h
//  MagicBoord
//
//  Created by Leonard Li on 3/16/14.
//  Copyright (c) 2014 Leonard Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCLTipsDataStore.h"
#import "UIViewController+Helpers.h"

@interface LCLMainViewController : UIViewController <UIAlertViewDelegate>
@property (strong, nonatomic) LCLTipsDataStore *dataStore;

@end
