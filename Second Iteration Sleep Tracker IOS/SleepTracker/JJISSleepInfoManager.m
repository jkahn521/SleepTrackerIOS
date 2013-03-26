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
@property (strong, nonatomic) NSMutableArray *napData;
@property (strong, nonatomic) NSMutableArray *dayData;
@property CGFloat max;
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
- (void)startSleeping:(NSDate*) now :(BOOL) isNap {
    self.currentSleepInfo = [[JJISSleepInfo alloc] init];
    [self.currentSleepInfo createSleepInfo:now:isNap];
    

}

// doneSleeping adds the completion time to the currentSleepInfo object and adds the object to sleepData
- (void)doneSleeping:(NSDate*) now {
    
    if(self.currentSleepInfo.timeStart == NULL){
        self.currentSleepInfo.timeStart = now;
    }
    [self.currentSleepInfo completeSleepInfo:now];
    [self.sleepData insertObject:self.currentSleepInfo atIndex:0];
    
}

// doneSleeping adds the completion times and explanations of troubled sleep to sleepData.
- (void)doneSleeping:(NSDate*) now : (JJISSleepExplanation*) explanations {
    if(self.currentSleepInfo.timeStart == NULL){
        self.currentSleepInfo.timeStart = now;
    }
    [self.currentSleepInfo completeSleepInfo:now : explanations];
    [self.sleepData insertObject:self.currentSleepInfo atIndex:0];
}

// setSleepTime allows the user to edit the sleep and wakeup times from the edit screen. Creates
// a SleepInfo with the associated data.
- (void)setSleepTime:(NSDate *) start : (NSDate*) end : (int) row : (BOOL) nap {
    [self.sleepData[row] createSleepInfo:start:nap];
    [self.sleepData[row] completeSleepInfo:end];
}

// return most recent SleepInfo in the sleepData array
- (JJISSleepInfo*)getCurrSleep {
    return self.sleepData[0];
}

// getNapInfo returns true if the SleepInfo object is a nap.
- (BOOL)getNapInfo:(int) index {
    JJISSleepInfo* info = [self.sleepData[index] getSleepInfo];
    return info.isNap;
}

// getNumEntries returns the number of completed SleepInfo objects in sleepData
- (int)getNumEntries {
    return [self.sleepData count];
}

// getDataMax returns the longest sleep duration in the sleepData array.
-(CGFloat) getDataMax{
    return self.max;
}

// getInfo returns an array of strings representing the start date, start time, end time, and sleep
// duration, called by SleepTableViewController
- (NSArray*)getInfo:(int) index {
    JJISSleepInfo* info = [self.sleepData[index] getSleepInfo];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"EEEE MMMM dd, yyyy"];
    NSString* startDate = [format stringFromDate:info.timeStart];
    NSString* endDate = [format stringFromDate:info.timeEnd];
    [format setDateFormat:@"hh:mm a"];
    int minutes = [info.duration intValue];
    int hours = minutes/60;
    minutes = minutes - (60*hours);
    NSString* duration = [[NSString alloc] init];
    if (minutes < 10) {
        duration = [NSString stringWithFormat:@"%d:0%d", hours, minutes];
    }
    else {
        duration = [NSString stringWithFormat:@"%d:%d", hours, minutes];
    }
    
    NSArray* infoStrings = [[NSArray alloc] init];
    NSString* nap = [[NSString alloc] init];
    if (info.isNap) {
        nap = @"Nap";
    }
    else {
        nap = @"Sleep";
    }
    
    infoStrings = @[startDate, [format stringFromDate:info.timeStart],[format stringFromDate:info.timeEnd], duration, endDate, nap];
    return infoStrings;
}

// getLastWeekNapData returns an array containing all naps.
-(NSMutableArray*) getLastWeekNapData{
    return self.napData;
}

