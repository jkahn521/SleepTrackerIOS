//
//  JJISViewController30Days.h
//  SleepTracker
//
//  Created by Jason Kahn on 4/15/13.
//  Copyright (c) 2013 Jason Kahn. All rights reserved.
//
//  ViewController for displaying a bar graph detailing the sleep durations for each of the past 30 days.

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"


@interface JJISViewController30Days : UIViewController <CPTBarPlotDataSource, CPTBarPlotDelegate>

-(void)initPlot;
-(void)configureGraph;
-(void)configurePlots;
-(void)configureAxes;

@end
