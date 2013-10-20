//
//  MBBluetoothMultiplayerViewController_iPhone.m
//  Tic Tac Toe
//
//  Created by Beatrix Brunner on 30.03.13.
//  Copyright (c) 2013 Maximilian Brunner. All rights reserved.
//

#import "MBBluetoothMultiplayerViewController_iPhone.h"

@implementation MBBluetoothMultiplayerViewController_iPhone

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        AudioServicesCreateSystemSoundID(CFBundleCopyResourceURL(CFBundleGetMainBundle(), CFSTR("playX"), CFSTR("caf"), NULL), &SoundX);
        AudioServicesCreateSystemSoundID(CFBundleCopyResourceURL(CFBundleGetMainBundle(), CFSTR("playO"), CFSTR("caf"), NULL), &SoundO);
        setX = YES;
        letXbegin = setX;
    }
    return self;
}

#pragma mark -
#pragma mark loading the view

- (void)loadView {
    [super loadView];
    button[1] = button1;
    button[2] = button2;
    button[3] = button3;
    button[4] = button4;
    button[5] = button5;
    button[6] = button6;
    button[7] = button7;
    button[8] = button8;
    button[9] = button9;
    
	for (int i = 1; i < 10; i++) {
		[button[i] setTitle:@"" forState:UIControlStateNormal];
		[button[i] setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button[i] setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [button[i] setExclusiveTouch:YES];
	}
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

#pragma mark -

- (IBAction)buttonClick:(UIButton *)sender {
    if (setX) {
        AudioServicesPlaySystemSound(SoundX);
        [sender setTitle:@"X" forState:UIControlStateNormal];
        [UIView animateWithDuration:0.2 animations:^{
            [labelX setAlpha:0.3f];
            [labelO setAlpha:1.0f];
            [countLabelX setAlpha:0.5f];
            [countLabelO setAlpha:1.0f];
        }];
    } else {
        AudioServicesPlaySystemSound(SoundO);
        [sender setTitle:@"O" forState:UIControlStateNormal];
        [UIView animateWithDuration:0.2 animations:^{
            [labelX setAlpha:1.0f];
            [labelO setAlpha:0.3f];
            [countLabelX setAlpha:1.0f];
            [countLabelO setAlpha:0.5f];
        }];
    }
    setX = !setX;
    [sender setUserInteractionEnabled:NO];
    [self checkState];
}

- (void)checkState {
    for (int i = 0; i < 4; i++) {
        if ([[button[[self virtualButtonNumberForRealButton:1 withLayerIndex:i]] currentTitle] isEqualToString:[button[[self virtualButtonNumberForRealButton:2 withLayerIndex:i]] currentTitle]] &&
            [[button[[self virtualButtonNumberForRealButton:1 withLayerIndex:i]] currentTitle] isEqualToString:[button[[self virtualButtonNumberForRealButton:3 withLayerIndex:i]] currentTitle]] &&
            ![[button[[self virtualButtonNumberForRealButton:1 withLayerIndex:i]] currentTitle] isEqualToString:@""]) {
            if ([[button[[self virtualButtonNumberForRealButton:1 withLayerIndex:i]] currentTitle] isEqualToString:@"X"]) {
                [self performSelector:@selector(xWon) withObject:nil afterDelay:0.1];
            } else {
                [self performSelector:@selector(oWon) withObject:nil afterDelay:0.1];
            }
        }
    }
    for (int i = 0; i < 2; i++) {
        if ([[button[[self virtualButtonNumberForRealButton:2 withLayerIndex:i]] currentTitle] isEqualToString:[button[[self virtualButtonNumberForRealButton:5 withLayerIndex:i]] currentTitle]] &&
            [[button[[self virtualButtonNumberForRealButton:2 withLayerIndex:i]] currentTitle] isEqualToString:[button[[self virtualButtonNumberForRealButton:8 withLayerIndex:i]] currentTitle]] &&
            ![[button[[self virtualButtonNumberForRealButton:2 withLayerIndex:i]] currentTitle] isEqualToString:@""]) {
            if ([[button[[self virtualButtonNumberForRealButton:2 withLayerIndex:i]] currentTitle] isEqualToString:@"X"]) {
                [self performSelector:@selector(xWon) withObject:nil afterDelay:0.1];
            } else {
                [self performSelector:@selector(oWon) withObject:nil afterDelay:0.1];
            }
        }
    }
    for (int i = 0; i < 2; i++) {
        if ([[button[[self virtualButtonNumberForRealButton:1 withLayerIndex:i]] currentTitle] isEqualToString:[button[[self virtualButtonNumberForRealButton:5 withLayerIndex:i]] currentTitle]] &&
            [[button[[self virtualButtonNumberForRealButton:1 withLayerIndex:i]] currentTitle] isEqualToString:[button[[self virtualButtonNumberForRealButton:9 withLayerIndex:i]] currentTitle]] &&
            ![[button[[self virtualButtonNumberForRealButton:1 withLayerIndex:i]] currentTitle] isEqualToString:@""]) {
            if ([[button[[self virtualButtonNumberForRealButton:1 withLayerIndex:i]] currentTitle] isEqualToString:@"X"]) {
                [self performSelector:@selector(xWon) withObject:nil afterDelay:0.1];
            } else {
                [self performSelector:@selector(oWon) withObject:nil afterDelay:0.1];
            }
        }
    }
    if (![[button[1] currentTitle] isEqualToString:@""] && ![[button[2] currentTitle] isEqualToString:@""] && ![[button[3] currentTitle] isEqualToString:@""] &&
        ![[button[4] currentTitle] isEqualToString:@""] && ![[button[5] currentTitle] isEqualToString:@""] && ![[button[6] currentTitle] isEqualToString:@""] &&
        ![[button[7] currentTitle] isEqualToString:@""] && ![[button[8] currentTitle] isEqualToString:@""] && ![[button[9] currentTitle] isEqualToString:@""]) {
        [self performSelector:@selector(draw) withObject:nil afterDelay:0.1];
	}
}

#pragma mark -
#pragma mark layer rotation

- (int)virtualButtonNumberForRealButton:(int)buttonNumber withLayerIndex:(int)index {
    switch (index) {
        case 0: //1.Layer (=0°):
            return buttonNumber;
            break;
        case 1: //2.Layer (=90°):
            switch (buttonNumber) {
                case 1:
                    return 7;
                    break;
                case 2:
                    return 4;
                    break;
                case 3:
                    return 1;
                    break;
                case 4:
                    return 8;
                    break;
                case 5:
                    return 5;
                    break;
                case 6:
                    return 2;
                    break;
                case 7:
                    return 9;
                    break;
                case 8:
                    return 6;
                    break;
                case 9:
                    return 3;
                    break;
            }
            break;
        case 2: //3.Layer (=180°):
            return (10 - buttonNumber);
            break;
        case 3: //4.Layer (=270°)
            switch (buttonNumber) {
                case 1:
                    return 3;
                    break;
                case 2:
                    return 6;
                    break;
                case 3:
                    return 9;
                    break;
                case 4:
                    return 2;
                    break;
                case 5:
                    return 5;
                    break;
                case 6:
                    return 8;
                    break;
                case 7:
                    return 1;
                    break;
                case 8:
                    return 4;
                    break;
                case 9:
                    return 7;
                    break;
            }
            break;
    }
    return 0;
}

#pragma mark -
#pragma mark delayed selectors

- (void)xWon {
    UIAlertView *xWonAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Congratulation", @"Congratulation")
                                                        message:[NSString stringWithFormat:NSLocalizedString(@"won", @"%@ won the game"), @"X"]
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"New Game", @"New Game")
                                              otherButtonTitles:nil];
    [xWonAlert setDelegate:self];
    [xWonAlert show];
    [xWonAlert release];
    [self increaseX];
    
}

