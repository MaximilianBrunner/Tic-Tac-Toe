//
//  MBViewController.m
//  Tic Tac Toe
//
//  Created by Beatrix Brunner on 29.03.13.
//  Copyright (c) 2013 Maximilian Brunner. All rights reserved.
//

#import "MBMainViewController_iPhone.h"

@implementation MBMainViewController_iPhone


- (id)init {
    self = [super init];
    if (self) {
        gameCenterViewController = [[MBGameCenterViewController_iPhone alloc] initWithNibName:@"MBGameCenterView_iPhone" bundle:nil];
        singleplayerViewController = [[MBSingleplayerViewController_iPhone alloc] initWithNibName:@"MBSingleplayerView_iPhone" bundle:nil];
        multiplayerViewController = [[MBMultiplayerViewController_iPhone alloc] initWithNibName:@"MBMultiplayerView_iPhone" bundle:nil];
        bluetoothMultiplayerViewController = [[MBBluetoothMultiplayerViewController_iPhone alloc] initWithNibName:@"MBBluetoothMultiplayerView_iPhone" bundle:nil];
        viewControllerArray = [[NSArray alloc] initWithObjects:gameCenterViewController, singleplayerViewController, multiplayerViewController, bluetoothMultiplayerViewController, nil];
        [[MBBluetoothSessionManager sharedManager] setDelegate:self];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        gameCenterViewController = [[MBGameCenterViewController_iPhone alloc] initWithNibName:@"MBGameCenterView_iPhone" bundle:nil];
        singleplayerViewController = [[MBSingleplayerViewController_iPhone alloc] initWithNibName:@"MBSingleplayerView_iPhone" bundle:nil];
        multiplayerViewController = [[MBMultiplayerViewController_iPhone alloc] initWithNibName:@"MBMultiplayerView_iPhone" bundle:nil];
        bluetoothMultiplayerViewController = [[MBBluetoothMultiplayerViewController_iPhone alloc] initWithNibName:@"MBBluetoothMultiplayerView_iPhone" bundle:nil];
        viewControllerArray = [[NSArray alloc] initWithObjects:gameCenterViewController, singleplayerViewController, multiplayerViewController, bluetoothMultiplayerViewController, nil];
        [[MBBluetoothSessionManager sharedManager] setDelegate:self];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    CGSize overallContentSize;
    overallContentSize.height = mainScrollView.frame.size.height;
    overallContentSize.width = 200.0f;
    for (int page = 0; page < [viewControllerArray count]; page++) {
        overallContentSize.width = overallContentSize.width + [(UIViewController *)[viewControllerArray objectAtIndex:page] view].frame.size.width;
    }
    [mainScrollView setContentSize:overallContentSize];
    [mainScrollView setContentInset:UIEdgeInsetsMake(0.0f, 200.0f, 0.0f, -200.0f)];
    [mainScrollView setContentOffset:CGPointMake([mainScrollView frame].size.width * 2.0f, 0.0f)];
    mainScrollView.scrollsToTop = NO;
    
    for (int page = 0; page < [viewControllerArray count]; page++) {
        CGRect frame;
        frame.size.height = mainScrollView.frame.size.height;
        frame.size.width = [(UIViewController *)[viewControllerArray objectAtIndex:page] view].frame.size.width;
        frame.origin.y = 0.0f;
        frame.origin.x = mainScrollView.frame.size.width * page;
        
        [(UIViewController *)[viewControllerArray objectAtIndex:page] view].frame = frame;
        [mainScrollView addSubview:[(UIViewController *)[viewControllerArray objectAtIndex:page] view]];
    }
    
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void) {
		[mainScrollView setContentOffset:CGPointMake([mainScrollView frame].size.width * 2.0f - 60.0f, 0.0) animated:YES];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void) {
		[mainScrollView setContentOffset:CGPointMake([mainScrollView frame].size.width * 2.0f + 40.0f, 0.0) animated:YES];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.9 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void) {
		[mainScrollView setContentOffset:CGPointMake([mainScrollView frame].size.width * 2.0f - 10.0f, 0.0) animated:YES];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void) {
		[mainScrollView setContentOffset:CGPointMake([mainScrollView frame].size.width * 2.0f, 0.0) animated:YES];
    });
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x < 0.0f) {
        [scrollView setBounces:NO];
    }
    else {
        [scrollView setBounces:YES];
    }
    
    /*
    if ([scrollView contentOffset].x == 640.0f && lastPageNumber != 3) {
        MBMessage_iPhone *message = [[MBMessage_iPhone alloc] initWithTitle:NSLocalizedString(@"Multiplayer", @"Multiplayer") andTextColor:[MBMessage_iPhone defaultTextColor]];
		[message show];
		[message release];
        lastPageNumber = 3;
    }
     */
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x == -200.0f) {
        CGSize contentSize = scrollView.contentSize;
        contentSize.width = [(UIViewController *)[viewControllerArray objectAtIndex:0] view].frame.size.width + 200.0f;
        [scrollView setContentSize:contentSize];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView.contentSize.width == [(UIViewController *)[viewControllerArray objectAtIndex:0] view].frame.size.width + 200.0f) {
        CGSize contentSize = scrollView.contentSize;
        contentSize.width = 200.0f;
        for (int page = 0; page < [viewControllerArray count]; page++) {
            contentSize.width = contentSize.width + [(UIViewController *)[viewControllerArray objectAtIndex:page] view].frame.size.width;
        }
        [scrollView setContentSize:contentSize];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([scrollView contentOffset].x == -200.0f) {
        
    } else if ([scrollView contentOffset].x == 0.0f && lastPageNumber != 1) {
        MBMessage_iPhone *message = [[MBMessage_iPhone alloc] initWithTitle:NSLocalizedString(@"Game Center", @"GameCenter") andTextColor:[MBMessage_iPhone defaultTextColor]];
		[message show];
		[message release];
        lastPageNumber = 1;
    } else if ([scrollView contentOffset].x == 320.0f && lastPageNumber != 2) {
        MBMessage_iPhone *message = [[MBMessage_iPhone alloc] initWithTitle:NSLocalizedString(@"Singleplayer", @"Singleplayer") andTextColor:[MBMessage_iPhone defaultTextColor]];
		[message show];
		[message release];
        lastPageNumber = 2;
        
    } else if ([scrollView contentOffset].x == 640.0f && lastPageNumber != 3) {
        MBMessage_iPhone *message = [[MBMessage_iPhone alloc] initWithTitle:NSLocalizedString(@"Multiplayer", @"Multiplayer") andTextColor:[MBMessage_iPhone defaultTextColor]];
		[message show];
		[message release];
        lastPageNumber = 3;
         
    } else if ([scrollView contentOffset].x == 960.0f) {
        [[MBBluetoothSessionManager sharedManager] showPeerPicker];
        lastPageNumber = 4;
    }
}

