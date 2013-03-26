//
//  SleepTrackerTests.m
//  SleepTrackerTests
//
//  Created by Jason Kahn on 2/18/13.
//  Copyright (c) 2013 Jason Kahn. All rights reserved.
//

#import "SleepTrackerTests.h"
#import "JJISSleepInfo.h"
#import "JJISSleepInfoManager.h"
#import "JJISAppDelegate.h"


@implementation SleepTrackerTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}


// test the startSleeping method
- (void) testGoToSleep{
    
    NSDate *now = [NSDate date];
    
    JJISAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    [appDelegate.manager startSleeping:now:false];
    [appDelegate.manager doneSleeping:now];
    
    JJISSleepInfo* j = appDelegate.manager.getCurrSleep;
    
    STAssertEquals(now, j.timeStart, @"Checks the start time of sleeping");
}

// test the startSleeping method as a nap
- (void) testGoToSleepNAP{
    
    NSDate *now = [NSDate date];
    
    JJISAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    [appDelegate.manager startSleeping:now:true];
    [appDelegate.manager doneSleeping:now];
    
    JJISSleepInfo* j = appDelegate.manager.getCurrSleep;
    bool b = j.isNap;
    int isNap = 0;
    if(b){
        isNap = 1;
    }
    
    STAssertEquals(now, j.timeStart, @"Checks the start time of sleeping");
    STAssertEquals(true, isNap, @"Checks whether the SleepInfo is of type sleep");
}

// test the doneSleeping method
- (void) testWakeUp{
    
    NSDate *now = [NSDate date];
    
    JJISAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    [appDelegate.manager doneSleeping:now];
    
    JJISSleepInfo* j = appDelegate.manager.getCurrSleep;
    
    STAssertEquals(now, j.timeEnd, @"Checks the start time of sleeping");
}


// test the getDuration (sleepDuration) method same day
- (void) testDuration{
    
    JJISAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd HH:mm"];
    NSString* startString = @"20130225 19:45";
    NSString* endString = @"20130225 20:00";
    NSDate* startDate = [formatter dateFromString:startString];
    NSDate* endDate = [formatter dateFromString:endString];

    
    
    [appDelegate.manager startSleeping:startDate:false];
    [appDelegate.manager doneSleeping:endDate];
    
    
    JJISSleepInfo* j = appDelegate.manager.getCurrSleep;
    
    STAssertEquals(15, [j.duration integerValue], @"Checks the duration of sleep");
}

// test the getDuration (sleepDuration) method different days
- (void) testDurationToTwoDay{
    
    JJISAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd HH:mm"];
    NSString* startString = @"20130224 18:00";
    NSString* endString = @"20130225 20:00";
    NSDate* startDate = [formatter dateFromString:startString];
    NSDate* endDate = [formatter dateFromString:endString];
    
    
    
    [appDelegate.manager startSleeping:startDate:false];
    [appDelegate.manager doneSleeping:endDate];
    
    
    JJISSleepInfo* j = appDelegate.manager.getCurrSleep;
    
    STAssertEquals(1560, [j.duration integerValue], @"Checks the duration of sleep over nights (one day to the next)");
}