- (void)oWon {
    UIAlertView *oWonAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Congratulation", @"Congratulation")
                                                        message:[NSString stringWithFormat:NSLocalizedString(@"won", @"%@ won the game"), @"O"]
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"New Game", @"New Game")
                                              otherButtonTitles:nil];
    [oWonAlert setDelegate:self];
    [oWonAlert show];
    [oWonAlert release];
    [self increaseO];
}

- (void)draw {
    UIAlertView *drawAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Draw", @"Draw")
                                                        message:@"XO"
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"New Game", @"New Game")
                                              otherButtonTitles:nil];
    [drawAlert setDelegate:self];
    [drawAlert show];
    [drawAlert release];
}

#pragma mark -
#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    [self clear];
}

#pragma mark -

- (void)clear {
    for (int i = 1; i < 10; i++) {
		[button[i] setTitle:@"" forState:UIControlStateNormal];
		[button[i] setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button[i] setUserInteractionEnabled:YES];
	}
	if (letXbegin) {
        [UIView animateWithDuration:0.2 animations:^{
            [labelX setAlpha:0.3f];
            [labelO setAlpha:1.0f];
            [countLabelX setAlpha:0.5f];
            [countLabelO setAlpha:1.0f];
        }];
	}
	else {
        [UIView animateWithDuration:0.2 animations:^{
            [labelX setAlpha:1.0f];
            [labelO setAlpha:0.3f];
            [countLabelX setAlpha:1.0f];
            [countLabelO setAlpha:0.5f];
        }];
	}
    letXbegin = !letXbegin;
	setX = letXbegin;
}

- (void)increaseX {
	[countLabelX setText:[NSString stringWithFormat:@"%d", ([[countLabelX text] intValue] + 1)]];
}

- (void)increaseO {
	[countLabelO setText:[NSString stringWithFormat:@"%d", ([[countLabelO text] intValue] + 1)]];
}

#pragma mark -
#pragma mark dealloc

- (void)dealloc {
    AudioServicesDisposeSystemSoundID(SoundX);
    AudioServicesDisposeSystemSoundID(SoundO);
    [super dealloc];
}

#pragma mark - MBBluetoothDataReceiveHandlerDelegate

- (void)bluetoothSessionManager:(MBBluetoothSessionManager *)manager didReceiveData:(NSData *)data ofType:(MBBluetoothPacketType)type {
    
}

@end
