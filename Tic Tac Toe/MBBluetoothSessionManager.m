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

@synthesize delegate, dataReceiveHandler;

- (id)init {
	if (self = [super init]) {
        MCPeerID *peerID = [[MCPeerID alloc] initWithDisplayName:[[UIDevice currentDevice] name]];
        session = [[MCSession alloc] initWithPeer:peerID];
        [peerID release];
        [session setDelegate:self];
        advertiserAssistant = [[MCAdvertiserAssistant alloc] initWithServiceType:@"at-mb-tictactoe" discoveryInfo:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"IDString", @"ID2String", nil]
                                                                                                                                                    forKeys:[NSArray arrayWithObjects:@"ID", @"ID2", nil]] session:session];
        [advertiserAssistant setDelegate:self];
        MCNearbyServiceBrowser *browser = [[MCNearbyServiceBrowser alloc] initWithPeer:peerID serviceType:@"at-mb-tictactoe"];
        [peerID release];
        browserViewController = [[MCBrowserViewController alloc] initWithBrowser:browser session:session];
        [browser release];
        [browserViewController setMaximumNumberOfPeers:2];
        [browserViewController setDelegate:self];
        currentSessionState = MBBluetoothConnectionStateDisconnected;
	}
	return self;
}



- (void)startAdertising {
    [advertiserAssistant start];
}

- (void)stopAdvertising {
    [advertiserAssistant stop];
}

- (void)showPeerBrowser {
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:browserViewController animated:YES completion:^{
        
    }];
}

- (void)dismissPeerBrowser {
    [browserViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)sendData:(NSData *)data ofType:(MBBluetoothPacketType)type {
    NSMutableData * newPacket = [NSMutableData dataWithCapacity:([data length] + sizeof(uint32_t))];
    uint32_t swappedType = CFSwapInt32HostToBig((uint32_t)type);
    [newPacket appendBytes:&swappedType length:sizeof(uint32_t)];
    [newPacket appendData:data];
    //[currentSession sendDataToAllPeers:newPacket withDataMode:sendingMode error:nil];
    [session sendData:newPacket toPeers:[NSArray arrayWithObject:connectedPeer] withMode:MCSessionSendDataReliable error:nil];
}

- (void)disconnect {
    [session disconnect];
}

- (MBBluetoothConnectionState)connectionState {
    return currentSessionState;
}

#pragma mark - MCSessionDelegate

- (void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state {
    switch (state) {
        case MCSessionStateConnected:
            [self stopAdvertising];
            NSLog(@"Connected");
            if (currentSessionState != MBBluetoothConnectionStateConnected) {
                currentSessionState = MBBluetoothConnectionStateConnected;
                [delegate bluetoothSessionManager:self didChangeConnectionState:MBBluetoothConnectionStateConnected];
            }
            [browserViewController dismissViewControllerAnimated:YES completion:^{
                
            }];
            break;
        case MCSessionStateConnecting:
            NSLog(@"Connecting");
            if (currentSessionState != MBBluetoothConnectionStateConnecting) {
                currentSessionState = MBBluetoothConnectionStateConnecting;
                [delegate bluetoothSessionManager:self didChangeConnectionState:MBBluetoothConnectionStateConnecting];
            }
            break;
        case MCSessionStateNotConnected:
            [self startAdertising];
            NSLog(@"Disconnected");
            if (currentSessionState != MBBluetoothConnectionStateDisconnected) {
                currentSessionState = MBBluetoothConnectionStateDisconnected;
                [delegate bluetoothSessionManager:self didChangeConnectionState:MBBluetoothConnectionStateDisconnected];
            }
            break;
    }
}

- (void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID {
    MBBluetoothPacketType header;
    uint32_t swappedHeader;
    if ([data length] >= sizeof(uint32_t)) {
        [data getBytes:&swappedHeader length:sizeof(uint32_t)];
        header = (MBBluetoothPacketType)CFSwapInt32BigToHost(swappedHeader);
        NSRange payloadRange = { sizeof(uint32_t), [data length] - sizeof(uint32_t) };
        NSData* payload = [data subdataWithRange:payloadRange];
		[dataReceiveHandler bluetoothSessionManager:self didReceiveData:payload ofType:header];
    }
}

#pragma mark - MCAdvertiserAssistantDelegate


- (void)advertiserAssitantWillPresentInvitation:(MCAdvertiserAssistant *)advertiserAssistant {
    
}

- (void)advertiserAssistantDidDismissInvitation:(MCAdvertiserAssistant *)advertiserAssistant {
    
}

#pragma mark - MCBrowserViewControllerDelegate

- (BOOL)browserViewController:(MCBrowserViewController *)browserViewController shouldPresentNearbyPeer:(MCPeerID *)peerID withDiscoveryInfo:(NSDictionary *)info {
    return YES;
}

- (void)browserViewControllerDidFinish:(MCBrowserViewController *)browser {
    [browserViewController dismissViewControllerAnimated:YES completion:^{
        [delegate bluetoothSessionManagerDidDismissPeerBrowser:self];
    }];
}

- (void)browserViewControllerWasCancelled:(MCBrowserViewController *)browser {
    [browserViewController dismissViewControllerAnimated:YES completion:^{
        [delegate bluetoothSessionManagerDidDismissPeerBrowser:self];
    }];
}

#pragma mark - Singleton

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
    return NSUIntegerMax;
}

- (oneway void)release {
}

- (id)autorelease {
    return self;
}

- (void)dealloc {
    [session disconnect];
    [session release];
    [advertiserAssistant stop];
    [advertiserAssistant release];
    [browserViewController release];
	[super dealloc];
}

@end
