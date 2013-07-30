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
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];
        [self.view setFrame: [[UIScreen mainScreen] bounds]];
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
    [mainScrollView setContentOffset:CGPointMake(mainScrollView.frame.size.width * 2.0f, 0.0f)];
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
}

# pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x < 0.0f) {
        [scrollView setBounces:NO];
    }
    else {
        [scrollView setBounces:YES];
    }
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

# pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [mainScrollView scrollRectToVisible:[[gameCenterViewController view] frame] animated:YES];
}

# pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Section";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    [[cell textLabel] setText:[NSString stringWithFormat:@"S:%ld R:%ld", (long)indexPath.section + 1, (long)indexPath.row + 1]];
    return cell;
}

# pragma mark - ADBannerViewDelegate

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
