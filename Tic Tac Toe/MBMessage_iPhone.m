//
//  MBMessage_iPhone.m
//  Tic Tac Toe
//
//  Created by Maximilian Brunner on 05.10.13.
//  Copyright (c) 2013 Maximilian Brunner. All rights reserved.
//

#import "MBMessage_iPhone.h"

@implementation MBMessage_iPhone

- (id)init {
	[super init];
	animatedLabel = [[UILabel alloc] init];
	[animatedLabel setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.0]];
	[animatedLabel setTextAlignment:NSTextAlignmentCenter];
    [animatedLabel setAlpha:0.0];
	return self;
}

- (id)initWithTitle:(NSString *)title {
	animatedLabel = [[UILabel alloc] init];
	[animatedLabel setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.0]];
	[animatedLabel setTextAlignment:NSTextAlignmentCenter];
	[animatedLabel setText:title];
    [animatedLabel setAlpha:0.0];
	return self;
}

- (id)initWithTitle:(NSString *)title andTextColor:(UIColor *)color {
	animatedLabel = [[UILabel alloc] init];
	[animatedLabel setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.0]];
	[animatedLabel setTextAlignment:NSTextAlignmentCenter];
	[animatedLabel setText:title];
	[animatedLabel setTextColor:color];
    [animatedLabel setAlpha:0.0];
	return self;
}

- (void)show {
	[animatedLabel setFont:[UIFont fontWithName:@"Helvetica" size:160]];
    [animatedLabel setFrame:CGRectMake(-340.0, 130.0, 1000.0, 180.0)];
	[[[UIApplication sharedApplication] keyWindow] addSubview:animatedLabel];
    
    CAKeyframeAnimation *fadeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    fadeAnimation.duration = 1.0;
    fadeAnimation.values = [NSArray arrayWithObjects:
                            [NSNumber numberWithFloat:0.05],
                            [NSNumber numberWithFloat:0.2],
                            [NSNumber numberWithFloat:0.30],
                            [NSNumber numberWithFloat:1],
                            nil];
    fadeAnimation.keyTimes = [NSArray arrayWithObjects:
                              [NSNumber numberWithFloat:0.0],
                              [NSNumber numberWithFloat:0.22],
                              [NSNumber numberWithFloat:0.65],
                              [NSNumber numberWithFloat:1.1],
                              nil];
    [fadeAnimation setCalculationMode:kCAAnimationLinear];
    [fadeAnimation setDelegate:self];
    
    CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.duration = 1.0;
    opacityAnimation.values = [NSArray arrayWithObjects:
                               [NSNumber numberWithFloat:1.0],
                               [NSNumber numberWithFloat:1.0],
                               [NSNumber numberWithFloat:0.0],
                               nil];
    opacityAnimation.keyTimes = [NSArray arrayWithObjects:
                                 [NSNumber numberWithFloat:0.0],
                                 [NSNumber numberWithFloat:0.7],
                                 [NSNumber numberWithFloat:1.0],
                                 nil];
    
    [animatedLabel.layer addAnimation:fadeAnimation forKey:@"transform.scale"];
    [animatedLabel.layer addAnimation:opacityAnimation forKey:@"opacity"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [animatedLabel removeFromSuperview];
}

- (NSString *)messageTitle {
	return [animatedLabel text];
}

- (void)setMessageTitle:(NSString *)title {
	[animatedLabel setText:title];
}

- (UIColor *)messageColor {
	return [animatedLabel textColor];
}

- (void)setMessageColor:(UIColor *)color {
	[animatedLabel setTextColor:color];
}

+ (UIColor *)defaultTextColor {
	return [UIColor grayColor];
}

- (void)dealloc {
	[animatedLabel release];
	[messageColor release];
	[messageTitle release];
	[super dealloc];
}

@end