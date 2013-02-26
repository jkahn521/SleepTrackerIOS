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
- (void) createSleepInfo:(NSDate *)start {
    self.timeStart = start;
}

// completeSleepInfo sets the SleepInfo's end time to the parameter time and calculates the sleep duration.
- (void)completeSleepInfo:(NSDate*) end; {
    self.timeEnd = end;
    double intervalInMinutes = [self.timeEnd timeIntervalSinceDate:self.timeStart];
    self.duration = [NSNumber numberWithDouble:intervalInMinutes / 60];
    NSLog(@"duration = %@", self.duration);
}

// getSleepInfo returns self.
- (id)getSleepInfo {
    return self;
}

@end
