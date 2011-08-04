//
//  NELogFormatterTest.m
//  BARTPresentation
//
//  Created by Oliver Zscheyge on 5/4/10.
//  Copyright 2010 MPI Cognitive and Human Brain Scienes Leipzig. All rights reserved.
//

#import "NELogFormatterTest.h"
#import "NELogFormatter.h"
#import "NEStimEvent.h"
#import "NEMediaText.h"


@implementation NELogFormatterTest

-(void)testStringForTriggerNumber
{
    NELogFormatter* formatter = [[NELogFormatter alloc] init];
    NSString* expected = [NSString stringWithFormat:@"%@%@%d", 
                          [formatter triggerIdentifier], 
                          [formatter keyValueSeperator], 
                          42];
    
    NSString* actual = [formatter stringForTriggerNumber:42];
    
    BOOL success = NO;
    if ([actual compare:expected] == 0) {
        success = YES;
    }
    
    STAssertTrue(success, @"TriggerNumber to string conversion does not work properly!");
    [formatter release];
}

-(void)testStringForStimEvent
{
    NEStimEvent* event = [[NEStimEvent alloc] initWithTime:24 
                                                  duration:42 
                                               mediaObject:[[NEMediaText alloc] initWithID:@"foo" andText:@"bar"]];
    
    NELogFormatter* formatter = [[NELogFormatter alloc] init];
    
    NSString* expected = [NSString stringWithFormat:@"%@%@%@%d%@%d%@%@%@",
                          [formatter eventIdentifier],
                          [formatter keyValueSeperator],
                          [formatter beginSetDelimiter],
                          24,
                          [formatter entrySeperator],
                          42,
                          [formatter entrySeperator],
                          @"foo",
                          [formatter endSetDelimiter]];
    
    NSString* actual = [formatter stringForStimEvent:event];
    
    BOOL success = NO;
    if ([actual compare:expected] == 0) {
        success = YES;
    }
    
    STAssertTrue(success, @"StimEvent to string conversion does not work properly!");
    [formatter release];
    [event release];
}

@end
