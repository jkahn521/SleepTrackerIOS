//
//  JJISBarGraphViewController.m
//  SleepTracker
//
//  Created by Jason Kahn on 3/11/13.
//  Copyright (c) 2013 Jason Kahn. All rights reserved.
//

#import "JJISBarGraphViewController.h"
#import "CorePlot-CocoaTouch.h"
#import "JJISAppDelegate.h"

@interface JJISBarGraphViewController ()

@property (nonatomic, strong) IBOutlet CPTGraphHostingView *hostView;
@property (nonatomic, strong) CPTBarPlot *Day;
@property (nonatomic, strong) CPTBarPlot *Nap;
@property (nonatomic, strong) CPTPlotSpaceAnnotation *dayAnnotation;
@property (nonatomic, strong) NSMutableArray* lastWeek;
@property (nonatomic, strong) NSDate* today;
@property (nonatomic, strong) NSMutableArray* xLabels;
@property (nonatomic, strong) NSMutableArray* lastWeekNaps;
@property CGFloat max;


@end

@implementation JJISBarGraphViewController

CGFloat const CPDBarWidth = 0.2f;
CGFloat const CPDBarInitialX = .025f;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initPlot];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





-(void) configureHost{
    CGRect parentRect = self.view.bounds;
    parentRect = CGRectMake(parentRect.origin.x,
                            (parentRect.origin.y),
                            parentRect.size.width,
                            (parentRect.size.height - 40));
    // 2 - Create host view
    self.hostView = [(CPTGraphHostingView *) [CPTGraphHostingView alloc] initWithFrame:parentRect];
    self.hostView.allowPinchScaling = NO;
    [self.view addSubview:self.hostView];
}

// initPlot initializes the graph and gets the sleep data from the SleepInfoManager.
-(void) initPlot{
    self.hostView.allowPinchScaling = NO;
    JJISAppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    self.today = [NSDate date];
    self.lastWeek = [appDelegate.manager getLastWeekTotals:self.today];
    
    self.xLabels = [appDelegate.manager getLastWeekDays:self.today];
    self.lastWeekNaps = [appDelegate.manager getLastWeekNapData];
    self.max = [appDelegate.manager getDataMax];
    [self configureHost];
    [self configureGraph];
    [self configurePlots];
    [self configureAxes];
}

// configureGraph sets up the graph location, the x and y ranges, and creates the axis labels.
-(void) configureGraph{
    CPTGraph *graph = [[CPTXYGraph alloc] initWithFrame:self.hostView.bounds];
    graph.plotAreaFrame.masksToBorder = NO;
    self.hostView.hostedGraph = graph;
    // 2 - Configure the graph
    [graph applyTheme:[CPTTheme themeNamed:kCPTPlainBlackTheme]];
    graph.paddingBottom = 30.0f;
    graph.paddingLeft  = 30.0f;
    graph.paddingTop    = -1.0f;
    graph.paddingRight  = -5.0f;
    // 3 - Set up styles
    CPTMutableTextStyle *titleStyle = [CPTMutableTextStyle textStyle];
    titleStyle.color = [CPTColor whiteColor];
    titleStyle.fontName = @"Helvetica-Bold";
    titleStyle.fontSize = 16.0f;
    // 4 - Set up title
    NSString *title = @"Sleep Data By Day";
    graph.title = title;
    graph.titleTextStyle = titleStyle;
    graph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
    graph.titleDisplacement = CGPointMake(0.0f, -16.0f);
    // 5 - Set up plot space
    CGFloat xMin = 0.0f;
    CGFloat xMax = 7.0f;
    CGFloat yMin = 0.0f;
    CGFloat yMax = self.max + 2.1f;  // should determine dynamically based on max price
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(xMin) length:CPTDecimalFromFloat(xMax)];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(yMin) length:CPTDecimalFromFloat(yMax)];
}

// configurePlots creates the bars within the graph based on sleep duration.
-(void) configurePlots{
    self.Day = [CPTBarPlot tubularBarPlotWithColor:[CPTColor blueColor] horizontalBars:NO];
    self.Day.identifier = @"Day";
    
    self.Nap = [CPTBarPlot tubularBarPlotWithColor:[CPTColor grayColor] horizontalBars:NO];
    self.Nap.identifier = @"Nap";

    // 2 - Set up line style
    CPTMutableLineStyle *barLineStyle = [[CPTMutableLineStyle alloc] init];
    barLineStyle.lineColor = [CPTColor lightGrayColor];
    barLineStyle.lineWidth = 0.5;
    // 3 - Add plots to graph
    CPTGraph *graph = self.hostView.hostedGraph;
    CGFloat barX = CPDBarInitialX;

    NSArray *plots = [NSArray arrayWithObjects:self.Day, self.Nap, nil];
    for (CPTBarPlot *plot in plots) {
        plot.dataSource = self;
        plot.delegate = self;
        plot.barWidth = CPTDecimalFromDouble(CPDBarWidth);
        plot.barOffset = CPTDecimalFromDouble(0.0);
        plot.lineStyle = barLineStyle;
    
        [graph addPlot:plot toPlotSpace:graph.defaultPlotSpace];
        barX += CPDBarWidth;
    }
    
}

