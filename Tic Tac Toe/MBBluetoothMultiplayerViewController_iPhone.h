//
//  MBBluetoothMultiplayerViewController_iPhone.h
//  Tic Tac Toe
//
//  Created by Beatrix Brunner on 30.03.13.
//  Copyright (c) 2013 Maximilian Brunner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "MBBluetoothSessionManager.h"

@interface MBBluetoothMultiplayerViewController_iPhone : UIViewController <MBBluetoothDataReceiveHandlerDelegate> {
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


@interface MBBluetoothMultiplayerViewController_iPhone ()

- (void)checkState;
- (void)increaseX;
- (void)increaseO;
- (void)clear;

//1.Layer: layerIndex = 0 ( = 0° )
//2.Layer: layerIndex = 1 ( = 90° )
//3.Layer: layerIndex = 2 ( = 180° )
//4.Layer: layerIndex = 3 ( = 270° )
- (int)virtualButtonNumberForRealButton:(int)buttonNumber withLayerIndex:(int)index;

@end
