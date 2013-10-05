//
//  MBMessage_iPhone.h
//  Tic Tac Toe
//
//  Created by Maximilian Brunner on 05.10.13.
//  Copyright (c) 2013 Maximilian Brunner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>


@interface MBMessage_iPhone : NSObject {
	UILabel *animatedLabel;
	NSString *messageTitle;
	UIColor *messageColor;
}

@property (nonatomic, retain) NSString *messageTitle;
@property (nonatomic, retain) UIColor *messageColor;

+ (UIColor *)defaultTextColor;

- (id)initWithTitle:(NSString *)title;
- (id)initWithTitle:(NSString *)title andTextColor:(UIColor *)color;
- (void)show;

@end