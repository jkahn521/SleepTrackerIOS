//
//  JJISSleepinfoManager.h
//  SleepTracker
//
//  Created by Jason Kahn on 2/22/13.
//  Copyright (c) 2013 Jason Kahn. All rights reserved.
//
//  SleepInfoManager class maintains the array associated with sleep data
//  and performs calculations associated with outputting sleep data

#import <Foundation/Foundation.h>
#import "JJISSleepInfo.h"
#import "JJISSleepExplanation.h"

@interface JJISSleepInfoManager : NSObject

- (id)init;
- (void)startSleeping:(NSDate*) now : (BOOL) isNap;
- (void)doneSleeping:(NSDate*) now;
- (void)doneSleeping:(NSDate*) now : (JJISSleepExplanation*) explanations;
- (void)setSleepTime:(NSDate*)start : (NSDate*) end : (int)row : (BOOL) nap;

- (JJISSleepInfo*)getCurrSleep;
- (BOOL)getNapInfo:(int) index;
- (int)getNumEntries;
- (CGFloat)getDataMax;

- (NSArray*)getInfo:(int) index;

- (NSMutableArray*) getLastWeekNapData;
- (NSMutableArray*) getLastWeekDays:(NSDate*) today;
- (NSMutableArray*) getLastWeekTotals:(NSDate*) today;

- (BOOL)isSameDate:(NSDate*) date1 : (NSDate*) date2;
- (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*) toDateTime;


- (void)sortArray;


@end
