//
//  MBGameCenterSessionManager.m
//  Tic Tac Toe
//
//  Created by Maximilian Brunner on 19.05.13.
//  Copyright (c) 2013 Maximilian Brunner. All rights reserved.
//

#import "MBGameCenterSessionManager.h"

@implementation MBGameCenterSessionManager

static MBGameCenterSessionManager *sharedSessionManager = nil;

- (id)init {
	if (self = [super init]) {
        GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
        [localPlayer setAuthenticateHandler:^(UIViewController *viewController, NSError *error) {
            if (viewController) {
                NSLog(@"GC is enabled");
                NSLog(@"show Authentication Dialog When Reasonable");
            }
            else if ([localPlayer isAuthenticated]) {
                NSLog(@"GC is enabled");
            }
            else {
                NSLog(@"GC is disabled");
            }
        }];
	}
	return self;
}

#pragma mark - Singleton

+ (MBGameCenterSessionManager *)sharedManager {
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
    return NSUIntegerMax;
}

- (oneway void)release {
}

- (id)autorelease {
    return self;
}

- (void)dealloc {
    
	[super dealloc];
}

@end
