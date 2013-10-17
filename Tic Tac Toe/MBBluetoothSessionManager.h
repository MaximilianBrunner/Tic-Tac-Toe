//
//  MBBluetoothSessionManager.h
//  Tic Tac Toe
//
//  Created by Maximilian Brunner on 19.05.13.
//  Copyright (c) 2013 Maximilian Brunner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>

typedef enum {
    MBBluetoothPacketTypeTurn
} MBBluetoothPacketType;

typedef enum {
    MBBluetoothConnectionStateConnected,
    MBBluetoothConnectionStateConnecting,
    MBBluetoothConnectionStateDisconnected
} MBBluetoothConnectionState;

@protocol MBBluetoothSessionManagerDelegate, MBBluetoothDataReceiveHandlerDelegate;

@interface MBBluetoothSessionManager : NSObject <MCSessionDelegate ,MCAdvertiserAssistantDelegate, MCBrowserViewControllerDelegate> {
    id <MBBluetoothSessionManagerDelegate> delegate;
	id <MBBluetoothDataReceiveHandlerDelegate> dataReceiveHandler;
    
    MCSession *session;
    MCAdvertiserAssistant *advertiserAssistant;
    MCBrowserViewController *browserViewController;
    MCPeerID *connectedPeer;
    
    MBBluetoothConnectionState currentSessionState;
}

@property (nonatomic, assign) id <MBBluetoothSessionManagerDelegate> delegate;
@property (nonatomic, assign) id <MBBluetoothDataReceiveHandlerDelegate> dataReceiveHandler;

+ (MBBluetoothSessionManager *)sharedManager;


- (void)startAdertising;
- (void)stopAdvertising;
- (void)showPeerBrowser;
- (void)dismissPeerBrowser;

- (void)sendData:(NSData *)data ofType:(MBBluetoothPacketType)type;
- (void)disconnect;

- (MBBluetoothConnectionState)connectionState;

@end

@protocol MBBluetoothSessionManagerDelegate
@required
- (void)bluetoothSessionManager:(MBBluetoothSessionManager *)manager didChangeConnectionState:(MBBluetoothConnectionState)connectionState;
- (void)bluetoothSessionManagerDidDismissPeerBrowser:(MBBluetoothSessionManager *)manager;

@end

@protocol MBBluetoothDataReceiveHandlerDelegate
@required
- (void)bluetoothSessionManager:(MBBluetoothSessionManager *)manager didReceiveData:(NSData *)data ofType:(MBBluetoothPacketType)type;
@end
