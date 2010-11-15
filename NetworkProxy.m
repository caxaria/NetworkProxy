//
//  NetworkProxy.m
//  DumbestGame
//
//  Created by João Caxaria on 9/15/10.
//  Copyright 2010 Imaginary Factory. All rights reserved.
//

#import "NetworkProxy.h"

@implementation NetworkProxy

-(id) init
{
	icAssert(false, @"Should never call init");
	self = [super init];
	return self;
}

-(id) initWithSession:(GKSession*) msession
{
	self = [super init];
	session = [msession retain];
	session.delegate = self;
	[session setDataReceiveHandler: self withContext: nil];
	return self;
}

-(void) setClient:(id<INetworkClient>) mnetworkClient
{
	networkClient = [mnetworkClient retain];
}

-(void) sendMessage:(NetworkMessage*) message
{
	@try {
		NSError* error;
		if(![session sendDataToAllPeers:[message getData] withDataMode:GKSendDataUnreliable error:&error])
			icDEBUG(@"Could not send data :%@", [error localizedFailureReason]);
	}
	@catch (NSException * e) {
		icDEBUG(@"Caught exception :%@", [e reason]);
	}
}

#pragma mark GKSessionDelegate

/* Indicates a state change for the given peer.
 */
- (void)session:(GKSession *)msession peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state
{
	switch(state)
	{
		case GKPeerStateAvailable:// not connected to session, but available for connectToPeer:withTimeout:
			break;
		case GKPeerStateConnecting: // waiting for accept, or deny response
			break;
		case GKPeerStateConnected:    // connected to the session
			break;
		case GKPeerStateDisconnected: // disconnected from the session
			[msession disconnectPeerFromAllPeers:peerID]; 
			[networkClient networkError];
			break;
		case GKPeerStateUnavailable:  // no longer available
			[networkClient networkError];
			break;
	}
}


- (void) receiveData:(NSData *)data fromPeer:(NSString *)peer inSession: (GKSession *)session context:(void *)context
{
    // Read the bytes in data and perform an application-specific action.
	[networkClient messageReceived:[NetworkMessage fromData:data]];
}

/* Indicates a connection request was received from another peer. 
 
 Accept by calling -acceptConnectionFromPeer:
 Deny by calling -denyConnectionFromPeer:
 */
- (void)session:(GKSession *)session didReceiveConnectionRequestFromPeer:(NSString *)peerID
{
	icAssert(false, @"Should never receive connection request");
}

/* Indicates a connection error occurred with a peer, which includes connection request failures, or disconnects due to timeouts.
 */
- (void)session:(GKSession *)session connectionWithPeerFailed:(NSString *)peerID withError:(NSError *)error
{
	[networkClient networkError];
	icDEBUG(@"Connection With Peer Failed: %s", [[error localizedFailureReason] UTF8String]);
}

/* Indicates an error occurred with the session such as failing to make available.
 */
- (void)session:(GKSession *)session didFailWithError:(NSError *)error
{
	[networkClient networkError];
	icDEBUG(@"Session did fail with error: %s", [[error localizedFailureReason] UTF8String]);
}


@end
