//
//  MBViewController.h
//  Tic Tac Toe
//
//  Created by Beatrix Brunner on 29.03.13.
//  Copyright (c) 2013 Maximilian Brunner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "MBMainScrollView_iPhone.h"
#import "MBGameCenterViewController_iPhone.h"
#import "MBSingleplayerViewController_iPhone.h"
#import "MBMultiplayerViewController_iPhone.h"
#import "MBBluetoothMultiplayerViewController_iPhone.h"

@interface MBMainViewController_iPhone : UIViewController <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, ADBannerViewDelegate> {
    IBOutlet MBMainScrollView_iPhone *mainScrollView;
    IBOutlet UITableView *gameCenterSessionTableView;
    IBOutlet ADBannerView *mainAdView;

    MBGameCenterViewController_iPhone *gameCenterViewController;
    MBSingleplayerViewController_iPhone *singleplayerViewController;
    MBMultiplayerViewController_iPhone *multiplayerViewController;
    MBBluetoothMultiplayerViewController_iPhone *bluetoothMultiplayerViewController;
    NSArray *viewControllerArray;
}

@end


@interface MBMainViewController_iPhone ()

@end