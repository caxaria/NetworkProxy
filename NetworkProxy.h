//
//  NetworkProxy.h
//  DumbestGame
//
//  Created by João Caxaria on 9/15/10.
//  Copyright 2010 Imaginary Factory. All rights reserved.
//

#import <GameKit/GameKit.h>
#import "INetworkClient.h"

@interface NetworkProxy : NSObject<GKSessionDelegate> {

	GKSession* session;
	id<INetworkClient> networkClient;
}

-(id) initWithSession:(GKSession*) msession;

-(void) setClient:(id<INetworkClient>) mnetworkClient;

-(void) sendMessage:(NetworkMessage*) message;

@end
