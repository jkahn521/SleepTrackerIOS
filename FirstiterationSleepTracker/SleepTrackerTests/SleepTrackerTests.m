//
//  SleepTrackerTests.m
//  SleepTrackerTests
//
//  Created by Jason Kahn on 2/18/13.
//  Copyright (c) 2013 Jason Kahn. All rights reserved.
//

#import "SleepTrackerTests.h"
#import "JJISSleepInfo.h"
#import "JJISSleepInfoManager.h"
#import "JJISAppDelegate.h"


@implementation SleepTrackerTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}


- (void) testGoToSleep{
    
    NSDate *now = [NSDate date];
    
    JJISAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    [appDelegate.manager startSleeping:now];
     [appDelegate.manager doneSleeping:now];
    
    JJISSleepInfo* j = appDelegate.manager.getCurrSleep;
    
    STAssertEquals(now, j.timeStart, @"Checks the start time of sleeping");
}

- (void) testWakeUp{
    
    NSDate *now = [NSDate date];
    
    JJISAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    [appDelegate.manager doneSleeping:now];
    
    JJISSleepInfo* j = appDelegate.manager.getCurrSleep;
    
    STAssertEquals(now, j.timeEnd, @"Checks the start time of sleeping");
}


- (void) testDuration{
    
    JJISAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd HH:mm"];
    NSString* startString = @"20130225 19:45";
    NSString* endString = @"20130225 20:00";
    NSDate* startDate = [formatter dateFromString:startString];
    NSDate* endDate = [formatter dateFromString:endString];

    
    
    [appDelegate.manager startSleeping:startDate];
    [appDelegate.manager doneSleeping:endDate];
    
    
    JJISSleepInfo* j = appDelegate.manager.getCurrSleep;
    
    STAssertEquals(15, [j.duration integerValue], @"Checks the duration of sleep");
}

@end
