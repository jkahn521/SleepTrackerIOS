//
//  JJISSleepInfo.h
//  SleepTracker
//
//  Created by Jason Kahn on 2/22/13.
//  Copyright (c) 2013 Jason Kahn. All rights reserved.
//
//  SleepInfo represents a user's sleep entry with start and stop times, and sleeping duration.
//  SleepInfo objects are stored in an array by the SleepInfoManager who accesses various
//  SleepInfo attributes.

#import <Foundation/Foundation.h>
#import "JJISSleepExplanation.h"

@interface JJISSleepInfo : NSObject

@property (strong, nonatomic) NSDate *timeStart;
@property (strong, nonatomic) NSDate *timeEnd;
@property (strong, nonatomic) NSNumber* duration;
@property BOOL isNap;
@property (strong, nonatomic) JJISSleepExplanation* explanations;

- (id)init;
- (void)createSleepInfo:(NSDate*) start : (BOOL) nap;
- (void)completeSleepInfo:(NSDate*) end;
- (void)completeSleepInfo:(NSDate*) end : (JJISSleepExplanation*) explanations;
- (void)updateDuration;
- (id)getSleepInfo;

@end

