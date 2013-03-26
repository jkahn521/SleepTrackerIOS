//
//  JJISBarGraphViewController.h
//  SleepTracker
//
//  Created by Jason Kahn on 3/11/13.
//  Copyright (c) 2013 Jason Kahn. All rights reserved.
//
//  BarGraphViewController visualizes the user's sleep duration. Using the CorePlot framework
//  data is graphed for the last seven days including sleep and naps.

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"

@interface JJISBarGraphViewController : UIViewController <CPTBarPlotDataSource, CPTBarPlotDelegate>

-(void)initPlot;
-(void)configureGraph;
-(void)configurePlots;
-(void)configureAxes;

@end
