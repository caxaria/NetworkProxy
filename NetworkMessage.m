//
//  NetworkMessage.m
//  DumbestGame
//
//  Created by João Caxaria on 9/15/10.
//  Copyright 2010 Imaginary Factory. All rights reserved.
//

#import "NetworkMessage.h"


@implementation NetworkMessage

#pragma mark NSCoder

- (id)initWithCoder:(NSCoder *)coder 
{
	self = [super init];
	
	[coder decodeValueOfObjCType:@encode(NSInteger) at:&messageType];
	[coder decodeValueOfObjCType:@encode(NSInteger) at:&time];

	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder 
{
	[coder encodeValueOfObjCType:@encode(NSInteger) at:&messageType];
	[coder encodeValueOfObjCType:@encode(NSInteger) at:&time];
}

#pragma mark NetworkData

@synthesize messageType;
@synthesize time;

+(id) fromData:(NSData*) data
{
	NSKeyedUnarchiver *decoder = [[[NSKeyedUnarchiver alloc] initForReadingWithData:data] autorelease];
	
	NetworkMessage* networkData = [decoder decodeObjectForKey:@"NetworkMessage"];
	
	[decoder finishDecoding];
	
	return networkData;
}

-(NSData*) getData
{
	NSMutableData *theData;
	NSKeyedArchiver *encoder;
	
	theData = [NSMutableData data];
	encoder = [[[NSKeyedArchiver alloc] initForWritingWithMutableData:theData] autorelease];
	
	[encoder encodeObject:self forKey:@"NetworkMessage"];
	[encoder finishEncoding];
	
	return theData;
}

@end
