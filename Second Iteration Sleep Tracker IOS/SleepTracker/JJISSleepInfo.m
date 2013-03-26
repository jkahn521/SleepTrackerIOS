//
//  JJISSleepInfo.m
//  SleepTracker
//
//  Created by Jason Kahn on 2/22/13.
//  Copyright (c) 2013 Jason Kahn. All rights reserved.
//

#import "JJISSleepInfo.h"

@interface JJISSleepInfo()



@end

@implementation JJISSleepInfo

- (id) init {
    self = [super init];
    
    if(self)
    {
        return self;
    }
    return nil;
}

// createSleepInfo sets the SleepInfo's start time to the parameter time.
- (void) createSleepInfo:(NSDate *) start : (BOOL) nap {
    self.timeStart = start;
    self.isNap = nap;
}

// completeSleepInfo sets the SleepInfo's end time to the parameter time and calculates the sleep duration.
- (void)completeSleepInfo:(NSDate*) end {
    self.timeEnd = end;
    [self updateDuration];
}

// completeSleepInfo sets the SleepInfo's end time to the parameter time, calculates the sleep duration, and records the explanations for problematic sleep.
- (void)completeSleepInfo:(NSDate*) end : (JJISSleepExplanation*) explanations {
    self.timeEnd = end;
    [self updateDuration];
    self.explanations = explanations;
}

//updateDuration calculates the sleep's duration in minutes.
- (void)updateDuration  {
    double intervalInMinutes = [self.timeEnd timeIntervalSinceDate:self.timeStart];
    self.duration = [NSNumber numberWithDouble:intervalInMinutes / 60];

}

// getSleepInfo returns self.
- (id)getSleepInfo {
    return self;
}

@end
