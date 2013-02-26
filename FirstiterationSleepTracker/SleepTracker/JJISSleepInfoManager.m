//
//  JJISSleepinfoManager.m
//  SleepTracker
//
//  Created by Jason Kahn on 2/22/13.
//  Copyright (c) 2013 Jason Kahn. All rights reserved.
//

#import "JJISSleepInfoManager.h"
#import "JJISSleepInfo.h"

@interface JJISSleepInfoManager ()
@property (strong, nonatomic) NSMutableArray *sleepData;
@property (strong, nonatomic) JJISSleepInfo *currentSleepInfo;
@end

@implementation JJISSleepInfoManager

// init initializes the SleepInfoManager with an empty sleepData array and currentSleepInfo
- (id) init {
    self = [super init];
    self.sleepData = [[NSMutableArray alloc] init];
    self.currentSleepInfo = [[JJISSleepInfo alloc] init];
    if(self)
    {
        return self;
    }
    return nil;
    
}

// startSleeping adds the start time to the currentSleepInfo object
- (void)startSleeping:(NSDate*) now {
    self.currentSleepInfo = [[JJISSleepInfo alloc] init];
    [self.currentSleepInfo createSleepInfo:now];

}

// doneSleeping adds the completion time to the currentSleepInfo object and adds the object to sleepData
- (void)doneSleeping:(NSDate*) now {
    [self.currentSleepInfo completeSleepInfo:now];
    [self.sleepData insertObject:self.currentSleepInfo atIndex:0];
    //NSLog(@"Entry: %@ \n", self.sleepData);
    
}

// getNumEntries returns the number of completed SleepInfo objects in sleepData
- (int)getNumEntries {
    return [self.sleepData count];
}

// getInfo returns an array of strings representing the start date, start time, end time, and sleep
// duration, called by SleepTableViewController
- (NSArray*)getInfo:(int) index {
    JJISSleepInfo* info = [self.sleepData[index] getSleepInfo];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"EEEE MMMM dd, yyyy"];
    NSString* date = [format stringFromDate:info.timeStart];
    [format setDateFormat:@"hh:mm a"];
    int minutes = [info.duration intValue];
    int hours = minutes/60;
    NSString* duration = [[NSString alloc] init];
    if (minutes < 10) {
        duration = [NSString stringWithFormat:@"%d:0%d", hours, minutes];
    }
    else {
        duration = [NSString stringWithFormat:@"%d:%d", hours, minutes];
    }
    
    NSArray* infoStrings = [[NSArray alloc] init];
    infoStrings = @[date, [format stringFromDate:info.timeStart],[format stringFromDate:info.timeEnd], duration];
    return infoStrings;
}

// return most recent SleepInfo in the sleepData array
- (JJISSleepInfo*)getCurrSleep {
    return self.sleepData[0];
}



@end
