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
- (void)setSleepingStatus:(NSString*) status;
- (NSString*)sleepingStatus;
- (void)setSleepTime:(NSDate*)start : (NSDate*) end : (int)row : (BOOL) nap;

- (JJISSleepInfo*)getCurrSleep;
- (JJISSleepInfo*)getCurrentSleepInfo;
- (void)setInfo:(JJISSleepInfo *)currSleepInfo;

- (BOOL)getNapInfo:(int) index;
- (int)getNumEntries;
- (CGFloat)getDataMax;
- (CGFloat) getYearMax;
- (NSMutableArray*)getAllSleepInfo;

- (void)setAllSleepInfo:(NSMutableArray*) newSleepData;

- (NSArray*)getInfo:(int)index;

- (NSMutableArray*)getLastWeekNapData;
- (NSMutableArray*)getMonthNames:(NSDate*) today;
- (NSMutableArray*)getDayNames:(NSDate*) today  : (BOOL) longName;
- (NSMutableArray*)getLastYearInfo:(NSDate*) today;
- (NSMutableArray*)getLastNumDayTotals : (NSDate*) today : (int) numDays;

- (void)calculateSleepRatings;
- (NSMutableArray*)getSleepAverages;
- (NSMutableArray*)getRatingAverages;

- (BOOL)isSameDate:(NSDate*) date1 : (NSDate*) date2;
- (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*) toDateTime;

- (void)sortArray;

@end
