//
//  JJISSleepQualityViewController.h
//  SleepTracker
//
//  Created by Ian Moulton on 4/3/13.
//  Copyright (c) 2013 Jason Kahn. All rights reserved.
//
//  ViewController for seeing the average sleep quality and average sleep length given common problems experienced while sleeping.

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"

@interface JJISSleepQualityViewController : UIViewController <CPTBarPlotDataSource, CPTBarPlotDelegate>

-(void)initPlot;
-(void)configureGraph;
-(void)configurePlots;
-(void)configureAxes;


@end
