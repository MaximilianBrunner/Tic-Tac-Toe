//
//  MBAppDelegate.m
//  Tic Tac Toe
//
//  Created by Beatrix Brunner on 29.03.13.
//  Copyright (c) 2013 Maximilian Brunner. All rights reserved.
//

#import "MBAppDelegate.h"
#import "MBMainViewController_iPhone.h"
#import "MBMainViewController_iPad.h"

@implementation MBAppDelegate

- (void)dealloc {
    [_window release];
    [_mainViewController_iPhone release];
    [_mainViewController_iPad release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.mainViewController_iPhone = [[[MBMainViewController_iPhone alloc] initWithNibName:@"MBMainView_iPhone" bundle:nil] autorelease];
        self.window.rootViewController = self.mainViewController_iPhone;
    } else {
        self.mainViewController_iPad = [[[MBMainViewController_iPad alloc] initWithNibName:@"MBMainView_iPad" bundle:nil] autorelease];
        self.window.rootViewController = self.mainViewController_iPad;
    }
    [self.window makeKeyAndVisible];
    [MBGameCenterSessionManager sharedManager];
    [[MBBluetoothSessionManager sharedManager] startAdertising];
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[MBBluetoothSessionManager sharedManager] stopAdvertising];
    [[MBBluetoothSessionManager sharedManager] disconnect];
}

@end
