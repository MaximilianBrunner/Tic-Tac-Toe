//
//  MBSingleplayerViewController_iPhone.m
//  Tic Tac Toe
//
//  Created by Beatrix Brunner on 29.03.13.
//  Copyright (c) 2013 Maximilian Brunner. All rights reserved.
//

#import "MBSingleplayerViewController_iPhone.h"

@implementation MBSingleplayerViewController_iPhone

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        AudioServicesCreateSystemSoundID(CFBundleCopyResourceURL(CFBundleGetMainBundle(), CFSTR("playX"), CFSTR("caf"), NULL), &SoundX);
        AudioServicesCreateSystemSoundID(CFBundleCopyResourceURL(CFBundleGetMainBundle(), CFSTR("playO"), CFSTR("caf"), NULL), &SoundO);
        letXbegin = YES;
        setX = letXbegin;
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
    if ([[sender currentTitle] isEqualToString:@""]) {
        for (int i = 1; i < 10; i++) { [button[i] setUserInteractionEnabled:NO]; }
        if (setX) {
            AudioServicesPlaySystemSound(SoundX);
            [sender setTitle:@"X" forState:UIControlStateNormal];
            if (![self isGameFinished]) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int16_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void){
                    for (int i = 1; i < 10; i++) { [button[i] setUserInteractionEnabled:YES]; }
                    AudioServicesPlaySystemSound(SoundO);
                    [button[[self buttonNumberForValue:@"O" withDifficulty:difficultyState]] setTitle:@"O" forState:UIControlStateNormal];
                    [self isGameFinished];
                    [UIView animateWithDuration:0.2 animations:^{
                        [labelX setAlpha:1.0f];
                        [labelO setAlpha:0.3f];
                        [countLabelX setAlpha:1.0f];
                        [countLabelO setAlpha:0.5f];
                    }];
                    setX = YES;
                });
            }
            [UIView animateWithDuration:0.2 animations:^{
                [labelX setAlpha:0.3f];
                [labelO setAlpha:1.0f];
                [countLabelX setAlpha:0.5f];
                [countLabelO setAlpha:1.0f];
            }];
        } else {
            AudioServicesPlaySystemSound(SoundO);
            [sender setTitle:@"O" forState:UIControlStateNormal];
            if (![self isGameFinished]) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int16_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void){
                    for (int i = 1; i < 10; i++) { [button[i] setUserInteractionEnabled:YES]; }
                    AudioServicesPlaySystemSound(SoundX);
                    [button[[self buttonNumberForValue:@"X" withDifficulty:difficultyState]] setTitle:@"X" forState:UIControlStateNormal];
                    [self isGameFinished];
                    [UIView animateWithDuration:0.2 animations:^{
                        [labelX setAlpha:0.3f];
                        [labelO setAlpha:1.0f];
                        [countLabelX setAlpha:0.5f];
                        [countLabelO setAlpha:1.0f];
                    }];
                    setX = NO;
                });
            }
            [UIView animateWithDuration:0.2 animations:^{
                [labelX setAlpha:1.0f];
                [labelO setAlpha:0.3f];
                [countLabelX setAlpha:1.0f];
                [countLabelO setAlpha:0.5f];
            }];
        }
        setX = !setX;
    }
}

#pragma mark -