// test the number of entires in the sleepData Mutable Array and the durations stored
- (void) testgetLastWeek{
    
    JJISAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd HH:mm"];
    NSString* startString1 = @"20130301 20:00";
    NSString* endString1 = @"20130302 08:00";
    NSDate* startDate1 = [formatter dateFromString:startString1];
    NSDate* endDate1 = [formatter dateFromString:endString1];
    [appDelegate.manager startSleeping:startDate1:false];
    [appDelegate.manager doneSleeping:endDate1];
    
    NSString* startString2 = @"20130302 20:00";
    NSString* endString2 = @"20130303 09:00";
    NSDate* startDate2 = [formatter dateFromString:startString2];
    NSDate* endDate2 = [formatter dateFromString:endString2];
    [appDelegate.manager startSleeping:startDate2:false];
    [appDelegate.manager doneSleeping:endDate2];
    
    NSString* startString3 = @"20130303 20:00";
    NSString* endString3 = @"20130304 10:00";
    NSDate* startDate3 = [formatter dateFromString:startString3];
    NSDate* endDate3 = [formatter dateFromString:endString3];
    [appDelegate.manager startSleeping:startDate3:false];
    [appDelegate.manager doneSleeping:endDate3];
    
    NSString* startString4 = @"20130304 20:00";
    NSString* endString4 = @"20130305 11:00";
    NSDate* startDate4 = [formatter dateFromString:startString4];
    NSDate* endDate4 = [formatter dateFromString:endString4];
    [appDelegate.manager startSleeping:startDate4:false];
    [appDelegate.manager doneSleeping:endDate4];
    
    NSString* startString5 = @"20130305 20:00";
    NSString* endString5 = @"20130306 12:00";
    NSDate* startDate5 = [formatter dateFromString:startString5];
    NSDate* endDate5 = [formatter dateFromString:endString5];
    [appDelegate.manager startSleeping:startDate5:false];
    [appDelegate.manager doneSleeping:endDate5];

    NSString* startString6 = @"20130306 20:00";
    NSString* endString6 = @"20130307 13:00";
    NSDate* startDate6 = [formatter dateFromString:startString6];
    NSDate* endDate6 = [formatter dateFromString:endString6];
    [appDelegate.manager startSleeping:startDate6:false];
    [appDelegate.manager doneSleeping:endDate6];
    
    NSString* startString7 = @"20130307 20:00";
    NSString* endString7 = @"20130308 14:00";
    NSDate* startDate7 = [formatter dateFromString:startString7];
    NSDate* endDate7 = [formatter dateFromString:endString7];
    [appDelegate.manager startSleeping:startDate7:false];
    [appDelegate.manager doneSleeping:endDate7];
    
    NSString* nowString = @"20130307 14:00";
    NSDate* now = [formatter dateFromString:nowString];
    NSMutableArray *lastWeekInfo = [appDelegate.manager getLastWeekTotals:now];
    
    NSUInteger totalNumValues = lastWeekInfo.count;
    int totalNumValuesInt = totalNumValues;
    
    STAssertEquals(7, totalNumValuesInt, @"Checks number of days in lastWeekInfo array");
    
    STAssertEquals(12, [[lastWeekInfo objectAtIndex:0] intValue], @"Checks 03/01 -> 03/02 entry");
    STAssertEquals(13, [[lastWeekInfo objectAtIndex:1] intValue], @"Checks 03/02 -> 03/03 entry");
    STAssertEquals(14, [[lastWeekInfo objectAtIndex:2] intValue], @"Checks 03/03 -> 03/04 entry");
    STAssertEquals(15, [[lastWeekInfo objectAtIndex:3] intValue], @"Checks 03/04 -> 03/05 entry");
    STAssertEquals(16, [[lastWeekInfo objectAtIndex:4] intValue], @"Checks 03/05 -> 03/06 entry");
    STAssertEquals(17, [[lastWeekInfo objectAtIndex:5] intValue], @"Checks 03/06 -> 03/07 entry");
    STAssertEquals(18, [[lastWeekInfo objectAtIndex:6] intValue], @"Checks 03/07 -> 03/08 entry");
}

// test the number of entires in the sleepData Mutable Array and the day strings stored
- (void) testgetLastWeekDays{
    
    JJISAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd HH:mm"];
    NSString* startString1 = @"20130311 20:00";
    NSString* endString1 = @"20130312 08:00";
    NSDate* startDate1 = [formatter dateFromString:startString1];
    NSDate* endDate1 = [formatter dateFromString:endString1];
    [appDelegate.manager startSleeping:startDate1:false];
    [appDelegate.manager doneSleeping:endDate1];
    
    NSString* startString2 = @"20130312 20:00";
    NSString* endString2 = @"20130313 09:00";
    NSDate* startDate2 = [formatter dateFromString:startString2];
    NSDate* endDate2 = [formatter dateFromString:endString2];
    [appDelegate.manager startSleeping:startDate2:false];
    [appDelegate.manager doneSleeping:endDate2];
    
    NSString* startString3 = @"20130313 20:00";
    NSString* endString3 = @"20130314 10:00";
    NSDate* startDate3 = [formatter dateFromString:startString3];
    NSDate* endDate3 = [formatter dateFromString:endString3];
    [appDelegate.manager startSleeping:startDate3:false];
    [appDelegate.manager doneSleeping:endDate3];
    
    NSString* startString4 = @"20130314 20:00";
    NSString* endString4 = @"20130315 11:00";
    NSDate* startDate4 = [formatter dateFromString:startString4];
    NSDate* endDate4 = [formatter dateFromString:endString4];
    [appDelegate.manager startSleeping:startDate4:false];
    [appDelegate.manager doneSleeping:endDate4];
    
    NSString* startString5 = @"20130315 20:00";
    NSString* endString5 = @"20130316 12:00";
    NSDate* startDate5 = [formatter dateFromString:startString5];
    NSDate* endDate5 = [formatter dateFromString:endString5];
    [appDelegate.manager startSleeping:startDate5:false];
    [appDelegate.manager doneSleeping:endDate5];
    
    NSString* startString6 = @"20130316 20:00";
    NSString* endString6 = @"20130317 13:00";
    NSDate* startDate6 = [formatter dateFromString:startString6];
    NSDate* endDate6 = [formatter dateFromString:endString6];
    [appDelegate.manager startSleeping:startDate6:false];
    [appDelegate.manager doneSleeping:endDate6];
    
    NSString* startString7 = @"20130317 20:00";
    NSString* endString7 = @"20130318 14:00";
    NSDate* startDate7 = [formatter dateFromString:startString7];
    NSDate* endDate7 = [formatter dateFromString:endString7];
    [appDelegate.manager startSleeping:startDate7:false];
    [appDelegate.manager doneSleeping:endDate7];
    
    NSString* nowString = @"20130317 14:00";
    NSDate* now = [formatter dateFromString:nowString];
    NSMutableArray *lastWeekInfo = [appDelegate.manager getLastWeekDays:now];
    
    NSUInteger totalNumValues = lastWeekInfo.count;
    int totalNumValuesInt = totalNumValues;
    
    STAssertEquals(7, totalNumValuesInt, @"Checks number of days in lastWeekInfo array");
    STAssertEqualObjects(@"Mon", [lastWeekInfo objectAtIndex:0], @"Checks 03/11 -> 03/12 entry");
    STAssertEqualObjects(@"Tue", [lastWeekInfo objectAtIndex:1], @"Checks 03/12 -> 03/13 entry");
    STAssertEqualObjects(@"Wed", [lastWeekInfo objectAtIndex:2], @"Checks 03/13 -> 03/14 entry");
    STAssertEqualObjects(@"Thu", [lastWeekInfo objectAtIndex:3], @"Checks 03/14 -> 03/15 entry");
    STAssertEqualObjects(@"Fri", [lastWeekInfo objectAtIndex:4], @"Checks 03/15 -> 03/16 entry");
    STAssertEqualObjects(@"Sat", [lastWeekInfo objectAtIndex:5], @"Checks 03/16 -> 03/17 entry");
    STAssertEqualObjects(@"Sun", [lastWeekInfo objectAtIndex:6], @"Checks 03/17 -> 03/18 entry");
    
}

