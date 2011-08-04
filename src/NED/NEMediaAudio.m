//
//  NEMediaAudio.m
//  BARTPresentation
//
//  Created by Oliver Zscheyge on 4/7/10.
//  Copyright 2010 MPI Cognitive and Human Brain Scienes Leipzig. All rights reserved.
//

#import "NEMediaAudio.h"
#import "COSystemConfig.h"


@implementation NEMediaAudio

-(id)initWithID:(NSString*)objID 
        andFile:(NSString*)path 
{
    if (self = [super init]) {
        mID    = [objID retain];
        
        NSString* resolvedPath  = [[COSystemConfig getInstance] getEDLFilePath];
        resolvedPath = [resolvedPath stringByDeletingLastPathComponent];
        NSArray* pathComponents = [[resolvedPath pathComponents] arrayByAddingObjectsFromArray:[path pathComponents]];
        resolvedPath = [NSString pathWithComponents:pathComponents];
        //TODO: error handling if file not found!
        mTrack = [[QTMovie movieWithURL:[NSURL fileURLWithPath:resolvedPath] error:nil] retain];
    }
    
    return self;
}

-(void)dealloc
{    
    [mID release];
    [mTrack release];
    
    [super dealloc];
}

-(void)presentInContext:(CGContextRef)context andRect:(NSRect)rect
{
    [mTrack play];
}

-(void)pausePresentation;
{
    [mTrack stop];
}

-(void)continuePresentation
{
    [mTrack play];
}

-(void)stopPresentation
{
    [mTrack stop];
    [mTrack gotoBeginning];
}

@end
