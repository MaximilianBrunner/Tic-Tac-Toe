//
//  MBGameCenterSessionManager.h
//  Tic Tac Toe
//
//  Created by Maximilian Brunner on 19.05.13.
//  Copyright (c) 2013 Maximilian Brunner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

typedef enum {
    MBGameCenterPacketTypeTurn
} MBGameCenterPacketType;

@protocol MBGameCenterSessionManagerDelegate, MBGameCenterDataReceiveHandlerDelegate;

@interface MBGameCenterSessionManager : NSObject {
    id <MBGameCenterSessionManagerDelegate> delegate;
	id <MBGameCenterDataReceiveHandlerDelegate> dataReceiveHandler;
    
    GKLocalPlayer *localPlayer;
    
}

+ (MBGameCenterSessionManager *)sharedManager;

+ (BOOL)isGameCenterAvailable;

//- (void)createNewGameWithPlayer:(GKPlayer *)player CompletionHandler:(void (^)(GKTurnBasedMatch *matche, NSError *error))completionHandler;
- (void)loadGamesWithCompletionHandler:(void (^)(NSArray *games, NSError *error))completionHandler;


- (void)loadFriendsWithCompletionHandler:(void (^)(NSArray *friends, NSError *error))completionHandler;

@end


@protocol MBGameCenterSessionManagerDelegate
@required
//- (void)bluetoothSessionManager:(MBGameCenterSessionManager *)manager didChangeConnectionState:(MBBluetoothConnectionState)connectionState;
@end

@protocol MBGameCenterDataReceiveHandlerDelegate
@required
- (void)gameCenterSessionManager:(MBGameCenterSessionManager *)manager didReceiveData:(NSData *)data ofType:(MBGameCenterPacketType)type;
@end