#pragma mark - MBGameCenterAddSessionTableViewCellDelegate

- (void)addGameCenterSession:(MBGameCenterAddSessionTableViewCell_iPhone *)sender {
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [mainScrollView scrollRectToVisible:[[gameCenterViewController view] frame] animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 24.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MBGameCenterSessionTableViewSectionHeaderView_iPhone *sectionHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"MBGameCenterSessionTableViewSectionHeaderView_iPhone" owner:self options:nil] objectAtIndex:0];
    switch (section) {
        case 0:
            [sectionHeaderView setSectionName:@"Online"];
            break;
        case 1:
            [sectionHeaderView setSectionName:@"Your Turn"];
            break;
        case 2:
            [sectionHeaderView setSectionName:@"Pending"];
            break;
    }
    return sectionHeaderView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MBGameCenterSessionTableViewCell_iPhone *cell = (MBGameCenterSessionTableViewCell_iPhone *)[tableView dequeueReusableCellWithIdentifier:@"gameCenterSessionCell"];
    if (!cell) {
        
        cell = (MBGameCenterSessionTableViewCell_iPhone *)[[[NSBundle mainBundle] loadNibNamed:@"MBGameCenterSessionTableViewCell_iPhone" owner:self options:nil] objectAtIndex:0];
    }
    [cell setPeerName:[NSString stringWithFormat:@"S:%ld R:%ld", (long)indexPath.section + 1, (long)indexPath.row + 1]];
    return cell;
}

#pragma mark - MBBluetoothSessionManagerDelegate

- (void)bluetoothSessionManager:(MBBluetoothSessionManager *)manager didChangeConnectionState:(MBBluetoothConnectionState)connectionState {
    
}

- (void)bluetoothSessionManagerDidCancelPeerPicker:(MBBluetoothSessionManager *)manager {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void) {
        CGRect multiplayerRect = [[multiplayerViewController view] frame];
        CGRect animationRect = CGRectMake(multiplayerRect.origin.x + 200.0f, multiplayerRect.origin.y, multiplayerRect.size.width, multiplayerRect.size.height);
        [mainScrollView scrollRectToVisible:animationRect animated:YES];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.70 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void) {
        MBMessage_iPhone *message = [[MBMessage_iPhone alloc] initWithTitle:NSLocalizedString(@"Multiplayer", @"Multiplayer") andTextColor:[MBMessage_iPhone defaultTextColor]];
		[message show];
		[message release];
        lastPageNumber = 3;
    });
    
}

#pragma mark - ADBannerViewDelegate

- (void)bannerViewWillLoadAd:(ADBannerView *)banner {
    
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner {
    
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [gameCenterViewController release];
    [singleplayerViewController release];
    [multiplayerViewController release];
    [bluetoothMultiplayerViewController release];
    [viewControllerArray release];
    [super dealloc];
}

@end
