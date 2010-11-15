//
//  INetworkClient.h
//  DumbestGame
//
//  Created by João Caxaria on 9/15/10.
//  Copyright 2010 Imaginary Factory. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkMessage.h"

@protocol INetworkClient <NSObject>

@required

-(void) messageReceived:(NetworkMessage*) data;
-(void) networkError;

@end
