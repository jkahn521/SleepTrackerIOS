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
    /*self.timeEnd = nil;
    self.explanations = nil;
    self.duration = nil;*/
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

// encodeWithCoder sets the encoding scheme for saving a JJISSleepInfo to a plist
- (void) encodeWithCoder: (NSCoder *)coder
{
   // NSLog(@"encode");
    [coder encodeObject: self.timeStart forKey:@"timeStart"];
    [coder encodeObject: self.timeEnd forKey:@"timeEnd"];
    [coder encodeObject: self.duration forKey:@"duration"];
    [coder encodeObject: [NSNumber numberWithBool:self.isNap] forKey:@"isNap"];    
    [coder encodeObject: self.explanations forKey:@"explanations"];
}

// initWithCoder sets the decoding scheme for loading a JJISSleepInfo from the plist
- (id) initWithCoder: (NSCoder *)coder
{
    if (self = [super init])
    {
    //     NSLog(@"initencode");
        self.timeStart = [coder decodeObjectForKey:@"timeStart"];
        self.timeEnd = [coder decodeObjectForKey:@"timeEnd"];
        self.duration = [coder decodeObjectForKey:@"duration"];
        self.isNap = [[coder decodeObjectForKey:@"isNap"] boolValue];
        self.explanations = [coder decodeObjectForKey:@"explanations"];
    }
    return self;
}
@end
