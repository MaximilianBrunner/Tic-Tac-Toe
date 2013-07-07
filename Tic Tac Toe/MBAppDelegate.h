//
//  MBAppDelegate.h
//  Tic Tac Toe
//
//  Created by Beatrix Brunner on 29.03.13.
//  Copyright (c) 2013 Maximilian Brunner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBGameCenterSessionManager.h"
#import "MBBluetoothSessionManager.h"

@class MBMainViewController_iPhone;
@class MBMainViewController_iPad;


@interface MBAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) MBMainViewController_iPhone *mainViewController_iPhone;
@property (strong, nonatomic) MBMainViewController_iPad *mainViewController_iPad;

@end
