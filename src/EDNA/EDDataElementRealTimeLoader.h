/*
 *  EDDataElementRealTimeLoader.h
 *  BARTApplication
 *
 *  Created by Lydia Hellrung on 3/25/11.
 *  Copyright 2011 MPI Cognitive and Human Brain Sciences Leipzig. All rights reserved.
 *
 */


#import "Cocoa/Cocoa.h"

#import "../BARTMainApp/BADataElementRealTimeLoader.h"
#import "EDDataElementIsisRealTime.h"

@interface EDDataElementRealTimeLoader : BADataElementRealTimeLoader  
{
	EDDataElementIsisRealTime *mDataElement;
	NSMutableArray *arrayLoadedDataElements;
	
}



@end