// getLastWeekDays returns an array of sorted strings corresponding to the days of the week for the
// last seven days.
- (NSMutableArray*)getLastWeekDays:(NSDate*) today {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE"];
    NSString* stringDay = [dateFormatter stringFromDate:today];
    [self.dayData replaceObjectAtIndex:6 withObject:stringDay];
    
    NSMutableArray* days = [NSMutableArray arrayWithObjects:@"Mon", @"Tue", @"Wed", @"Thu", @"Fri", @"Sat", @"Sun", nil];
    NSInteger wherearewe = [days indexOfObject:stringDay];
    
    for(int i = 0; i < 7; i++){
        [self.dayData replaceObjectAtIndex:i withObject:[days objectAtIndex:((wherearewe + 1) % days.count)]];
        wherearewe++;
    }
    return self.dayData;
}

// getLastWeekTotals returns the total amount of sleep on each day for the last seven days.
-(NSMutableArray*) getLastWeekTotals:(NSDate*) today {
    NSNumber* zero = [[NSNumber alloc] initWithFloat:0.0];
    self.napData = [[NSMutableArray alloc] init];
    self.napData = [NSMutableArray arrayWithObjects:zero, zero, zero, zero, zero, zero, zero, nil];
    self.dayData = [[NSMutableArray alloc] init];
    self.dayData = [NSMutableArray arrayWithObjects:@"", @"", @"", @"", @"", @"", @"", nil];
    
    NSMutableArray* lastWeekDaysTotal = [[NSMutableArray alloc] init];
    lastWeekDaysTotal = [NSMutableArray arrayWithObjects:zero, zero, zero, zero, zero, zero, zero, nil];
    
    JJISSleepInfo *info;
    
    if(self.sleepData.count > 0){
        info = self.sleepData[0];
    }
    else{
        return lastWeekDaysTotal;
    }
    
    int count = 0;
    int whichDay = 0;
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE"];
    
    
    while(([self daysBetweenDate:today andDate:info.timeStart] < 8)){
        
        whichDay = 6 - [self daysBetweenDate:info.timeStart andDate:today];
        
        NSString* stringDay = [dateFormatter stringFromDate:info.timeStart];
        [self.dayData replaceObjectAtIndex:whichDay withObject:stringDay];
        
        NSNumber* currentDuration = [[NSNumber alloc] initWithFloat:[info.duration floatValue]];
        float hours = [currentDuration floatValue];
        hours = hours/60;
        currentDuration = [NSNumber numberWithFloat:hours];
        
        NSNumber* curr_sleep = [[NSNumber alloc] initWithFloat:[[lastWeekDaysTotal objectAtIndex:whichDay] floatValue]];
        
        
        curr_sleep = [NSNumber numberWithFloat:([curr_sleep floatValue] + [currentDuration floatValue])];
        
        
        [lastWeekDaysTotal replaceObjectAtIndex:whichDay withObject:curr_sleep];
        
        
        if(info.isNap){
            NSNumber* curr_nap = [[NSNumber alloc] initWithFloat:[[self.napData objectAtIndex:whichDay] floatValue]];
            
            curr_nap = [NSNumber numberWithFloat:([curr_nap floatValue] + [currentDuration floatValue])];
            
            [self.napData replaceObjectAtIndex:whichDay withObject:curr_nap];
        }
        
        
        count++;
        if(count < self.sleepData.count){
            info = self.sleepData[count];
        }
        else{
            break;
        }
    }
    
    self.max = 0;
    for(int j = 0; j < lastWeekDaysTotal.count; j++){
        CGFloat curr_sleep = [[lastWeekDaysTotal objectAtIndex:j] floatValue];
        if(curr_sleep > self.max){
            self.max = curr_sleep;
        }
    }
    
    return lastWeekDaysTotal;
    
}

// isSameData compares two NSDates, if they are the same calendar date then returns true.
-(BOOL)isSameDate:(NSDate*) date1 : (NSDate*) date2 {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    return [comp1 day] == [comp2 day] && [comp1 month] == [comp2 month] && [comp1 year] == [comp2 year];
}

// daysBetweenDate returns the number of adys between two NSDates.
- (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate
                 interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSDayCalendarUnit
                                               fromDate:fromDate toDate:toDate options:0];
    
    return [difference day];
}

// sortArray sorts the sleepData array by start times.
-(void) sortArray{
    NSSortDescriptor* sortByDate = [NSSortDescriptor sortDescriptorWithKey:@"timeStart" ascending:FALSE];
    [self.sleepData sortUsingDescriptors:[NSArray arrayWithObject:sortByDate]];
}

@end
