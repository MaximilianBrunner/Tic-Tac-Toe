//
//  MBMultiplayerViewController_iPhone.h
//  Tic Tac Toe
//
//  Created by Beatrix Brunner on 29.03.13.
//  Copyright (c) 2013 Maximilian Brunner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@interface MBMultiplayerViewController_iPhone : UIViewController <UIAlertViewDelegate> {
    IBOutlet UIButton *button1;
	IBOutlet UIButton *button2;
	IBOutlet UIButton *button3;
	IBOutlet UIButton *button4;
	IBOutlet UIButton *button5;
	IBOutlet UIButton *button6;
	IBOutlet UIButton *button7;
	IBOutlet UIButton *button8;
	IBOutlet UIButton *button9;
    
    IBOutlet UILabel *labelX;
    IBOutlet UILabel *labelO;
    IBOutlet UILabel *countLabelX;
	IBOutlet UILabel *countLabelO;
    
    UIButton *button[10];
    
    SystemSoundID SoundX;
	SystemSoundID SoundO;
    
    //switches every game:
    BOOL letXbegin;
    //switches every move:
    BOOL setX;
}

- (IBAction)buttonClick:(UIButton *)sender;

@end


@interface MBMultiplayerViewController_iPhone ()

- (void)checkState;
- (void)increaseX;
- (void)increaseO;
- (void)clear;

@end
