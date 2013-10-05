//
//  MBBluetoothSessionManager.h
//  Tic Tac Toe
//
//  Created by Maximilian Brunner on 19.05.13.
//  Copyright (c) 2013 Maximilian Brunner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

typedef enum {
    MBBluetoothPacketTypeTurn
} MBBluetoothPacketType;

typedef enum {
    MBBluetoothConnectionStateDisconnected,
    MBBluetoothConnectionStateConnected
} MBBluetoothConnectionState;

@protocol MBBluetoothSessionManagerDelegate, MBBluetoothDataReceiveHandlerDelegate;

@interface MBBluetoothSessionManager : NSObject <GKSessionDelegate, GKPeerPickerControllerDelegate> {
    id <MBBluetoothSessionManagerDelegate> delegate;
	id <MBBluetoothDataReceiveHandlerDelegate> dataReceiveHandler;
    
    GKPeerPickerController *currentPeerPicker;
    GKSession *currentSession;
    
    MBBluetoothConnectionState currentSessionState;
}

@property (nonatomic, assign) id <MBBluetoothSessionManagerDelegate> delegate;
@property (nonatomic, assign) id <MBBluetoothDataReceiveHandlerDelegate> dataReceiveHandler;

+ (MBBluetoothSessionManager *)sharedManager;

- (void)showPeerPicker;
- (void)dismissPeerPicker;
- (void)sendData:(NSData *)data withSendingMode:(GKSendDataMode )sendingMode ofType:(MBBluetoothPacketType)type;
- (void)disconnect;

@end

@protocol MBBluetoothSessionManagerDelegate
@required
- (void)bluetoothSessionManager:(MBBluetoothSessionManager *)manager didChangeConnectionState:(MBBluetoothConnectionState)connectionState;
- (void)bluetoothSessionManagerDidCancelPeerPicker:(MBBluetoothSessionManager *)manager;
@end

@protocol MBBluetoothDataReceiveHandlerDelegate
@required
- (void)bluetoothSessionManager:(MBBluetoothSessionManager *)manager didReceiveData:(NSData *)data ofType:(MBBluetoothPacketType)type;
@end
