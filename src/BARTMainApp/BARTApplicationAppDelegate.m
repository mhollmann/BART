//
//  BARTApplicationAppDelegate.m
//  BARTApplication
//
//  Created by Lydia Hellrung on 11/12/09.
//  Copyright 2009 MPI Cognitive and Human Brain Sciences Leipzig. All rights reserved.
//

#import "BARTApplicationAppDelegate.h"

#import "CLETUS/COExperimentContext.h"
#import "BAProcedurePipeline.h"
#import "BARTNotifications.h"
#import "CLETUS/COExperimentContext.h"


@interface BARTApplicationAppDelegate ()

-(void)setGUIBackgroundImage:(NSNotification*)aNotification;
-(void)setGUIResultImage:(NSNotification*)aNotification;

@end


@implementation BARTApplicationAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification 
{  
    #pragma unused(aNotification)
    [[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(setGUIBackgroundImage:)
												 name:BARTDidLoadBackgroundImageNotification object:nil];
	
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(setGUIResultImage:)
												 name:BARTDidCalcNextResultNotification object:nil];
    
    
    COExperimentContext *experimentContext = [COExperimentContext getInstance];
    
    
    //(1) load the app own config file to read test configuration stuff
    NSString *errDescr = nil;
    NSPropertyListFormat format;
    NSString *plistPath;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    plistPath = [rootPath stringByAppendingPathComponent:@"ConfigBARTApplication.plist"];
    NSBundle *thisBundle;
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
    {
        thisBundle = [NSBundle bundleForClass:[self class]]; 
        plistPath = [thisBundle pathForResource:@"ConfigBARTApplication" ofType:@"plist"];
    }
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSDictionary *arrayFromPlist = (NSDictionary *) [NSPropertyListSerialization propertyListFromData:plistXML
                                                                                     mutabilityOption:NSPropertyListMutableContainersAndLeaves 
                                                                                               format:&format 
                                                                                     errorDescription:&errDescr];
    if (!arrayFromPlist)
    {
        NSLog(@"Error reading plist from ConfigBARTApplication: %@, format: %lu", errDescr, format);
        return;
    }
	
	guiController = [guiController initWithDefault];

    NSString *testData = [arrayFromPlist objectForKey:@"dataSetForTest"];

    if (nil != testData){
        procedurePipe = [[BAProcedurePipeline alloc] initWithTestDataset:testData];}
    else{
        procedurePipe = [[BAProcedurePipeline alloc] init];}
    
    
    NSString *file = [arrayFromPlist objectForKey:@"edlFile"];
    
    NSError *err = [experimentContext resetWithEDLFile:file];
    if (err) {
        NSLog(@"%@", err);
	}

    [experimentContext startExperiment];
	
	
	
  }

-(void)setGUIBackgroundImage:(NSNotification*)aNotification
{
	//set this as background for viewer
	EDDataElement *elem = (EDDataElement*) [aNotification object];
	[guiController setBackgroundImage:elem];
}

-(void)setGUIResultImage:(NSNotification*)aNotification
{
	
	[guiController setForegroundImage:[aNotification object]];
}

-(void)applicationWillTerminate:(NSNotification*)aNotification
{
    #pragma unused(aNotification)
    [[COExperimentContext getInstance] stopExperiment];
	[procedurePipe release];
    [super dealloc];
}

@end
