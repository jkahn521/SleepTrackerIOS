//
//  JJISSleepinfoManager.m
//  SleepTracker
//
//  Created by Jason Kahn on 2/22/13.
//  Copyright (c) 2013 Jason Kahn. All rights reserved.
//

#import "JJISSleepInfoManager.h"
#import "JJISSleepInfo.h"
#import "JJISAppDelegate.h"

@interface JJISSleepInfoManager ()
@property (strong, nonatomic) NSMutableArray *sleepData;
@property (strong, nonatomic) JJISSleepInfo *currentSleepInfo;
@property (strong, nonatomic) NSMutableArray *napData;
@property (strong, nonatomic) NSMutableArray *dayData;
@property (strong, nonatomic) NSMutableArray *monthData;
@property (strong, nonatomic) NSMutableArray *ratingAverages;
@property (strong, nonatomic) NSMutableArray *sleepAverages;
@property (strong, nonatomic) NSMutableArray *lastNumDayTotals;
@property (strong, nonatomic) NSMutableArray *lastYearInfo;
@property (strong, nonatomic) NSMutableArray *countByMonth;
@property (strong, nonatomic) NSString* isSleeping;


@property CGFloat max;
@property CGFloat yearMax;
@end

@implementation JJISSleepInfoManager

// init initializes the SleepInfoManager with an empty sleepData array and currentSleepInfo
- (id) init {
    self = [super init];
    self.sleepData = [[NSMutableArray alloc] init];
    self.currentSleepInfo = [[JJISSleepInfo alloc] init];
    self.lastNumDayTotals = [[NSMutableArray alloc] init];
    self.dayData = [[NSMutableArray alloc] init];
    self.monthData = [[NSMutableArray alloc] init];
    self.napData = [[NSMutableArray alloc] init];
    self.lastYearInfo = [[NSMutableArray alloc] init];
    
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
    self.isSleeping = @"Sleeping";
    

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
    self.isSleeping = @"Awake";
}

// setSleepingStatus sets the current user status based on the passed NSString.
-(void)setSleepingStatus:(NSString*) status {
  //  NSLog(@"status is %@", status);
    self.isSleeping = status;
}

