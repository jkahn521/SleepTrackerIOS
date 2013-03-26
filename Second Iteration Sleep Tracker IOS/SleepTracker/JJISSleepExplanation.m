//
//  JJISSleepExplanation.m
//  SleepTracker
//
//  Created by Jason Kahn on 3/24/13.
//  Copyright (c) 2013 Jason Kahn. All rights reserved.
//

#import "JJISSleepExplanation.h"

@interface JJISSleepExplanation()

@end

@implementation JJISSleepExplanation

- (id) init {
    self = [super init];
    
    if(self)
    {
        return self;
    }
    return nil;
}

// setExplanations sets the internal bools referring to troubled sleep explanations. Also retains
// the user submitted other explanation text.
- (void) setExplanations : (BOOL) exerciseExp : (BOOL) caffeineExp : (BOOL) studyingExp : (BOOL) healthExp : (BOOL) heartsickExp : (BOOL) otherExp : (NSString*) ratingVal : (NSString*) otherS {
    self.exercise = exerciseExp;
    self.caffeine = caffeineExp;
    self.studying = studyingExp;
    self.health = healthExp;
    self.heartSick = heartsickExp;
    self.other = otherExp;
    self.otherString = otherS;
    self.ratingValue = ratingVal;
}

@end