// test the setSleepTimeStart (for editing capabilities)
-(void) testsetSleepTimeStart{
    JJISAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd HH:mm"];
    NSString* startString = @"20130605 21:12";
    NSDate* startDate = [formatter dateFromString:startString];
    
    NSDate* now = [NSDate date];
    [appDelegate.manager doneSleeping:now];
    JJISSleepInfo* j = appDelegate.manager.getCurrSleep;
    STAssertEquals(now, j.timeEnd, @"Checks the start time of sleeping");

    [appDelegate.manager setSleepTime:startDate :now :0 : false];
    STAssertEquals(startDate, j.timeStart, @"Checks the start time of sleeping");
}

// test the setSleepTimeEnd (for editing capabilities)
-(void) testsetSleepTimeEnd{
    JJISAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd HH:mm"];
    NSString* endString = @"20131006 12:21";
    NSDate* endDate = [formatter dateFromString:endString];
    
    NSDate* now = [NSDate date];
    [appDelegate.manager doneSleeping:now];
    JJISSleepInfo* j = appDelegate.manager.getCurrSleep;
    STAssertEquals(now, j.timeEnd, @"Checks the start time of sleeping");
    
    [appDelegate.manager setSleepTime:now :endDate :0 : false];
    STAssertEquals(endDate, j.timeEnd, @"Checks the start time of sleeping");
}

// test the setSleepTime
-(void) testsetSleepTimeBothandCheckDuration{
    JJISAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd HH:mm"];
    NSString* startString = @"20130621 21:12";
    NSDate* startDate = [formatter dateFromString:startString];
    NSString* endString = @"20130621 23:11";
    NSDate* endDate = [formatter dateFromString:endString];
    
    NSDate* now = [NSDate date];
    [appDelegate.manager doneSleeping:now];
    JJISSleepInfo* j = appDelegate.manager.getCurrSleep;
     
    [appDelegate.manager setSleepTime:startDate :endDate :0: false];
    STAssertEquals(startDate, j.timeStart, @"Checks the start time of sleeping");
    STAssertEquals(endDate, j.timeEnd, @"Checks the start time of sleeping");
    
    STAssertEquals(119, [j.duration integerValue], @"Checks the duration of sleep");
}

// test daysBetweenDate function that should return zero (same day)
-(void) testdaysBetweenDateSameDay{
    JJISAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];

    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd HH:mm"];
    NSString* startString = @"20130621 21:12";
    NSDate* startDate = [formatter dateFromString:startString];
    NSString* endString = @"20130621 23:13";
    NSDate* endDate = [formatter dateFromString:endString];
    NSInteger dayBetweenVal = [appDelegate.manager daysBetweenDate:startDate andDate:endDate];
    
    STAssertEquals(0, dayBetweenVal, @"Checks difference between the two days");
}

