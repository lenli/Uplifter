//
//  LCLAppDelegate.h
//  MagicBoord
//
//  Created by Leonard Li on 3/14/14.
//  Copyright (c) 2014 Leonard Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCLTipsDataStore.h"

@interface LCLAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) LCLTipsDataStore *dataStore;
@end
