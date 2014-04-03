//
//  LCLAppDelegate.m
//  MagicBoord
//
//  Created by Leonard Li on 3/14/14.
//  Copyright (c) 2014 Leonard Li. All rights reserved.
//

#import "LCLAppDelegate.h"

@implementation LCLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [LCLTip registerSubclass];
    [LCLUser registerSubclass];
    [LCLRating registerSubclass];
    
    self.dataStore.currentUserTips = [NSMutableArray new];
    self.dataStore.currentUserUnseenTips = [NSMutableArray new];
    self.dataStore.tips = [NSMutableArray new];
    self.dataStore.ratings = [NSMutableArray new];
    
    [Parse setApplicationId:@"sQlOhsEuKc3PM0gZtoCNLPf6X4VVDdsVhqV1xKDU"
                  clientKey:@"o5xMW54dBllSp2nSuU1aPBKotx3q2hxvzqsFoBWd"];
    
    [LCLUser enableAutomaticUser];
    [[LCLUser currentUser] saveInBackground];
    
//    [[LCLUser currentUser] incrementKey:@"RunCount"];
    
//
//    [PFAnonymousUtils logInWithBlock:^(PFUser *user, NSError *error) {
//        if (error) {
//            NSLog(@"Anonymous login failed: %@", error);
//            NSLog(@"%@", user);
//        } else {
//            NSLog(@"Anonymous user logged in.");
//        }
//    }];
    
    PFACL *defaultACL = [PFACL ACL];
    
    // If you would like all objects to be private by default, remove this line.
    [defaultACL setPublicReadAccess:YES];
    
    [PFACL setDefaultACL:defaultACL withAccessForCurrentUser:YES];

    if (application.applicationState != UIApplicationStateBackground) {
        // Track an app open here if we launch with a push, unless
        // "content_available" was used to trigger a background push (introduced
        // in iOS 7). In that case, we skip tracking here to avoid double
        // counting the app-open.
        BOOL preBackgroundPush = ![application respondsToSelector:@selector(backgroundRefreshStatus)];
        BOOL oldPushHandlerOnly = ![self respondsToSelector:@selector(application:didReceiveRemoteNotification:fetchCompletionHandler:)];
        BOOL noPushPayload = ![launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if (preBackgroundPush || oldPushHandlerOnly || noPushPayload) {
            [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
        }
    }
    
    [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|
     UIRemoteNotificationTypeAlert|
     UIRemoteNotificationTypeSound];
    
//    [self createData];

    return YES;
}

//-(void)createData
//{
//    PFQuery *tipQuery = [LCLTip query];
//    [tipQuery findObjectsInBackgroundWithBlock:^(NSArray *tips, NSError *error) {
//        if ([tips count] > 0) {
//            NSLog(@"Tips Exist");
//        } else {
//            LCLTip *newTip1 = [LCLTip tipWithText:@"Call someone important to you and let you know how much you care about them. Don’t call collect if you can’t afford it." Category:@"Personal"];
//            LCLTip *newTip2 = [LCLTip tipWithText:@"Tell the person closest to you that their shoe is untied. When he or she looks down to check, giggle and shrug." Category:@"Personal"];
//            LCLTip *newTip3 = [LCLTip tipWithText:@"Go to the coffee shop for a cup of brew.  Then strike up conversation with someone new." Category:@"Personal"];
//            LCLTip *newTip4 = [LCLTip tipWithText:@"Do 20 push ups. Unless you are in a pool. Then just continue swimming." Category:@"Personal"];
//            LCLTip *newTip5 = [LCLTip tipWithText:@"Try parting your hair differently.  See if anyone notices." Category:@"Personal"];
//            LCLTip *newTip6 = [LCLTip tipWithText:@"Ahem. This is your mother. Go clean your room. Now." Category:@"Personal"];
//            LCLTip *newTip7 = [LCLTip tipWithText:@"Look around. Is anybody near you? If not, fart. If someone is, fart, and then apologize." Category:@"Personal"];
//            NSLog(@"New Tip Created: %@", newTip1.tipTitle);
//            NSLog(@"New Tip Created: %@", newTip2.tipTitle);
//            NSLog(@"New Tip Created: %@", newTip3.tipTitle);
//            NSLog(@"New Tip Created: %@", newTip4.tipTitle);
//            NSLog(@"New Tip Created: %@", newTip5.tipTitle);
//            NSLog(@"New Tip Created: %@", newTip6.tipTitle);
//            NSLog(@"New Tip Created: %@", newTip7.tipTitle);
//        }
//    }];
//}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)newDeviceToken {
    [PFPush storeDeviceToken:newDeviceToken];
    [PFPush subscribeToChannelInBackground:@"" target:self selector:@selector(subscribeFinished:error:)];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    if (error.code == 3010) {
        NSLog(@"Push notifications are not supported in the iOS Simulator.");
    } else {
        // show some alert or otherwise handle the failure to register.
        NSLog(@"application:didFailToRegisterForRemoteNotificationsWithError: %@", error);
	}
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
    
    if (application.applicationState == UIApplicationStateInactive) {
        [PFAnalytics trackAppOpenedWithRemoteNotificationPayload:userInfo];
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    if (application.applicationState == UIApplicationStateInactive) {
        [PFAnalytics trackAppOpenedWithRemoteNotificationPayload:userInfo];
    }
}

#pragma mark - ()

- (void)subscribeFinished:(NSNumber *)result error:(NSError *)error {
    if ([result boolValue]) {
        NSLog(@"ParseStarterProject successfully subscribed to push notifications on the broadcast channel.");
    } else {
        NSLog(@"ParseStarterProject failed to subscribe to push notifications on the broadcast channel.");
    }
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    NSLog(@"%@", notification.alertBody);
}


@end
