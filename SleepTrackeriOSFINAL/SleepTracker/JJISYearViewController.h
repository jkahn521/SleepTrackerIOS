//
//  JJISYearViewController.h
//  SleepTracker
//
//  Created by Jason Kahn on 4/15/13.
//  Copyright (c) 2013 Jason Kahn. All rights reserved.
//
//  ViewController for displying the average sleep durations per month for each of the past 12 months.

#import <UIKit/UIKit.h>

@interface JJISYearViewController : UIViewController

-(void)initPlot;
-(void)configureGraph;
-(void)configurePlots;
-(void)configureAxes;

@end