// configureAxes determines the type of each axis, formats axis tickmarks, and adds axis labels.
-(void) configureAxes{
    CPTMutableTextStyle *axisTitleStyle = [CPTMutableTextStyle textStyle];
    axisTitleStyle.color = [CPTColor whiteColor];
    axisTitleStyle.fontName = @"Helvetica-Bold";
    axisTitleStyle.fontSize = 12.0f;
    CPTMutableLineStyle *axisLineStyle = [CPTMutableLineStyle lineStyle];
    axisLineStyle.lineWidth = 2.0f;
    axisLineStyle.lineColor = [[CPTColor whiteColor] colorWithAlphaComponent:1];
    // 2 - Get the graph's axis set
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *) self.hostView.hostedGraph.axisSet;
    // 3 - Configure the x-axis
    axisSet.xAxis.labelingPolicy = CPTAxisLabelingPolicyNone;
   // axisSet.xAxis.title = @"Days of Week (Sun - Sat)";
    axisSet.xAxis.titleTextStyle = axisTitleStyle;
    axisSet.xAxis.labelTextStyle = axisTitleStyle;
    axisSet.xAxis.titleOffset = 10.0f;
    axisSet.xAxis.axisLineStyle = axisLineStyle;
    NSMutableSet *dayLabels = [NSMutableSet setWithCapacity:self.xLabels.count];
    NSMutableSet *xLocations = [NSMutableSet setWithCapacity:self.xLabels.count];
    for(int i = 0; i < self.xLabels.count; i++){
        NSString* day = self.xLabels[i];
        CGFloat location = i;
        CPTAxisLabel *label = [[CPTAxisLabel alloc] initWithText:day textStyle:axisSet.xAxis.labelTextStyle];
        label.tickLocation = CPTDecimalFromCGFloat(location);
        label.offset = 4.0f;
        if(label){
            [dayLabels addObject:label];
            [xLocations addObject:[NSNumber numberWithFloat:location]];
        }
    }

    axisSet.xAxis.axisLabels = dayLabels;
    axisSet.xAxis.majorTickLocations = xLocations;
    // 4 - Configure the y-axis
    
    int imax = (self.max / 2) + 2;
    //NSUInteger* maximum = imax;
    NSMutableSet *YdayLabels = [[NSMutableSet alloc] init];
    NSMutableSet *yLocations = [[NSMutableSet alloc] init];
    for(int i = 0; i < imax; i++){
        //NSNumber* val = [[NSNumber alloc] initWithInt:i*2];
        CGFloat location = i * 2;
        NSString* iString = [NSString stringWithFormat:@"%d", i*2];
        //NSLog(@"day string = %@", iString);
        CPTAxisLabel *label = [[CPTAxisLabel alloc] initWithText:iString textStyle:axisSet.xAxis.labelTextStyle];
        label.tickLocation = CPTDecimalFromCGFloat(location);
        label.offset = 4.0f;
        if(label){
            [YdayLabels addObject:label];
            [yLocations addObject:[NSNumber numberWithFloat:location]];
        }
    }

    axisSet.yAxis.axisLabels = YdayLabels;
    axisSet.yAxis.majorTickLocations = yLocations;
    
    axisSet.yAxis.labelingPolicy = CPTAxisLabelingPolicyNone;
    axisSet.yAxis.title = @"Hours";
    axisSet.yAxis.titleTextStyle = axisTitleStyle;
    axisSet.yAxis.titleOffset = 15.0f;
    axisSet.yAxis.axisLineStyle = axisLineStyle;
}

// numberOfRecordsForPlotg returns the number of entries in the plot.
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot{
    return self.lastWeek.count;
}

// doubleForPlot determines the exact amount of sleep corresponding to the particular day entry.
-(double)doubleForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)idx{
    if(fieldEnum == 0){
        return (double) idx;
    }
    else if(fieldEnum == 1){
        if ([plot.identifier isEqual:self.Day.identifier]){
            NSNumber* duration = [self.lastWeek objectAtIndex:idx];
            return [duration doubleValue];
        }
        else if([plot.identifier isEqual:self.Nap.identifier]){
            NSNumber* duration = [self.lastWeekNaps objectAtIndex:idx];
            return [duration doubleValue];
        }
    }
    return idx;
    
}


@end