// test daysBetweenDate function that should return a negative number
-(void) testdaysBetweenDateDayBefore{
    JJISAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd HH:mm"];
    NSString* startString = @"20130621 23:13";
    NSDate* today = [formatter dateFromString:startString];
    NSString* endString = @"20130620 23:13";
    NSDate* yesterday = [formatter dateFromString:endString];
    
    STAssertEquals(-1, [appDelegate.manager daysBetweenDate:today andDate:yesterday], @"Checks difference between the two days");
}

// test daysBetweenDate function that should return a positive number
-(void) testdaysBetweenDateDayAfter{
    JJISAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd HH:mm"];
    NSString* startString = @"20130621 23:13";
    NSDate* today = [formatter dateFromString:startString];
    NSString* endString = @"20130622 23:13";
    NSDate* tomorrow = [formatter dateFromString:endString];
    
    STAssertEquals(1, [appDelegate.manager daysBetweenDate:today andDate:tomorrow], @"Checks difference between the two days");
}

// test isSameData function that should return false
-(void) testisSameDateFalse{
    JJISAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd HH:mm"];
    NSString* startString = @"20130621 23:13";
    NSDate* today = [formatter dateFromString:startString];
    NSString* endString = @"20120621 23:13";
    NSDate* tomorrow = [formatter dateFromString:endString];
    bool answer = [appDelegate.manager isSameDate:today :tomorrow];
    int istrue = 1;
    if(!answer){
        istrue = 0;
    }
    
    STAssertEquals(0, istrue, @"Checks if two days are the same");
}

// test isSameData function that should return true
-(void) testisSameDateTrue{
    JJISAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd HH:mm"];
    NSString* startString = @"20130622 23:13";
    NSDate* today = [formatter dateFromString:startString];
    NSString* endString = @"20130622 23:13";
    NSDate* tomorrow = [formatter dateFromString:endString];
    bool answer = [appDelegate.manager isSameDate:today :tomorrow];
    int istrue = 1;
    if(!answer){
        istrue = 0;
    }
    
    STAssertEquals(1, istrue, @"Checks if two days are the same");
}

// tests the SleepInfoExplanations class to make sure data is set correctly and can be retreaved 
-(void) testcreateSleepInfoExplanations{
    JJISAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSDate* now = [NSDate date];
    JJISSleepExplanation* sleepExp = [[JJISSleepExplanation alloc] init];
    [sleepExp setExplanations:true :false :true :false :false :true :@"2" : @"blah"];
    [appDelegate.manager doneSleeping:now :sleepExp];
    
    JJISSleepInfo* curr_info = appDelegate.manager.getCurrSleep;
    
    JJISSleepExplanation* explanations = curr_info.explanations;
    int excersize = 0;
    int caffeine = 0;
    NSString* rating = @"3"; // default rating
    int studying = 0;
    int health = 0;
    int heartsick = 0;
    int other = 0;
    NSString* otherExpl = @"";
    
    rating = explanations.ratingValue;
    if(explanations.exercise){
        excersize = 1;
    }
    if(explanations.caffeine){
        caffeine = 1;
    }
    if(explanations.studying){
        studying = 1;
    }
    if(explanations.health){
        health = 1;
    }
    if(explanations.heartSick){
        heartsick = 0;
    }
    if(explanations.other){
        other = 1;
        otherExpl = explanations.otherString;
    }
    
    STAssertEquals(1, excersize, @"Checks if two days are the same");
    STAssertEquals(0, caffeine, @"Checks if two days are the same");
    STAssertEquals(1, studying, @"Checks if two days are the same");
    STAssertEquals(0, health, @"Checks if two days are the same");
    STAssertEquals(0, heartsick, @"Checks if two days are the same");
    STAssertEquals(1, other, @"Checks if two days are the same");
    STAssertEquals(@"blah", otherExpl, @"Checks if two days are the same");
    STAssertEquals(@"2", rating, @"Checks if two days are the same");
    
}

