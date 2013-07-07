//
//  MBBluetoothSessionManager.m
//  Tic Tac Toe
//
//  Created by Maximilian Brunner on 19.05.13.
//  Copyright (c) 2013 Maximilian Brunner. All rights reserved.
//

#import "MBBluetoothSessionManager.h"

@implementation MBBluetoothSessionManager

static MBBluetoothSessionManager *sharedSessionManager = nil;

- (id)init {
    self = [super init];
	if (self) {
        
	}
	return self;
}


#pragma mark -
#pragma Singleton:

+ (MBBluetoothSessionManager *)sharedManager {
    if (sharedSessionManager == nil) {
        sharedSessionManager = [[super allocWithZone:NULL] init];
    }
    return sharedSessionManager;
}

+ (id)allocWithZone:(NSZone *)zone {
	return [[self sharedManager] retain];
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (id)retain {
    return self;
}

- (NSUInteger)retainCount {
    return NSUIntegerMax;  //denotes an object that cannot be released
}

- (oneway void)release {
    //do nothing
}

- (id)autorelease {
    return self;
}

- (void)dealloc {
    
	[super dealloc];
}

@end
