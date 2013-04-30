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
- (void) setExplanations : (BOOL) caffeine : (BOOL) alcohol : (BOOL) nicotine : (BOOL) sugar : (BOOL) screentime : (BOOL) exercise :  (NSNumber*) ratingVal {
    self.alcohol = alcohol;
    self.exercise = exercise;
    self.caffeine = caffeine;
    self.nicotine = nicotine;
    self.screentime = screentime;
    self.sugar = sugar;
    self.ratingValue = ratingVal;
}

// encodeWithCoder sets the encoding for JJISSleepExplanations in plist save file.
- (void) encodeWithCoder: (NSCoder *)coder
{
    [coder encodeObject: [NSNumber numberWithBool:self.exercise] forKey:@"exercise"];
    [coder encodeObject: [NSNumber numberWithBool:self.caffeine] forKey:@"caffeine"];
    [coder encodeObject: [NSNumber numberWithBool:self.nicotine] forKey:@"nicotine"];
    [coder encodeObject: [NSNumber numberWithBool:self.sugar] forKey:@"sugar"];
    [coder encodeObject: [NSNumber numberWithBool:self.alcohol] forKey:@"alcohol"];
    [coder encodeObject: [NSNumber numberWithBool:self.screentime] forKey:@"screens"];
    [coder encodeObject: self.ratingValue forKey:@"ratingValue"];
}

// initWithCoder sets the decoding when the user data is read from the plist file.
- (id) initWithCoder: (NSCoder *)coder
{
    if (self = [super init])
    {
        self.exercise = [[coder decodeObjectForKey:@"exercise"] boolValue];
        self.caffeine = [[coder decodeObjectForKey:@"caffeine"] boolValue];
        self.nicotine = [[coder decodeObjectForKey:@"nicotine"] boolValue];
        self.sugar = [[coder decodeObjectForKey:@"sugar"] boolValue];
        self.alcohol = [[coder decodeObjectForKey:@"alcohol"] boolValue];
        self.screentime = [[coder decodeObjectForKey:@"screens"] boolValue];
        self.ratingValue = [coder decodeObjectForKey:@"ratingValue"];
    }
    return self;
}


@end