// checks getLastWeek function getting with only Nap entries
- (void) testgetLastWeekOnlyNaps{
    
    JJISAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd HH:mm"];
    NSString* startString1 = @"20130301 10:00";
    NSString* endString1 = @"20130301 11:00";
    NSDate* startDate1 = [formatter dateFromString:startString1];
    NSDate* endDate1 = [formatter dateFromString:endString1];
    [appDelegate.manager startSleeping:startDate1:true];
    [appDelegate.manager doneSleeping:endDate1];
    
    NSString* startString2 = @"20130302 10:00";
    NSString* endString2 = @"20130302 12:00";
    NSDate* startDate2 = [formatter dateFromString:startString2];
    NSDate* endDate2 = [formatter dateFromString:endString2];
    [appDelegate.manager startSleeping:startDate2:true];
    [appDelegate.manager doneSleeping:endDate2];

    NSString* startString3 = @"20130303 11:00";
    NSString* endString3 = @"20130303 13:00";
    NSDate* startDate3 = [formatter dateFromString:startString3];
    NSDate* endDate3 = [formatter dateFromString:endString3];
    [appDelegate.manager startSleeping:startDate3:true];
    [appDelegate.manager doneSleeping:endDate3];
    
    NSString* startString4 = @"20130304 10:00";
    NSString* endString4 = @"20130304 14:00";
    NSDate* startDate4 = [formatter dateFromString:startString4];
    NSDate* endDate4 = [formatter dateFromString:endString4];
    [appDelegate.manager startSleeping:startDate4:true];
    [appDelegate.manager doneSleeping:endDate4];
    
    NSString* startString5 = @"20130305 10:00";
    NSString* endString5 = @"20130305 15:00";
    NSDate* startDate5 = [formatter dateFromString:startString5];
    NSDate* endDate5 = [formatter dateFromString:endString5];
    [appDelegate.manager startSleeping:startDate5:true];
    [appDelegate.manager doneSleeping:endDate5];
    
    NSString* startString6 = @"20130306 10:00";
    NSString* endString6 = @"20130306 16:00";
    NSDate* startDate6 = [formatter dateFromString:startString6];
    NSDate* endDate6 = [formatter dateFromString:endString6];
    [appDelegate.manager startSleeping:startDate6:true];
    [appDelegate.manager doneSleeping:endDate6];
    
    NSString* startString7 = @"20130307 10:00";
    NSString* endString7 = @"20130307 17:00";
    NSDate* startDate7 = [formatter dateFromString:startString7];
    NSDate* endDate7 = [formatter dateFromString:endString7];
    [appDelegate.manager startSleeping:startDate7:true];
    [appDelegate.manager doneSleeping:endDate7];
    
    NSString* nowString = @"20130307 14:00";
    NSDate* now = [formatter dateFromString:nowString];
    NSMutableArray *lastWeekInfo = [appDelegate.manager getLastWeekTotals:now];
    
    NSUInteger totalNumValues = lastWeekInfo.count;
    int totalNumValuesInt = totalNumValues;
    
    STAssertEquals(7, totalNumValuesInt, @"Checks number of days in lastWeekInfo array");
    
    STAssertEquals(1, [[lastWeekInfo objectAtIndex:0] intValue], @"Checks 03/01 -> 03/02 entry");
    STAssertEquals(2, [[lastWeekInfo objectAtIndex:1] intValue], @"Checks 03/02 -> 03/03 entry");
    STAssertEquals(2, [[lastWeekInfo objectAtIndex:2] intValue], @"Checks 03/03 -> 03/04 entry");
    STAssertEquals(4, [[lastWeekInfo objectAtIndex:3] intValue], @"Checks 03/04 -> 03/05 entry");
    STAssertEquals(5, [[lastWeekInfo objectAtIndex:4] intValue], @"Checks 03/05 -> 03/06 entry");
    STAssertEquals(6, [[lastWeekInfo objectAtIndex:5] intValue], @"Checks 03/06 -> 03/07 entry");
    STAssertEquals(7, [[lastWeekInfo objectAtIndex:6] intValue], @"Checks 03/07 -> 03/08 entry");
    
    NSMutableArray* napData = [appDelegate.manager getLastWeekNapData];
    
    NSUInteger totalNapValues = napData.count;
    int totalNapValuesInt = totalNapValues;
    
    STAssertEquals(7, totalNapValuesInt, @"Checks number of days in lastWeekInfo array");
    
    STAssertEquals(1, [[napData objectAtIndex:0] intValue], @"Checks 03/01 -> 03/02 entry");
    STAssertEquals(2, [[napData objectAtIndex:1] intValue], @"Checks 03/02 -> 03/03 entry");
    STAssertEquals(2, [[napData objectAtIndex:2] intValue], @"Checks 03/03 -> 03/04 entry");
    STAssertEquals(4, [[napData objectAtIndex:3] intValue], @"Checks 03/04 -> 03/05 entry");
    STAssertEquals(5, [[napData objectAtIndex:4] intValue], @"Checks 03/05 -> 03/06 entry");
    STAssertEquals(6, [[napData objectAtIndex:5] intValue], @"Checks 03/06 -> 03/07 entry");
    STAssertEquals(7, [[napData objectAtIndex:6] intValue], @"Checks 03/07 -> 03/08 entry");

}

