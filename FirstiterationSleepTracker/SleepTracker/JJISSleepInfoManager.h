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

@interface JJISSleepInfoManager : NSObject

- (id)init;

- (void)startSleeping:(NSDate*) now;
- (void)doneSleeping:(NSDate*) now;
- (JJISSleepInfo*)getCurrSleep;
- (int)getNumEntries;

- (NSArray*)getInfo:(int) index;

@end