- (BOOL)isGameFinished {
    if ([[button[1] currentTitle] isEqualToString:[button[2] currentTitle]] && [[button[1] currentTitle] isEqualToString:[button[3] currentTitle]] && ![[button[1] currentTitle] isEqualToString:@""]) {
		[button[1] setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
		[button[2] setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
		[button[3] setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
		if ([[button[1] currentTitle] isEqualToString:@"X"]) {
            [self performSelector:@selector(xWon) withObject:nil afterDelay:0.1];
		} else {
            [self performSelector:@selector(oWon) withObject:nil afterDelay:0.1];
		}
        return YES;
	} else if ([[button[4] currentTitle] isEqualToString:[button[5] currentTitle]] && [[button[4] currentTitle] isEqualToString:[button[6] currentTitle]] && ![[button[4] currentTitle] isEqualToString:@""]) {
		[button[4] setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
		[button[5] setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
		[button[6] setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
		if ([[button[4] currentTitle] isEqualToString:@"X"]) {
            [self performSelector:@selector(xWon) withObject:nil afterDelay:0.1];
		} else {
            [self performSelector:@selector(oWon) withObject:nil afterDelay:0.1];
		}
        return YES;
	} else if ([[button[7] currentTitle] isEqualToString:[button[8] currentTitle]] && [[button[7] currentTitle] isEqualToString:[button[9] currentTitle]] && ![[button[7] currentTitle] isEqualToString:@""]) {
		[button[7] setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
		[button[8] setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
		[button[9] setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
		if ([[button[7] currentTitle] isEqualToString:@"X"]) {
            [self performSelector:@selector(xWon) withObject:nil afterDelay:0.1];
		} else {
            [self performSelector:@selector(oWon) withObject:nil afterDelay:0.1];
		}
        return YES;
	} else if ([[button[1] currentTitle] isEqualToString:[button[4] currentTitle]] && [[button[1] currentTitle] isEqualToString:[button[7] currentTitle]] && ![[button[1] currentTitle] isEqualToString:@""]) {
		[button[1] setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
		[button[4] setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
		[button[7] setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
		if ([[button[1] currentTitle] isEqualToString:@"X"]) {
            [self performSelector:@selector(xWon) withObject:nil afterDelay:0.1];
		} else {
            [self performSelector:@selector(oWon) withObject:nil afterDelay:0.1];
		}
        return YES;
	} else if ([[button[2] currentTitle] isEqualToString:[button[5] currentTitle]] && [[button[2] currentTitle] isEqualToString:[button[8] currentTitle]] && ![[button[2] currentTitle] isEqualToString:@""]) {
		[button[2] setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
		[button[5] setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
		[button[8] setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
		if ([[button[2] currentTitle] isEqualToString:@"X"]) {
            [self performSelector:@selector(xWon) withObject:nil afterDelay:0.1];
		} else {
            [self performSelector:@selector(oWon) withObject:nil afterDelay:0.1];
		}
        return YES;
	} else if ([[button[3] currentTitle] isEqualToString:[button[6] currentTitle]] && [[button[3] currentTitle] isEqualToString:[button[9] currentTitle]] && ![[button[3] currentTitle] isEqualToString:@""]) {
		[button[3] setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
		[button[6] setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
		[button[9] setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
		if ([[button[3] currentTitle] isEqualToString:@"X"]) {
            [self performSelector:@selector(xWon) withObject:nil afterDelay:0.1];
		} else {
            [self performSelector:@selector(oWon) withObject:nil afterDelay:0.1];
		}
        return YES;
	} else if ([[button[1] currentTitle] isEqualToString:[button[5] currentTitle]] && [[button[1] currentTitle] isEqualToString:[button[9] currentTitle]] && ![[button[1] currentTitle] isEqualToString:@""]) {
		[button[1] setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
		[button[5] setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
		[button[9] setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
		if ([[button[1] currentTitle] isEqualToString:@"X"]) {
            [self performSelector:@selector(xWon) withObject:nil afterDelay:0.1];
		} else {
            [self performSelector:@selector(oWon) withObject:nil afterDelay:0.1];
		}
        return YES;
	} else if ([[button[3] currentTitle] isEqualToString:[button[5] currentTitle]] && [[button[3] currentTitle] isEqualToString:[button[7] currentTitle]] && ![[button[3] currentTitle] isEqualToString:@""]) {
		[button[3] setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
		[button[5] setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
		[button[7] setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
		if ([[button[3] currentTitle] isEqualToString:@"X"]) {
            [self performSelector:@selector(xWon) withObject:nil afterDelay:0.1];
		} else {
            [self performSelector:@selector(oWon) withObject:nil afterDelay:0.1];
		}
        return YES;
	} else if (![[button[1] currentTitle] isEqualToString:@""] && ![[button[2] currentTitle] isEqualToString:@""] && ![[button[3] currentTitle] isEqualToString:@""] &&
               ![[button[4] currentTitle] isEqualToString:@""] && ![[button[5] currentTitle] isEqualToString:@""] && ![[button[6] currentTitle] isEqualToString:@""] &&
               ![[button[7] currentTitle] isEqualToString:@""] && ![[button[8] currentTitle] isEqualToString:@""] && ![[button[9] currentTitle] isEqualToString:@""]) {
        [self performSelector:@selector(draw) withObject:nil afterDelay:0.1];
        return YES;
	}
    return NO;
}

- (int)buttonNumberForValue:(NSString *)botValue withDifficulty:(DifficultyState)difficulty {
    NSString *humanValue;
	if ([botValue isEqualToString:@"X"]) {
		humanValue = @"O";
	} else {
		humanValue = @"X";
	}
    
    //> versucht sein Spiel zu beenden:
	if ([[button[5/* Button 5 muss nich rotiert werden (5 bleibt bei jedem Layer an gleicher Position) */] currentTitle] isEqualToString:@""]) {
        for (int i = 0; i < 2/* Schleife wird nur 2 mal durchlaufen da eine Rotation des Layers um 90° ausreicht um 2-5-8 bzw. 1-5-9 abzufragen */; i++) {
            if ([button[[self realButtonNumberForVirtualButton:1 withLayerIndex:i]] currentTitle] == [button[[self realButtonNumberForVirtualButton:9 withLayerIndex:i]] currentTitle] && [button[[self realButtonNumberForVirtualButton:1 withLayerIndex:i]] currentTitle] == botValue) {
                return [self realButtonNumberForVirtualButton:5 withLayerIndex:i];
            } else if ([button[[self realButtonNumberForVirtualButton:2 withLayerIndex:i]] currentTitle] == [button[[self realButtonNumberForVirtualButton:8 withLayerIndex:i]] currentTitle] && [button[[self realButtonNumberForVirtualButton:2 withLayerIndex:i]] currentTitle] == botValue) {
                return [self realButtonNumberForVirtualButton:5 withLayerIndex:i];
            }
        }
    }
    for (int i = 0; i < 4; i++) {
        if ([[button[[self realButtonNumberForVirtualButton:1 withLayerIndex:i]] currentTitle] isEqualToString:@""]) {
            if ([button[[self realButtonNumberForVirtualButton:2 withLayerIndex:i]] currentTitle] == [button[[self realButtonNumberForVirtualButton:3 withLayerIndex:i]] currentTitle] && [button[[self realButtonNumberForVirtualButton:2 withLayerIndex:i]] currentTitle] == botValue) {
                return [self realButtonNumberForVirtualButton:1 withLayerIndex:i];
            } else if ([button[[self realButtonNumberForVirtualButton:5 withLayerIndex:i]] currentTitle] == [button[[self realButtonNumberForVirtualButton:9 withLayerIndex:i]] currentTitle] && [button[[self realButtonNumberForVirtualButton:5 withLayerIndex:i]] currentTitle] == botValue) {
                return [self realButtonNumberForVirtualButton:1 withLayerIndex:i];
            } else if ([button[[self realButtonNumberForVirtualButton:4 withLayerIndex:i]] currentTitle] == [button[[self realButtonNumberForVirtualButton:7 withLayerIndex:i]] currentTitle] && [button[[self realButtonNumberForVirtualButton:4 withLayerIndex:i]] currentTitle] == botValue) {
                return [self realButtonNumberForVirtualButton:1 withLayerIndex:i];
            }
        }
        if ([[button[[self realButtonNumberForVirtualButton:2 withLayerIndex:i]] currentTitle] isEqualToString:@""]) {
            if ([button[[self realButtonNumberForVirtualButton:1 withLayerIndex:i]] currentTitle] == [button[[self realButtonNumberForVirtualButton:3 withLayerIndex:i]] currentTitle] && [button[[self realButtonNumberForVirtualButton:1 withLayerIndex:i]] currentTitle] == botValue) {
                return [self realButtonNumberForVirtualButton:2 withLayerIndex:i];
            } else if ([button[[self realButtonNumberForVirtualButton:5 withLayerIndex:i]] currentTitle] == [button[[self realButtonNumberForVirtualButton:8 withLayerIndex:i]] currentTitle] && [button[[self realButtonNumberForVirtualButton:5 withLayerIndex:i]] currentTitle] == botValue) {
                return [self realButtonNumberForVirtualButton:2 withLayerIndex:i];
            }
        }
    }
	
    //> versucht den Gegner zu stoppen:
	if ([[button[5/* Button 5 muss nich rotiert werden (5 bleibt bei jedem Layer an gleicher Position) */] currentTitle] isEqualToString:@""]) {
        for (int i = 0; i < 2/* Schleife wird nur 2 mal durchlaufen da eine Rotation des Layers um 90° ausreicht um 2-5-8 bzw. 1-5-9 abzufragen */; i++) {
            if ([button[[self realButtonNumberForVirtualButton:1 withLayerIndex:i]] currentTitle] == [button[[self realButtonNumberForVirtualButton:9 withLayerIndex:i]] currentTitle] && [button[[self realButtonNumberForVirtualButton:1 withLayerIndex:i]] currentTitle] == humanValue) {
                return [self realButtonNumberForVirtualButton:5 withLayerIndex:i];
            } else if ([button[[self realButtonNumberForVirtualButton:2 withLayerIndex:i]] currentTitle] == [button[[self realButtonNumberForVirtualButton:8 withLayerIndex:i]] currentTitle] && [button[[self realButtonNumberForVirtualButton:2 withLayerIndex:i]] currentTitle] == humanValue) {
                return [self realButtonNumberForVirtualButton:5 withLayerIndex:i];
            }
        }
	}
    for (int i = 0; i < 4; i++) {
        if ([[button[[self realButtonNumberForVirtualButton:2 withLayerIndex:i]] currentTitle] isEqualToString:@""]) {
            if ([button[[self realButtonNumberForVirtualButton:1 withLayerIndex:i]] currentTitle] == [button[[self realButtonNumberForVirtualButton:3 withLayerIndex:i]] currentTitle] && [button[[self realButtonNumberForVirtualButton:1 withLayerIndex:i]] currentTitle] == humanValue) {
                return [self realButtonNumberForVirtualButton:2 withLayerIndex:i];
            } else if ([button[[self realButtonNumberForVirtualButton:5 withLayerIndex:i]] currentTitle] == [button[[self realButtonNumberForVirtualButton:8 withLayerIndex:i]] currentTitle] && [button[[self realButtonNumberForVirtualButton:5 withLayerIndex:i]] currentTitle] == humanValue) {
                return [self realButtonNumberForVirtualButton:2 withLayerIndex:i];
            }
        }
        if ([[button[[self realButtonNumberForVirtualButton:1 withLayerIndex:i]] currentTitle] isEqualToString:@""]) {
            if ([button[[self realButtonNumberForVirtualButton:2 withLayerIndex:i]] currentTitle] == [button[[self realButtonNumberForVirtualButton:3 withLayerIndex:i]] currentTitle] && [button[[self realButtonNumberForVirtualButton:2 withLayerIndex:i]] currentTitle] == humanValue) {
                return [self realButtonNumberForVirtualButton:1 withLayerIndex:i];
            } else if ([button[[self realButtonNumberForVirtualButton:5 withLayerIndex:i]] currentTitle] == [button[[self realButtonNumberForVirtualButton:9 withLayerIndex:i]] currentTitle] && [button[[self realButtonNumberForVirtualButton:5 withLayerIndex:i]] currentTitle] == humanValue) {
                return [self realButtonNumberForVirtualButton:1 withLayerIndex:i];
            } else if ([button[[self realButtonNumberForVirtualButton:4 withLayerIndex:i]] currentTitle] == [button[[self realButtonNumberForVirtualButton:7 withLayerIndex:i]] currentTitle] && [button[[self realButtonNumberForVirtualButton:4 withLayerIndex:i]] currentTitle] == humanValue) {
                return [self realButtonNumberForVirtualButton:1 withLayerIndex:i];
            }
        }
    }
    
    //> trying to perform a trick (performing on Normal- and ExpertState):
    if (difficulty == DifficultyStateNormal || difficulty == DifficultyStateExpert) {
        BOOL isBotsFirstTurn = YES;
        for (int i = 1; i < 10; i++) {
            isBotsFirstTurn = isBotsFirstTurn && ![[button[i] currentTitle] isEqualToString:botValue];
        }
        if (isBotsFirstTurn) {
            //beim ersten Spielzug des Bots nur auf die ungeraden Buttons 1/3/5/7/9 setzen:
            int loop = 0;
            for (;;) {
                loop++;
                srandom(time(NULL) + loop);
                int i = (random() % 5) + 1; // =Zufallszahl von 1 bis 5
                i = 2 * i - 1;              // =ungerade Zufallszahl: 1/3/5/7/9
                if ([[button[i] currentTitle] isEqualToString:@""]) {
                    return i;
                }
            }
        }
        //rotationssymetrische Möglichkeiten außerhalb des loops:
        else if ([[button[2] currentTitle] stringByAppendingString:[button[8] currentTitle]] == botValue && [[button[4] currentTitle] stringByAppendingString:[button[6] currentTitle]] == botValue && [[button[5] currentTitle] isEqualToString:@""]) {
            return 5;
        } else if ([[button[1] currentTitle] stringByAppendingString:[button[9] currentTitle]] == botValue && [[button[3] currentTitle] stringByAppendingString:[button[7] currentTitle]] == botValue && [[button[5] currentTitle] isEqualToString:@""]) {
            return 5;
        }
        for (int i = 0; i < 4; i++) {
            if ([[button[[self realButtonNumberForVirtualButton:2 withLayerIndex:i]] currentTitle] stringByAppendingString:[button[[self realButtonNumberForVirtualButton:3 withLayerIndex:i]] currentTitle]] == botValue &&
                [[button[[self realButtonNumberForVirtualButton:4 withLayerIndex:i]] currentTitle] stringByAppendingString:[button[[self realButtonNumberForVirtualButton:7 withLayerIndex:i]] currentTitle]] == botValue &&
                [[button[[self realButtonNumberForVirtualButton:1 withLayerIndex:i]] currentTitle] isEqualToString:@""]) {
                return [self realButtonNumberForVirtualButton:1 withLayerIndex:i];
            } else if ([[button[[self realButtonNumberForVirtualButton:4 withLayerIndex:i]] currentTitle] stringByAppendingString:[button[[self realButtonNumberForVirtualButton:7 withLayerIndex:i]] currentTitle]] == botValue &&
                       [[button[[self realButtonNumberForVirtualButton:5 withLayerIndex:i]] currentTitle] stringByAppendingString:[button[[self realButtonNumberForVirtualButton:9 withLayerIndex:i]] currentTitle]] == botValue &&
                       [[button[[self realButtonNumberForVirtualButton:1 withLayerIndex:i]] currentTitle] isEqualToString:@""]) {
                return [self realButtonNumberForVirtualButton:1 withLayerIndex:i];
            } else if ([[button[[self realButtonNumberForVirtualButton:2 withLayerIndex:i]] currentTitle] stringByAppendingString:[button[[self realButtonNumberForVirtualButton:3 withLayerIndex:i]] currentTitle]] == botValue &&
                       [[button[[self realButtonNumberForVirtualButton:5 withLayerIndex:i]] currentTitle] stringByAppendingString:[button[[self realButtonNumberForVirtualButton:9 withLayerIndex:i]] currentTitle]] == botValue &&
                       [[button[[self realButtonNumberForVirtualButton:1 withLayerIndex:i]] currentTitle] isEqualToString:@""]) {
                return [self realButtonNumberForVirtualButton:1 withLayerIndex:i];
            } else if ([[button[[self realButtonNumberForVirtualButton:1 withLayerIndex:i]] currentTitle] stringByAppendingString:[button[[self realButtonNumberForVirtualButton:3 withLayerIndex:i]] currentTitle]] == botValue &&
                       [[button[[self realButtonNumberForVirtualButton:5 withLayerIndex:i]] currentTitle] stringByAppendingString:[button[[self realButtonNumberForVirtualButton:8 withLayerIndex:i]] currentTitle]] == botValue &&
                       [[button[[self realButtonNumberForVirtualButton:2 withLayerIndex:i]] currentTitle] isEqualToString:@""]) {
                return [self realButtonNumberForVirtualButton:2 withLayerIndex:i];
            }
        }
        for (int i = 0; i < 2; i++) {
            if ([[button[[self realButtonNumberForVirtualButton:2 withLayerIndex:i]] currentTitle] stringByAppendingString:[button[[self realButtonNumberForVirtualButton:8 withLayerIndex:i]] currentTitle]] == botValue &&
                [[button[[self realButtonNumberForVirtualButton:3 withLayerIndex:i]] currentTitle] stringByAppendingString:[button[[self realButtonNumberForVirtualButton:7 withLayerIndex:i]] currentTitle]] == botValue &&
                [[button[[self realButtonNumberForVirtualButton:5 withLayerIndex:i]] currentTitle] isEqualToString:@""]) {
                return [self realButtonNumberForVirtualButton:5 withLayerIndex:i];
            } else if ([[button[[self realButtonNumberForVirtualButton:2 withLayerIndex:i]] currentTitle] stringByAppendingString:[button[[self realButtonNumberForVirtualButton:8 withLayerIndex:i]] currentTitle]] == botValue &&
                       [[button[[self realButtonNumberForVirtualButton:1 withLayerIndex:i]] currentTitle] stringByAppendingString:[button[[self realButtonNumberForVirtualButton:9 withLayerIndex:i]] currentTitle]] == botValue &&
                       [[button[[self realButtonNumberForVirtualButton:5 withLayerIndex:i]] currentTitle] isEqualToString:@""]) {
                return [self realButtonNumberForVirtualButton:5 withLayerIndex:i];
            }
        }
    }
    
    //> trying to prevent my trick (ExpertState only):
    if (difficulty == DifficultyStateExpert) {        
        //Spezialfall:
        NSMutableString *vectorString = [[NSMutableString alloc] init];
        for (int i = 1; i < 10; i++) {
            if (![[button[i] currentTitle] isEqualToString:@""]) {
                [vectorString appendString:[button[i] currentTitle]];
            } else {
                [vectorString appendString:@"-"]; // "-" indicates that ther is no value set at this button
            }
        }
        if ([vectorString isEqualToString:[NSString stringWithFormat:@"--%@-%@-%@--", humanValue, botValue, humanValue]] || [vectorString isEqualToString:[NSString stringWithFormat:@"%@---%@---%@", humanValue, botValue, humanValue]]) {
            //auf geradzahligen Button setzen (2-4-6-8):
            int loop = 0;
            for (;;) {
                loop++;
                srandom(time(NULL) + loop);
                return ((random() % 4) + 1) * 2; // =Zufallszahl von 1 bis 4 wird mit 2 multiplizirt --> 2-4-6-8
            }
        }
        [vectorString release];
        
        //rotationssymetrische Möglichkeiten außerhalb des loops:
        if ([[button[2] currentTitle] stringByAppendingString:[button[8] currentTitle]] == humanValue && [[button[4] currentTitle] stringByAppendingString:[button[6] currentTitle]] == humanValue && [[button[5] currentTitle] isEqualToString:@""]) {
            return 5;
        } else if ([[button[1] currentTitle] stringByAppendingString:[button[9] currentTitle]] == humanValue && [[button[3] currentTitle] stringByAppendingString:[button[7] currentTitle]] == humanValue && [[button[5] currentTitle] isEqualToString:@""]) {
            return 5;
        }
        for (int i = 0; i < 4; i++) {
            if ([[button[[self realButtonNumberForVirtualButton:2 withLayerIndex:i]] currentTitle] stringByAppendingString:[button[[self realButtonNumberForVirtualButton:3 withLayerIndex:i]] currentTitle]] == humanValue &&
                [[button[[self realButtonNumberForVirtualButton:4 withLayerIndex:i]] currentTitle] stringByAppendingString:[button[[self realButtonNumberForVirtualButton:7 withLayerIndex:i]] currentTitle]] == humanValue &&
                [[button[[self realButtonNumberForVirtualButton:1 withLayerIndex:i]] currentTitle] isEqualToString:@""]) {
                return [self realButtonNumberForVirtualButton:1 withLayerIndex:i];
            } else if ([[button[[self realButtonNumberForVirtualButton:4 withLayerIndex:i]] currentTitle] stringByAppendingString:[button[[self realButtonNumberForVirtualButton:7 withLayerIndex:i]] currentTitle]] == humanValue &&
                       [[button[[self realButtonNumberForVirtualButton:5 withLayerIndex:i]] currentTitle] stringByAppendingString:[button[[self realButtonNumberForVirtualButton:9 withLayerIndex:i]] currentTitle]] == humanValue &&
                       [[button[[self realButtonNumberForVirtualButton:1 withLayerIndex:i]] currentTitle] isEqualToString:@""]) {
                return [self realButtonNumberForVirtualButton:1 withLayerIndex:i];
            } else if ([[button[[self realButtonNumberForVirtualButton:2 withLayerIndex:i]] currentTitle] stringByAppendingString:[button[[self realButtonNumberForVirtualButton:3 withLayerIndex:i]] currentTitle]] == humanValue &&
                       [[button[[self realButtonNumberForVirtualButton:5 withLayerIndex:i]] currentTitle] stringByAppendingString:[button[[self realButtonNumberForVirtualButton:9 withLayerIndex:i]] currentTitle]] == humanValue &&
                       [[button[[self realButtonNumberForVirtualButton:1 withLayerIndex:i]] currentTitle] isEqualToString:@""]) {
                return [self realButtonNumberForVirtualButton:1 withLayerIndex:i];
            } else if ([[button[[self realButtonNumberForVirtualButton:1 withLayerIndex:i]] currentTitle] stringByAppendingString:[button[[self realButtonNumberForVirtualButton:3 withLayerIndex:i]] currentTitle]] == humanValue &&
                       [[button[[self realButtonNumberForVirtualButton:5 withLayerIndex:i]] currentTitle] stringByAppendingString:[button[[self realButtonNumberForVirtualButton:8 withLayerIndex:i]] currentTitle]] == humanValue &&
                       [[button[[self realButtonNumberForVirtualButton:2 withLayerIndex:i]] currentTitle] isEqualToString:@""]) {
                return [self realButtonNumberForVirtualButton:2 withLayerIndex:i];
            }
        }
        for (int i = 0; i < 2; i++) {
            if ([[button[[self realButtonNumberForVirtualButton:2 withLayerIndex:i]] currentTitle] stringByAppendingString:[button[[self realButtonNumberForVirtualButton:8 withLayerIndex:i]] currentTitle]] == humanValue &&
                [[button[[self realButtonNumberForVirtualButton:3 withLayerIndex:i]] currentTitle] stringByAppendingString:[button[[self realButtonNumberForVirtualButton:7 withLayerIndex:i]] currentTitle]] == humanValue &&
                [[button[[self realButtonNumberForVirtualButton:5 withLayerIndex:i]] currentTitle] isEqualToString:@""]) {
                return [self realButtonNumberForVirtualButton:5 withLayerIndex:i];
            }
            else if ([[button[[self realButtonNumberForVirtualButton:2 withLayerIndex:i]] currentTitle] stringByAppendingString:[button[[self realButtonNumberForVirtualButton:8 withLayerIndex:i]] currentTitle]] == humanValue &&
                     [[button[[self realButtonNumberForVirtualButton:1 withLayerIndex:i]] currentTitle] stringByAppendingString:[button[[self realButtonNumberForVirtualButton:9 withLayerIndex:i]] currentTitle]] == humanValue &&
                     [[button[[self realButtonNumberForVirtualButton:5 withLayerIndex:i]] currentTitle] isEqualToString:@""]) {
                return [self realButtonNumberForVirtualButton:5 withLayerIndex:i];
            }
        }
        
        //searching the best possibility (ExpertState only):
        srandom(time(NULL));
        int i = (random() % 3); //=Zufallszahl von 0 bis 2: Bei 0 wird der erste und bei 1 der zweite if-Block ausgeführt. Bei i=2 keiner der Beiden. (Schafft ein zufälliges Verhalten [vor allem im zweiten bzw. dritten Zug], da der Bot auf ExpertState sonst eher einseitig ist.)
        if (!(i)) {
            if ([[button[2] currentTitle] stringByAppendingString:[button[8] currentTitle]] == humanValue && [[button[4] currentTitle] stringByAppendingString:[button[6] currentTitle]] == botValue && [[button[5] currentTitle] isEqualToString:@""]) {
                return 5;
            } else if ([[button[1] currentTitle] stringByAppendingString:[button[9] currentTitle]] == humanValue && [[button[3] currentTitle] stringByAppendingString:[button[7] currentTitle]] == botValue && [[button[5] currentTitle] isEqualToString:@""]) {
                return 5;
            }
            for (int i = 0; i < 4; i++) {
                if ([[button[[self realButtonNumberForVirtualButton:2 withLayerIndex:i]] currentTitle] stringByAppendingString:[button[[self realButtonNumberForVirtualButton:3 withLayerIndex:i]] currentTitle]] == humanValue &&
                    [[button[[self realButtonNumberForVirtualButton:4 withLayerIndex:i]] currentTitle] stringByAppendingString:[button[[self realButtonNumberForVirtualButton:7 withLayerIndex:i]] currentTitle]] == botValue &&
                    [[button[[self realButtonNumberForVirtualButton:1 withLayerIndex:i]] currentTitle] isEqualToString:@""]) {
                    return [self realButtonNumberForVirtualButton:1 withLayerIndex:i];
                } else if ([[button[[self realButtonNumberForVirtualButton:4 withLayerIndex:i]] currentTitle] stringByAppendingString:[button[[self realButtonNumberForVirtualButton:7 withLayerIndex:i]] currentTitle]] == humanValue &&
                           [[button[[self realButtonNumberForVirtualButton:5 withLayerIndex:i]] currentTitle] stringByAppendingString:[button[[self realButtonNumberForVirtualButton:9 withLayerIndex:i]] currentTitle]] == botValue &&
                           [[button[[self realButtonNumberForVirtualButton:1 withLayerIndex:i]] currentTitle] isEqualToString:@""]) {
                    return [self realButtonNumberForVirtualButton:1 withLayerIndex:i];
                } else if ([[button[[self realButtonNumberForVirtualButton:2 withLayerIndex:i]] currentTitle] stringByAppendingString:[button[[self realButtonNumberForVirtualButton:3 withLayerIndex:i]] currentTitle]] == humanValue &&
                           [[button[[self realButtonNumberForVirtualButton:5 withLayerIndex:i]] currentTitle] stringByAppendingString:[button[[self realButtonNumberForVirtualButton:9 withLayerIndex:i]] currentTitle]] == botValue &&
                           [[button[[self realButtonNumberForVirtualButton:1 withLayerIndex:i]] currentTitle] isEqualToString:@""]) {
                    return [self realButtonNumberForVirtualButton:1 withLayerIndex:i];
                } else if ([[button[[self realButtonNumberForVirtualButton:1 withLayerIndex:i]] currentTitle] stringByAppendingString:[button[[self realButtonNumberForVirtualButton:3 withLayerIndex:i]] currentTitle]] == humanValue &&
                           [[button[[self realButtonNumberForVirtualButton:5 withLayerIndex:i]] currentTitle] stringByAppendingString:[button[[self realButtonNumberForVirtualButton:8 withLayerIndex:i]] currentTitle]] == botValue &&
                           [[button[[self realButtonNumberForVirtualButton:2 withLayerIndex:i]] currentTitle] isEqualToString:@""]) {
                    return [self realButtonNumberForVirtualButton:2 withLayerIndex:i];
                }
            }
            for (int i = 0; i < 2; i++) {
                if ([[button[[self realButtonNumberForVirtualButton:2 withLayerIndex:i]] currentTitle] stringByAppendingString:[button[[self realButtonNumberForVirtualButton:8 withLayerIndex:i]] currentTitle]] == humanValue &&
                    [[button[[self realButtonNumberForVirtualButton:3 withLayerIndex:i]] currentTitle] stringByAppendingString:[button[[self realButtonNumberForVirtualButton:7 withLayerIndex:i]] currentTitle]] == botValue &&
                    [[button[[self realButtonNumberForVirtualButton:5 withLayerIndex:i]] currentTitle] isEqualToString:@""]) {
                    return [self realButtonNumberForVirtualButton:5 withLayerIndex:i];
                } else if ([[button[[self realButtonNumberForVirtualButton:2 withLayerIndex:i]] currentTitle] stringByAppendingString:[button[[self realButtonNumberForVirtualButton:8 withLayerIndex:i]] currentTitle]] == humanValue &&
                           [[button[[self realButtonNumberForVirtualButton:1 withLayerIndex:i]] currentTitle] stringByAppendingString:[button[[self realButtonNumberForVirtualButton:9 withLayerIndex:i]] currentTitle]] == botValue &&
                           [[button[[self realButtonNumberForVirtualButton:5 withLayerIndex:i]] currentTitle] isEqualToString:@""]) {
                    return [self realButtonNumberForVirtualButton:5 withLayerIndex:i];
                }
            }
        }
        if (!(i-1)) {
            if ([[button[2] currentTitle] stringByAppendingString:[button[8] currentTitle]] == botValue && [[button[4] currentTitle] stringByAppendingString:[button[6] currentTitle]] == humanValue && [[button[5] currentTitle] isEqualToString:@""]) {
                return 5;
            } else if ([[button[1] currentTitle] stringByAppendingString:[button[9] currentTitle]] == botValue && [[button[3] currentTitle] stringByAppendingString:[button[7] currentTitle]] == humanValue && [[button[5] currentTitle] isEqualToString:@""]) {
                return 5;
            }
            for (int i = 0; i < 4; i++) {
                if ([[button[[self realButtonNumberForVirtualButton:2 withLayerIndex:i]] currentTitle] stringByAppendingString:[button[[self realButtonNumberForVirtualButton:3 withLayerIndex:i]] currentTitle]] == botValue &&
                    [[button[[self realButtonNumberForVirtualButton:4 withLayerIndex:i]] currentTitle] stringByAppendingString:[button[[self realButtonNumberForVirtualButton:7 withLayerIndex:i]] currentTitle]] == humanValue &&
                    [[button[[self realButtonNumberForVirtualButton:1 withLayerIndex:i]] currentTitle] isEqualToString:@""]) {
                    return [self realButtonNumberForVirtualButton:1 withLayerIndex:i];
                } else if ([[button[[self realButtonNumberForVirtualButton:4 withLayerIndex:i]] currentTitle] stringByAppendingString:[button[[self realButtonNumberForVirtualButton:7 withLayerIndex:i]] currentTitle]] == botValue &&
                           [[button[[self realButtonNumberForVirtualButton:5 withLayerIndex:i]] currentTitle] stringByAppendingString:[button[[self realButtonNumberForVirtualButton:9 withLayerIndex:i]] currentTitle]] == humanValue &&
                           [[button[[self realButtonNumberForVirtualButton:1 withLayerIndex:i]] currentTitle] isEqualToString:@""]) {
                    return [self realButtonNumberForVirtualButton:1 withLayerIndex:i];
                } else if ([[button[[self realButtonNumberForVirtualButton:2 withLayerIndex:i]] currentTitle] stringByAppendingString:[button[[self realButtonNumberForVirtualButton:3 withLayerIndex:i]] currentTitle]] == botValue &&
                           [[button[[self realButtonNumberForVirtualButton:5 withLayerIndex:i]] currentTitle] stringByAppendingString:[button[[self realButtonNumberForVirtualButton:9 withLayerIndex:i]] currentTitle]] == humanValue &&
                           [[button[[self realButtonNumberForVirtualButton:1 withLayerIndex:i]] currentTitle] isEqualToString:@""]) {
                    return [self realButtonNumberForVirtualButton:1 withLayerIndex:i];
                } else if ([[button[[self realButtonNumberForVirtualButton:1 withLayerIndex:i]] currentTitle] stringByAppendingString:[button[[self realButtonNumberForVirtualButton:3 withLayerIndex:i]] currentTitle]] == botValue &&
                           [[button[[self realButtonNumberForVirtualButton:5 withLayerIndex:i]] currentTitle] stringByAppendingString:[button[[self realButtonNumberForVirtualButton:8 withLayerIndex:i]] currentTitle]] == humanValue &&
                           [[button[[self realButtonNumberForVirtualButton:2 withLayerIndex:i]] currentTitle] isEqualToString:@""]) {
                    return [self realButtonNumberForVirtualButton:2 withLayerIndex:i];
                }
            }
            for (int i = 0; i < 2; i++) {
                if ([[button[[self realButtonNumberForVirtualButton:2 withLayerIndex:i]] currentTitle] stringByAppendingString:[button[[self realButtonNumberForVirtualButton:8 withLayerIndex:i]] currentTitle]] == botValue &&
                    [[button[[self realButtonNumberForVirtualButton:3 withLayerIndex:i]] currentTitle] stringByAppendingString:[button[[self realButtonNumberForVirtualButton:7 withLayerIndex:i]] currentTitle]] == humanValue &&
                    [[button[[self realButtonNumberForVirtualButton:5 withLayerIndex:i]] currentTitle] isEqualToString:@""]) {
                    return [self realButtonNumberForVirtualButton:5 withLayerIndex:i];
                } else if ([[button[[self realButtonNumberForVirtualButton:2 withLayerIndex:i]] currentTitle] stringByAppendingString:[button[[self realButtonNumberForVirtualButton:8 withLayerIndex:i]] currentTitle]] == botValue &&
                           [[button[[self realButtonNumberForVirtualButton:1 withLayerIndex:i]] currentTitle] stringByAppendingString:[button[[self realButtonNumberForVirtualButton:9 withLayerIndex:i]] currentTitle]] == humanValue &&
                           [[button[[self realButtonNumberForVirtualButton:5 withLayerIndex:i]] currentTitle] isEqualToString:@""]) {
                    return [self realButtonNumberForVirtualButton:5 withLayerIndex:i];
                }
            }
        }
    }
    
	//wählt zufällig ein freies Feld
	int loop = 0;
	for (;;) {
		loop++;
		srandom(time(NULL) + loop);
		int i = (random() % 9) + 1;
		if ([[button[i] currentTitle] isEqualToString:@""]) {
            return i;
		}
	}
	return 0;
}

#pragma mark -
#pragma mark layer rotation

- (int)realButtonNumberForVirtualButton:(int)buttonNumber withLayerIndex:(int)index {
    switch (index) {
        case 0: //1.Layer (=0°):
            return buttonNumber;
            break;
        case 1: //2.Layer (=90°):
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
        case 2: //3.Layer (=180°):
            return (10 - buttonNumber);
            break;
        case 3: //4.Layer (=270°)
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
    }
    return 0;
}

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
    //BOOL thempSetX = setX;
    [self clear];
    /*
    if ([[alertView message] isEqualToString:[NSString stringWithFormat:NSLocalizedString(@"won", @"%@ won the game"), @"X"]]) {
        NSLog(@"X won");
    } else if ([[alertView message] isEqualToString:[NSString stringWithFormat:NSLocalizedString(@"won", @"%@ won the game"), @"O"]]) {
        NSLog(@"O won");
    } else if ([[alertView message] isEqualToString:@"XO"]) {
        NSLog(@"draw");
    }
    
    if (letXbegin) {
        NSLog(@"let X beginn");
    } else {
        NSLog(@"let O beginn");
    }
    
    if (thempSetX) {
        NSLog(@"set X");
    } else {
        NSLog(@"set O");
    }
     */
}

#pragma mark -

- (void)clear {
    for (int i = 1; i < 10; i++) {
		[button[i] setTitle:@"" forState:UIControlStateNormal];
		[button[i] setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	}
	if (letXbegin) {
        
        //-->
        for (int i = 1; i < 10; i++) { [button[i] setUserInteractionEnabled:NO]; }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int16_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void){
            for (int i = 1; i < 10; i++) { [button[i] setUserInteractionEnabled:YES]; }
            AudioServicesPlaySystemSound(SoundO);
            [button[[self buttonNumberForValue:@"O" withDifficulty:difficultyState]] setTitle:@"O" forState:UIControlStateNormal];
            [self isGameFinished];
            [UIView animateWithDuration:0.2 animations:^{
                [labelX setAlpha:1.0f];
                [labelO setAlpha:0.3f];
                [countLabelX setAlpha:1.0f];
                [countLabelO setAlpha:0.5f];
            }];
            setX = YES;
        });
        //<--
        
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

@end