// checks getLastWeek function getting with only Nap entries
- (void) testgetLastWeekSleepsAndNaps{
    
    JJISAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd HH:mm"];
    NSString* startString1 = @"20110301 10:00";
    NSString* endString1 = @"20110301 12:00";
    NSDate* startDate1 = [formatter dateFromString:startString1];
    NSDate* endDate1 = [formatter dateFromString:endString1];
    [appDelegate.manager startSleeping:startDate1:true];
    [appDelegate.manager doneSleeping:endDate1];
    
    NSString* startString10 = @"20110301 21:00";
    NSString* endString10 = @"20110302 05:00";
    NSDate* startDate10 = [formatter dateFromString:startString10];
    NSDate* endDate10 = [formatter dateFromString:endString10];
    [appDelegate.manager startSleeping:startDate10:false];
    [appDelegate.manager doneSleeping:endDate10];
    
    NSString* startString2 = @"20110302 10:00";
    NSString* endString2 = @"20110302 12:00";
    NSDate* startDate2 = [formatter dateFromString:startString2];
    NSDate* endDate2 = [formatter dateFromString:endString2];
    [appDelegate.manager startSleeping:startDate2:true];
    [appDelegate.manager doneSleeping:endDate2];
    
    NSString* startString3 = @"20110303 10:00";
    NSString* endString3 = @"20110303 13:00";
    NSDate* startDate3 = [formatter dateFromString:startString3];
    NSDate* endDate3 = [formatter dateFromString:endString3];
    [appDelegate.manager startSleeping:startDate3:true];
    [appDelegate.manager doneSleeping:endDate3];
    
    NSString* startString4 = @"20110304 10:00";
    NSString* endString4 = @"20110304 14:00";
    NSDate* startDate4 = [formatter dateFromString:startString4];
    NSDate* endDate4 = [formatter dateFromString:endString4];
    [appDelegate.manager startSleeping:startDate4:true];
    [appDelegate.manager doneSleeping:endDate4];
    
    NSString* startString40 = @"20110304 23:00";
    NSString* endString40 = @"20110305 10:00";
    NSDate* startDate40 = [formatter dateFromString:startString40];
    NSDate* endDate40 = [formatter dateFromString:endString40];
    [appDelegate.manager startSleeping:startDate40:false];
    [appDelegate.manager doneSleeping:endDate40];
    
    NSString* startString5 = @"20110305 10:00";
    NSString* endString5 = @"20110305 15:00";
    NSDate* startDate5 = [formatter dateFromString:startString5];
    NSDate* endDate5 = [formatter dateFromString:endString5];
    [appDelegate.manager startSleeping:startDate5:true];
    [appDelegate.manager doneSleeping:endDate5];
    
    NSString* startString6 = @"20110306 10:00";
    NSString* endString6 = @"20110306 16:00";
    NSDate* startDate6 = [formatter dateFromString:startString6];
    NSDate* endDate6 = [formatter dateFromString:endString6];
    [appDelegate.manager startSleeping:startDate6:true];
    [appDelegate.manager doneSleeping:endDate6];
    
    NSString* startString60 = @"20110306 20:00";
    NSString* endString60 = @"20110307 04:00";
    NSDate* startDate60 = [formatter dateFromString:startString60];
    NSDate* endDate60 = [formatter dateFromString:endString60];
    [appDelegate.manager startSleeping:startDate60:false];
    [appDelegate.manager doneSleeping:endDate60];
    
    NSString* startString7 = @"20110307 10:00";
    NSString* endString7 = @"20110307 17:00";
    NSDate* startDate7 = [formatter dateFromString:startString7];
    NSDate* endDate7 = [formatter dateFromString:endString7];
    [appDelegate.manager startSleeping:startDate7:true];
    [appDelegate.manager doneSleeping:endDate7];
    
    NSString* nowString = @"20110307 14:00";
    NSDate* now = [formatter dateFromString:nowString];
    NSMutableArray *lastWeekInfo = [appDelegate.manager getLastWeekTotals:now];
    
    NSUInteger totalNumValues = lastWeekInfo.count;
    int totalNumValuesInt = totalNumValues;
    
    STAssertEquals(7, totalNumValuesInt, @"Checks number of days in lastWeekInfo array");
    
    STAssertEquals(10, [[lastWeekInfo objectAtIndex:0] intValue], @"Checks 03/01 -> 03/02 entry");
    STAssertEquals(2, [[lastWeekInfo objectAtIndex:1] intValue], @"Checks 03/02 -> 03/03 entry");
    STAssertEquals(3, [[lastWeekInfo objectAtIndex:2] intValue], @"Checks 03/03 -> 03/04 entry");
    STAssertEquals(15, [[lastWeekInfo objectAtIndex:3] intValue], @"Checks 03/04 -> 03/05 entry");
    STAssertEquals(5, [[lastWeekInfo objectAtIndex:4] intValue], @"Checks 03/05 -> 03/06 entry");
    STAssertEquals(14, [[lastWeekInfo objectAtIndex:5] intValue], @"Checks 03/06 -> 03/07 entry");
    STAssertEquals(7, [[lastWeekInfo objectAtIndex:6] intValue], @"Checks 03/07 -> 03/08 entry");
    
    NSMutableArray* napData = [appDelegate.manager getLastWeekNapData];
    
    NSUInteger totalNapValues = napData.count;
    int totalNapValuesInt = totalNapValues;
    
    STAssertEquals(7, totalNapValuesInt, @"Checks number of days in lastWeekInfo array");
    
    STAssertEquals(2, [[napData objectAtIndex:0] intValue], @"Checks 03/01 -> 03/02 entry");
    STAssertEquals(2, [[napData objectAtIndex:1] intValue], @"Checks 03/02 -> 03/03 entry");
    STAssertEquals(3, [[napData objectAtIndex:2] intValue], @"Checks 03/03 -> 03/04 entry");
    STAssertEquals(4, [[napData objectAtIndex:3] intValue], @"Checks 03/04 -> 03/05 entry");
    STAssertEquals(5, [[napData objectAtIndex:4] intValue], @"Checks 03/05 -> 03/06 entry");
    STAssertEquals(6, [[napData objectAtIndex:5] intValue], @"Checks 03/06 -> 03/07 entry");
    STAssertEquals(7, [[napData objectAtIndex:6] intValue], @"Checks 03/07 -> 03/08 entry");
    
}

