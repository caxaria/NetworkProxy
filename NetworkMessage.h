//
//  NetworkMessage.h
//  DumbestGame
//
//  Created by João Caxaria on 9/15/10.
//  Copyright 2010 Imaginary Factory. All rights reserved.
//

#import <Foundation/Foundation.h>



typedef enum {
	NetworkMessageType_GameStarting = 0,
	NetworkMessageType_Click = 1,
	NetworkMessageType_FinalScore = 2
} NetworkMessageType;

@interface NetworkMessage : NSCoder
{
	NetworkMessageType messageType;
	int time;
}

+(id) fromData:(NSData*) data;
-(NSData*) getData;

@property (assign) NetworkMessageType messageType;
@property (assign) int time;

@end