// sleepingStatus returns a string referring to the current user state: sleeping/awake.
-(NSString*)sleepingStatus {
    return self.isSleeping;
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

// getCurrentSleepinfo returns the currentSleepInfo entry.
-(JJISSleepInfo*)getCurrentSleepInfo {
    return self.currentSleepInfo;
}

// setInfo sets the JJISSleepInfo current sleep entry to the passed SleepInfo, used when loading from the saved plist.
-(void)setInfo:(JJISSleepInfo *)currSleepInfo {
    self.currentSleepInfo.timeStart = currSleepInfo.timeStart;
    self.currentSleepInfo.isNap = currSleepInfo.isNap;
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

// getYearMax returns the longest sleep duration average for the months of the past year
-(CGFloat) getYearMax{
    return self.yearMax;
}

// getAllSleepInfo returns the sleepData array
-(NSMutableArray*) getAllSleepInfo{
    return self.sleepData;
}

// getInfo returns an array of strings representing the start date, start time, end time, sleep
// duration, and whether the SleepInfo is a nap/sleep. These strings are displayed by the DetailViewController and TableViewController so that the user may see what the specific data associated with a day's sleep is. 
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
-(NSMutableArray*)getLastWeekNapData{
    return self.napData;
}

// getDayNames returns an array of sorted strings corresponding to the days of the week for the
// last seven days.
- (NSMutableArray*)getDayNames:(NSDate*) today : (BOOL) longName {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    if(longName){
        [dateFormatter setDateFormat:@"EEE"];
    }
    if(!longName){
        [dateFormatter setDateFormat:@"EEEEE"];
    }
    NSString* stringDay = [dateFormatter stringFromDate:today];
    [self.dayData replaceObjectAtIndex:6 withObject:stringDay];
    NSMutableArray* days = [[NSMutableArray alloc] init];
    
    days = [NSMutableArray arrayWithObjects:@"Mon", @"Tue", @"Wed", @"Thu", @"Fri", @"Sat", @"Sun", nil];
    
    if(!longName){
    days = [NSMutableArray arrayWithObjects:@"M", @"T", @"W", @"T", @"F", @"S", @"S", nil];
    }
    
    NSInteger currentIndex = [days indexOfObject:stringDay];
    
    if(longName){
        for(int i = 0; i < 7; i++){
            [self.dayData replaceObjectAtIndex:i withObject:[days objectAtIndex:((currentIndex + 1) % days.count)]];
            currentIndex++;
        }
    }
    if(!longName){
        for(int i = 0; i < 30; i++){
            [self.dayData replaceObjectAtIndex:i withObject:[days objectAtIndex:((currentIndex - 1) % days.count)]];
        currentIndex++;
        }
    }
    return self.dayData;
}

// getMonthNames returns an array of the last twelve month names as strings
- (NSMutableArray*)getMonthNames:(NSDate*) today {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"MMM"];
    for(int i = 0; i < 12; i++){
        [self.monthData addObject:@""];
    }

    NSString* stringMonth = [dateFormatter stringFromDate:today];
    [self.monthData replaceObjectAtIndex:11 withObject:stringMonth];
    NSMutableArray* months = [[NSMutableArray alloc] init];
    
    months = [NSMutableArray arrayWithObjects:@"Jan", @"Feb", @"Mar", @"Apr", @"May", @"Jun", @"Jul", @"Aug", @"Sep", @"Oct", @"Nov", @"Dec", nil];

    
    NSInteger currentIndex = [months indexOfObject:stringMonth];
  
    for(int i = 0; i < 12; i++){
        [self.monthData replaceObjectAtIndex:i withObject:[months objectAtIndex:((currentIndex + 1) % months.count)]];
        currentIndex++;
    }   

    return self.monthData;
}

// setAllSleepInfo sets the sleepData array to the passed array. Called when loading from the plist
-(void) setAllSleepInfo:(NSMutableArray*) newSleepData{
    self.sleepData = newSleepData;
}

// getLastWeekTotals returns the total amount of sleep on each day for the last seven days.
- (NSMutableArray*) getLastNumDayTotals : (NSDate*) today : (int) numDays {
    self.lastNumDayTotals = [[NSMutableArray alloc] init];
    self.dayData = [[NSMutableArray alloc] init];
    self.napData = [[NSMutableArray alloc] init];
    NSNumber* zero = [[NSNumber alloc] initWithFloat:0.0];
    NSString* emptyString = @"";

    for(int i = 0; i < numDays; i++){
        [self.napData addObject:zero];
        [self.lastNumDayTotals addObject:zero];
        [self.dayData addObject:emptyString];
    }


    JJISSleepInfo *info;
    
    // get the first data entry in the array
    if(self.sleepData.count > 0){
        info = self.sleepData[0];
    }
    else{
        return self.lastNumDayTotals;
    }
    
    int count = 0;
    int whichDay = 0;
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE"];
    // start while loop to capture all days in array that are within a week of the inputted day
    while(([self daysBetweenDate:today andDate:info.timeStart] < numDays + 1)){

        // must be within 1 week
        whichDay = (numDays - 1) - [self daysBetweenDate:info.timeStart andDate:today];
        
        if(whichDay < 0){
            break;
        }
        
        // update the day of the week
        NSString* stringDay = [dateFormatter stringFromDate:info.timeStart];
        [self.dayData replaceObjectAtIndex:whichDay withObject:stringDay];
        
        // get the current duration and update to arrya for total sleep
        NSNumber* currentDuration = [[NSNumber alloc] initWithFloat:[info.duration floatValue]];
        float hours = [currentDuration floatValue];
        hours = hours/60;
        currentDuration = [NSNumber numberWithFloat:hours];
        
        NSNumber* curr_sleep = [[NSNumber alloc] initWithFloat:[[self.lastNumDayTotals objectAtIndex:whichDay] floatValue]];
        curr_sleep = [NSNumber numberWithFloat:([curr_sleep floatValue] + [currentDuration floatValue])];
        [self.lastNumDayTotals replaceObjectAtIndex:whichDay withObject:curr_sleep];
        
        // if its a nap, update the Nap data as well
        if(info.isNap){
            NSNumber* curr_nap = [[NSNumber alloc] initWithFloat:[[self.napData objectAtIndex:whichDay] floatValue]];
            curr_nap = [NSNumber numberWithFloat:([curr_nap floatValue] + [currentDuration floatValue])];
            [self.napData replaceObjectAtIndex:whichDay withObject:curr_nap];
        }
        
        // update the info
        count++;
        if(count < self.sleepData.count){
            info = self.sleepData[count];
        }
        else{
            break;
        }
    }
    
    self.max = 0;
    for(int j = 0; j < self.lastNumDayTotals.count; j++){
        CGFloat curr_sleep = [[self.lastNumDayTotals objectAtIndex:j] floatValue];
        if(curr_sleep > self.max){
            self.max = curr_sleep;
        }
    }
    
    return self.lastNumDayTotals;
    
}

// getLastYearInfo returns an array of the average sleep durations for each of the past 12 months.
-(NSMutableArray*) getLastYearInfo:(NSDate*) today{
    self.lastYearInfo = [[NSMutableArray alloc] init];
    NSNumber* zero = [[NSNumber alloc] initWithFloat:0.0];
    self.countByMonth = [[NSMutableArray alloc] init];
    for(int i = 0; i < 12; i++){
        [self.lastYearInfo addObject:zero];
        [self.countByMonth addObject:zero];
    }
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:today];
    NSInteger todayMonth = [components month];
    
    
    for (int i = 0; i < self.sleepData.count; i++){
        JJISSleepInfo* currentInfo = [self.sleepData objectAtIndex:i];
        if(currentInfo.isNap){
            continue;
        }
        NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:currentInfo.timeStart];
        NSInteger currMonth = [components month];
        
        currMonth = 11 - (todayMonth - currMonth);
        if(currMonth > 11){
            currMonth = (currMonth) % 12;
        }
        
     //   NSLog(@"currMonth at %i is %i", i, currMonth);
        
        if(currMonth > 12){
            break;
        }
        
        float currTotal = [[self.lastYearInfo objectAtIndex:(currMonth)] floatValue];
        float hours = [currentInfo.duration floatValue];
        hours = hours/60;
        float newTotal = currTotal + hours;
        NSNumber* newDuration = [NSNumber numberWithFloat:newTotal];

        [self.lastYearInfo replaceObjectAtIndex:(currMonth) withObject:newDuration];
        
        int currCount = [[self.countByMonth objectAtIndex:currMonth] integerValue];
        currCount++;
         NSNumber* newCount = [NSNumber numberWithInt:currCount];
     //   NSLog(@"count for %i is %i", currMonth, currCount);
        [self.countByMonth replaceObjectAtIndex:currMonth withObject:(NSNumber*) newCount];
    }
    
    for (int i = 0; i < 12; i++) {
        NSNumber* currentTotal = [self.lastYearInfo objectAtIndex:i];
        NSNumber* count = [self.countByMonth objectAtIndex:i];
        if(count == 0){
            continue;
        }
        NSNumber* ratingAverage = [NSNumber numberWithFloat:([currentTotal floatValue] / [count floatValue])];
        [self.lastYearInfo replaceObjectAtIndex:i withObject:ratingAverage];
    }
    
    self.yearMax = 0;
    for(int j = 0; j < self.lastYearInfo.count; j++){
        CGFloat curr_dur = [[self.lastYearInfo objectAtIndex:j] floatValue];
        if(curr_dur > self.yearMax){
            self.yearMax = curr_dur;
        }
    }
    
 //   NSLog(@"YEARMAX: %f", self.yearMax);
    for(int k = 0; k < self.lastYearInfo.count; k++){
  //      NSLog(@"Val for %i is %@", k, [self.lastYearInfo objectAtIndex:k]);
    }
    return self.lastYearInfo;
    
}