// add a second nap to a specific day that already has a nap and sleep entry
- (void) testgetLastWeekTwoNapsInaDay{
    
    
    JJISAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyyMMdd HH:mm"];
    NSString* startString1 = @"20110301 14:00";
    NSString* endString1 = @"20110301 20:00";
    NSDate* startDate1 = [formatter dateFromString:startString1];
    NSDate* endDate1 = [formatter dateFromString:endString1];
    [appDelegate.manager startSleeping:startDate1:true];
    [appDelegate.manager doneSleeping:endDate1];
    
    NSString* nowString = @"20110307 14:00";
    NSDate* now = [formatter dateFromString:nowString];
    NSMutableArray *lastWeekInfo = [appDelegate.manager getLastWeekTotals:now];
    
    NSUInteger totalNumValues = lastWeekInfo.count;
    int totalNumValuesInt = totalNumValues;
    
    STAssertEquals(7, totalNumValuesInt, @"Checks number of days in lastWeekInfo array");
    
    STAssertEquals(16, [[lastWeekInfo objectAtIndex:0] intValue], @"Checks 03/01 -> 03/02 entry");
    STAssertEquals(2, [[lastWeekInfo objectAtIndex:1] intValue], @"Checks 03/02 -> 03/03 entry");
    STAssertEquals(3, [[lastWeekInfo objectAtIndex:2] intValue], @"Checks 03/03 -> 03/04 entry");
    STAssertEquals(15, [[lastWeekInfo objectAtIndex:3] intValue], @"Checks 03/04 -> 03/05 entry");
    STAssertEquals(5, [[lastWeekInfo objectAtIndex:4] intValue], @"Checks 03/05 -> 03/06 entry");
    STAssertEquals(14, [[lastWeekInfo objectAtIndex:5] intValue], @"Checks 03/06 -> 03/07 entry");
    STAssertEquals(7, [[lastWeekInfo objectAtIndex:6] intValue], @"Checks 03/07 -> 03/08 entry");
    
    NSMutableArray* napData = [appDelegate.manager getLastWeekNapData];
    
    NSUInteger totalNapValues = napData.count;
    int totalNapValuesInt = totalNapValues;
    
    STAssertEquals(7, totalNapValuesInt, @"Checks number of days in lastWeekInfo array");
    
    STAssertEquals(8, [[napData objectAtIndex:0] intValue], @"Checks 03/01 -> 03/02 entry");
    STAssertEquals(2, [[napData objectAtIndex:1] intValue], @"Checks 03/02 -> 03/03 entry");
    STAssertEquals(3, [[napData objectAtIndex:2] intValue], @"Checks 03/03 -> 03/04 entry");
    STAssertEquals(4, [[napData objectAtIndex:3] intValue], @"Checks 03/04 -> 03/05 entry");
    STAssertEquals(5, [[napData objectAtIndex:4] intValue], @"Checks 03/05 -> 03/06 entry");
    STAssertEquals(6, [[napData objectAtIndex:5] intValue], @"Checks 03/06 -> 03/07 entry");
    STAssertEquals(7, [[napData objectAtIndex:6] intValue], @"Checks 03/07 -> 03/08 entry");
    
     
}

