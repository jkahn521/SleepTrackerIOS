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

@interface JJISSleepExplanation : NSObject <NSCoding>
@property BOOL alcohol;
@property BOOL caffeine;
@property BOOL nicotine;
@property BOOL exercise;
@property BOOL screentime;
@property BOOL sugar;
@property (strong, nonatomic) NSNumber* ratingValue;

- (void) setExplanations : (BOOL) caffeine : (BOOL) alcohol : (BOOL) nicotine : (BOOL) sugar : (BOOL) screentime : (BOOL) exercise :  (NSNumber*) ratingVal;
@end
