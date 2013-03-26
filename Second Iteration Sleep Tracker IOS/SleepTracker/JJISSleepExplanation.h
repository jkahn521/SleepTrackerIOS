//
//  JJISSleepExplanation.h
//  SleepTracker
//
//  Created by Jason Kahn on 3/24/13.
//  Copyright (c) 2013 Jason Kahn. All rights reserved.
//
//  JJISSleepExplanation retains a set of bools referring to default sleep trouble explanations for
//  user.

#import <Foundation/Foundation.h>

@interface JJISSleepExplanation : NSObject
@property BOOL exercise;
@property BOOL caffeine;
@property BOOL studying;
@property BOOL health;
@property BOOL heartSick;
@property BOOL other;
@property (strong, nonatomic) NSString* otherString;
@property (strong, nonatomic) NSString* ratingValue;

- (void) setExplanations : (BOOL) exerciseExp : (BOOL) caffeineExp : (BOOL) studyingExp : (BOOL) healthExp : (BOOL) heartsickExp : (BOOL) otherExp : (NSString*) ratingVal : (NSString*) otherS;
@end
