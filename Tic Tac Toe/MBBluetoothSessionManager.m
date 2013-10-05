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
        currentSession = [[GKSession alloc] initWithSessionID:@"abcdefg" displayName:nil sessionMode:GKSessionModePeer];
		[currentSession setDelegate:self];
		[currentSession setDataReceiveHandler:self withContext:NULL];
		//[currentSession setAvailable:YES];
        currentSessionState = MBBluetoothConnectionStateDisconnected;
	}
	return self;
}


- (void)showPeerPicker {
    if (currentSessionState == MBBluetoothConnectionStateDisconnected) {
        currentPeerPicker = [[GKPeerPickerController alloc] init];
		[currentPeerPicker setDelegate:self];
		[currentPeerPicker setConnectionTypesMask:GKPeerPickerConnectionTypeNearby];
		[currentPeerPicker show];
    }
}

- (void)dismissPeerPicker {
    if (currentSessionState == MBBluetoothConnectionStateDisconnected && currentPeerPicker) {
        if ([currentPeerPicker isVisible]) {
            [currentPeerPicker dismiss];
        }
    }
}

- (void)sendData:(NSData *)data withSendingMode:(GKSendDataMode )sendingMode ofType:(MBBluetoothPacketType)type {
    NSMutableData * newPacket = [NSMutableData dataWithCapacity:([data length] + sizeof(uint32_t))];
    uint32_t swappedType = CFSwapInt32HostToBig((uint32_t)type);
    [newPacket appendBytes:&swappedType length:sizeof(uint32_t)];
    [newPacket appendData:data];
	[currentSession sendDataToAllPeers:newPacket withDataMode:sendingMode error:nil];
}

- (void)disconnect {
    [currentSession disconnectFromAllPeers];
}

#pragma mark - GKPeerPickerControllerDelegate

- (GKSession *)peerPickerController:(GKPeerPickerController *)picker sessionForConnectionType:(GKPeerPickerConnectionType)type {
    return currentSession;
}

- (void)peerPickerController:(GKPeerPickerController *)picker didConnectPeer:(NSString *)peerID toSession:(GKSession *) session {
    [session setDelegate:self];
    [session setDataReceiveHandler:self withContext:NULL];
    currentSession = session;
    [currentSession setDelegate:self];
    [currentSession setDataReceiveHandler:self withContext:NULL];
    
	[picker dismiss];
	picker.delegate = nil;
	[picker autorelease];
}

- (void)peerPickerControllerDidCancel:(GKPeerPickerController *)picker {
    picker.delegate = nil;
    NSLog(@"%d", [picker retainCount]);
	[picker release];
	[delegate bluetoothSessionManagerDidCancelPeerPicker:self];
}

#pragma mark - GKSessionDelegate

- (void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state {
	switch (state) {
        case GKPeerStateAvailable:
            NSLog(@"the Session is Available");
			break;
        case GKPeerStateUnavailable:
            NSLog(@"the Session is Unavailable");
			break;
        case GKPeerStateConnected:
            currentSessionState = MBBluetoothConnectionStateConnected;
            NSLog(@"the Session is Conneced");
			break;
        case GKPeerStateDisconnected:
            currentSessionState = MBBluetoothConnectionStateDisconnected;
            NSLog(@"the Session is Disconnected");
			break;
        case GKPeerStateConnecting:
            NSLog(@"the Session is Connecting");
			break;
    }
	[delegate bluetoothSessionManager:self didChangeConnectionState:currentSessionState];
}

- (void)receiveData:(NSData *)data fromPeer:(NSString *)peer inSession:(GKSession *)session context:(void *)context {
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
    
	[super dealloc];
}

@end