// calculateSleepRatings updates the ratingAverages array to reflect the average sleep quality given a particular sleep issue. These numbers are given to the SleepQualityViewController to be displayed as a bar graph.
-(void) calculateSleepRatings{
    
    // initialize the arrays
    NSNumber* zero = [[NSNumber alloc] initWithFloat:0.0];
    self.ratingAverages = [[NSMutableArray alloc] init];
    self.ratingAverages = [NSMutableArray arrayWithObjects:zero, zero, zero, zero, zero, zero, zero, nil];
    self.sleepAverages = [[NSMutableArray alloc] init];
    self.sleepAverages = [NSMutableArray arrayWithObjects:zero, zero, zero, zero, zero, zero, zero, nil];
    NSMutableArray* ratingSum = [[NSMutableArray alloc] init];
    ratingSum = [NSMutableArray arrayWithObjects:zero, zero, zero, zero, zero, zero, zero, nil];
    NSMutableArray* ratingCount = [[NSMutableArray alloc] init];
    ratingCount = [NSMutableArray arrayWithObjects:zero, zero, zero, zero, zero, zero, zero, nil];
    NSMutableArray* sleepSum = [[NSMutableArray alloc] init];
    sleepSum = [NSMutableArray arrayWithObjects:zero, zero, zero, zero, zero, zero, zero, nil];

    // loop through all sleep entries
    for (int i = 0; i < self.sleepData.count; i++) {
        JJISSleepInfo* currentInfo = [self.sleepData objectAtIndex:i];
        if(currentInfo.isNap){
            continue;
        }
        if (currentInfo.explanations.alcohol) {
            NSNumber* newQualitySum = [NSNumber numberWithInt:([currentInfo.explanations.ratingValue integerValue] + [[ratingSum objectAtIndex:0] integerValue])];
            [ratingSum replaceObjectAtIndex:0 withObject:newQualitySum];
            NSNumber *newCount = [NSNumber numberWithInt:([[ratingCount objectAtIndex:0] integerValue] + 1)];
            [ratingCount replaceObjectAtIndex:0 withObject:newCount];
            NSNumber *newSleepSum = [NSNumber numberWithFloat:([currentInfo.duration floatValue] + [[sleepSum objectAtIndex:0] floatValue])];
            [sleepSum replaceObjectAtIndex:0 withObject:newSleepSum];
        }
        if (currentInfo.explanations.caffeine) {
            NSNumber* newQualitySum = [NSNumber numberWithInt:([currentInfo.explanations.ratingValue integerValue] + [[ratingSum objectAtIndex:1] integerValue])];
            [ratingSum replaceObjectAtIndex:1 withObject:newQualitySum];
            NSNumber *newCount = [NSNumber numberWithInt:([[ratingCount objectAtIndex:1] integerValue] + 1)];
            [ratingCount replaceObjectAtIndex:1 withObject:newCount];
            NSNumber *newSleepSum = [NSNumber numberWithFloat:([currentInfo.duration floatValue] + [[sleepSum objectAtIndex:1] floatValue])];
            [sleepSum replaceObjectAtIndex:1 withObject:newSleepSum];
        }
        if (currentInfo.explanations.nicotine) {
            NSNumber* newQualitySum = [NSNumber numberWithInt:([currentInfo.explanations.ratingValue integerValue] + [[ratingSum objectAtIndex:2] integerValue])];
            [ratingSum replaceObjectAtIndex:2 withObject:newQualitySum];
            NSNumber *newCount = [NSNumber numberWithInt:([[ratingCount objectAtIndex:2] integerValue] + 1)];
            [ratingCount replaceObjectAtIndex:2 withObject:newCount];
            NSNumber *newSleepSum = [NSNumber numberWithFloat:([currentInfo.duration floatValue] + [[sleepSum objectAtIndex:2] floatValue])];
            [sleepSum replaceObjectAtIndex:2 withObject:newSleepSum];
        }
        if (currentInfo.explanations.exercise) {
            NSNumber* newQualitySum = [NSNumber numberWithInt:([currentInfo.explanations.ratingValue integerValue] + [[ratingSum objectAtIndex:3] integerValue])];
            [ratingSum replaceObjectAtIndex:3 withObject:newQualitySum];
            NSNumber *newCount = [NSNumber numberWithInt:([[ratingCount objectAtIndex:3] integerValue] + 1)];
            [ratingCount replaceObjectAtIndex:3 withObject:newCount];
            NSNumber *newSleepSum = [NSNumber numberWithFloat:([currentInfo.duration floatValue] + [[sleepSum objectAtIndex:3] floatValue])];
            [sleepSum replaceObjectAtIndex:3 withObject:newSleepSum];
        }
        if (currentInfo.explanations.screentime) {
            NSNumber* newQualitySum = [NSNumber numberWithInt:([currentInfo.explanations.ratingValue integerValue] + [[ratingSum objectAtIndex:4] integerValue])];
            [ratingSum replaceObjectAtIndex:4 withObject:newQualitySum];
            NSNumber *newCount = [NSNumber numberWithInt:([[ratingCount objectAtIndex:4] integerValue] + 1)];
            [ratingCount replaceObjectAtIndex:4 withObject:newCount];
            NSNumber *newSleepSum = [NSNumber numberWithFloat:([currentInfo.duration floatValue] + [[sleepSum objectAtIndex:4] floatValue])];
            [sleepSum replaceObjectAtIndex:4 withObject:newSleepSum];
        }
        if (currentInfo.explanations.sugar) {
            NSNumber* newQualitySum = [NSNumber numberWithInt:([currentInfo.explanations.ratingValue integerValue] + [[ratingSum objectAtIndex:5] integerValue])];
            [ratingSum replaceObjectAtIndex:5 withObject:newQualitySum];
            NSNumber *newCount = [NSNumber numberWithInt:([[ratingCount objectAtIndex:5] integerValue] + 1)];
            [ratingCount replaceObjectAtIndex:5 withObject:newCount];
            NSNumber *newSleepSum = [NSNumber numberWithFloat:([currentInfo.duration floatValue] + [[sleepSum objectAtIndex:5] floatValue])];
            [sleepSum replaceObjectAtIndex:5 withObject:newSleepSum];
        }
        
        if (!currentInfo.explanations.sugar && !currentInfo.explanations.screentime && !currentInfo.explanations.exercise && !currentInfo.explanations.nicotine && !currentInfo.explanations.caffeine && !currentInfo.explanations.alcohol) {
      //      NSLog(@"Hello");
            NSNumber* newQualitySum = [NSNumber numberWithInt:([currentInfo.explanations.ratingValue integerValue] + [[ratingSum objectAtIndex:6] integerValue])];
            [ratingSum replaceObjectAtIndex:6 withObject:newQualitySum];
            NSNumber *newCount = [NSNumber numberWithInt:([[ratingCount objectAtIndex:6] integerValue] + 1)];
            [ratingCount replaceObjectAtIndex:6 withObject:newCount];
            NSNumber *newSleepSum = [NSNumber numberWithFloat:([currentInfo.duration floatValue] + [[sleepSum objectAtIndex:6] floatValue])];
            [sleepSum replaceObjectAtIndex:6 withObject:newSleepSum];
        }
        
    }
    for (int i = 0; i < 7; i++) {
        NSNumber* currentRatingSum = [ratingSum objectAtIndex:i];
        NSNumber* count = [ratingCount objectAtIndex:i];
        NSNumber* ratingAverage = [NSNumber numberWithFloat:([currentRatingSum floatValue] / [count floatValue])];
        [self.ratingAverages replaceObjectAtIndex:i withObject:ratingAverage];
        NSNumber* currentSleepSum = [sleepSum objectAtIndex:i];
        NSNumber* sleepAverage = [NSNumber numberWithFloat:([currentSleepSum floatValue] / [count floatValue])];
        [self.sleepAverages replaceObjectAtIndex:i withObject:sleepAverage];
    }
    
}

// getSleepAverages returns the average sleep durations for each of the past 12 months
- (NSMutableArray*) getSleepAverages{
    return self.sleepAverages;
}

// getRatingAverages returns the average ratings for each of the default sleep problems
- (NSMutableArray*) getRatingAverages{
    
    return self.ratingAverages;
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
- (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime{
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