// test the number of entires in the sleepData Mutable Array and the day strings stored when only naps are recorded
- (void) testgetLastWeekDaysOnlyNaps{
    
    JJISAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd HH:mm"];
    NSString* startString1 = @"20130511 20:00";
    NSString* endString1 = @"20130512 08:00";
    NSDate* startDate1 = [formatter dateFromString:startString1];
    NSDate* endDate1 = [formatter dateFromString:endString1];
    [appDelegate.manager startSleeping:startDate1:true];
    [appDelegate.manager doneSleeping:endDate1];
    
    NSString* startString2 = @"20130512 20:00";
    NSString* endString2 = @"20130513 09:00";
    NSDate* startDate2 = [formatter dateFromString:startString2];
    NSDate* endDate2 = [formatter dateFromString:endString2];
    [appDelegate.manager startSleeping:startDate2:true];
    [appDelegate.manager doneSleeping:endDate2];
    
    NSString* startString3 = @"20130513 20:00";
    NSString* endString3 = @"20130514 10:00";
    NSDate* startDate3 = [formatter dateFromString:startString3];
    NSDate* endDate3 = [formatter dateFromString:endString3];
    [appDelegate.manager startSleeping:startDate3:true];
    [appDelegate.manager doneSleeping:endDate3];
    
    NSString* startString4 = @"20130514 20:00";
    NSString* endString4 = @"20130515 11:00";
    NSDate* startDate4 = [formatter dateFromString:startString4];
    NSDate* endDate4 = [formatter dateFromString:endString4];
    [appDelegate.manager startSleeping:startDate4:true];
    [appDelegate.manager doneSleeping:endDate4];
    
    NSString* startString5 = @"20130515 20:00";
    NSString* endString5 = @"20130516 12:00";
    NSDate* startDate5 = [formatter dateFromString:startString5];
    NSDate* endDate5 = [formatter dateFromString:endString5];
    [appDelegate.manager startSleeping:startDate5:true];
    [appDelegate.manager doneSleeping:endDate5];
    
    NSString* startString6 = @"20130516 20:00";
    NSString* endString6 = @"20130517 13:00";
    NSDate* startDate6 = [formatter dateFromString:startString6];
    NSDate* endDate6 = [formatter dateFromString:endString6];
    [appDelegate.manager startSleeping:startDate6:true];
    [appDelegate.manager doneSleeping:endDate6];
    
    NSString* startString7 = @"20130517 20:00";
    NSString* endString7 = @"20130518 14:00";
    NSDate* startDate7 = [formatter dateFromString:startString7];
    NSDate* endDate7 = [formatter dateFromString:endString7];
    [appDelegate.manager startSleeping:startDate7:true];
    [appDelegate.manager doneSleeping:endDate7];
    
    NSString* nowString = @"20130517 14:00";
    NSDate* now = [formatter dateFromString:nowString];
    NSMutableArray *lastWeekInfo = [appDelegate.manager getLastWeekDays:now];
    
    NSUInteger totalNumValues = lastWeekInfo.count;
    int totalNumValuesInt = totalNumValues;
    
    STAssertEquals(7, totalNumValuesInt, @"Checks number of days in lastWeekInfo array");
    STAssertEqualObjects(@"Sat", [lastWeekInfo objectAtIndex:0], @"Checks 05/11 -> 05/12 entry");
    STAssertEqualObjects(@"Sun", [lastWeekInfo objectAtIndex:1], @"Checks 05/12 -> 05/13 entry");
    STAssertEqualObjects(@"Mon", [lastWeekInfo objectAtIndex:2], @"Checks 05/13 -> 05/14 entry");
    STAssertEqualObjects(@"Tue", [lastWeekInfo objectAtIndex:3], @"Checks 05/14 -> 05/15 entry");
    STAssertEqualObjects(@"Wed", [lastWeekInfo objectAtIndex:4], @"Checks 05/15 -> 05/16 entry");
    STAssertEqualObjects(@"Thu", [lastWeekInfo objectAtIndex:5], @"Checks 05/16 -> 05/17 entry");
    STAssertEqualObjects(@"Fri", [lastWeekInfo objectAtIndex:6], @"Checks 05/17 -> 05/18 entry");
    
}

// test negative duration - app doesnt crash. but impossible to have because of restrictions on edit screen with wheel
- (void) testNegativeDuration{
    
    JJISAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd HH:mm"];
    NSString* startString1 = @"20130325 10:00";
    NSString* endString1 = @"20130325 04:00";
    NSDate* startDate1 = [formatter dateFromString:startString1];
    NSDate* endDate1 = [formatter dateFromString:endString1];
    [appDelegate.manager startSleeping:startDate1:true];
    [appDelegate.manager doneSleeping:endDate1];
    
    JJISSleepInfo* most_rec = [appDelegate.manager getCurrSleep];
    NSNumber* sleep_dur = most_rec.duration;
    int sleep_dur_int = [sleep_dur integerValue];
    STAssertEquals(-360, sleep_dur_int, @"Checks negative durations");

}

@end
