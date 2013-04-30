//
//  JJISSleepQualityViewController.m
//  SleepTracker
//
//  Created by Ian Moulton on 4/3/13.
//  Copyright (c) 2013 Jason Kahn. All rights reserved.
//

#import "JJISSleepQualityViewController.h"
#import "CorePlot-CocoaTouch.h"
#import "JJISAppDelegate.h"

@interface JJISSleepQualityViewController()

@property (nonatomic, strong) IBOutlet CPTGraphHostingView *hostView;
@property (nonatomic, strong) CPTBarPlot *Quality;
@property (nonatomic, strong) NSMutableArray* sleepRatings;
@property (nonatomic, strong) NSMutableArray* sleepAverages;
@property (nonatomic, strong) CPTPlotSpaceAnnotation *sleepAvgAnnotation;

@end

@implementation JJISSleepQualityViewController

CGFloat const CPDBarWidthQ = 0.15f;
CGFloat const CPDBarInitialXQ = .025f;


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
    [appDelegate.manager calculateSleepRatings];
    self.sleepRatings = [appDelegate.manager getRatingAverages];
    self.sleepAverages = [appDelegate.manager getSleepAverages];
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
    NSString *title = @"Sleep Data By Issue";
    graph.title = title;
    graph.titleTextStyle = titleStyle;
    graph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
    graph.titleDisplacement = CGPointMake(0.0f, -16.0f);
    // 5 - Set up plot space
    CGFloat xMin = 0.0f;
    CGFloat xMax = 7.0f;
    CGFloat yMin = 0.0f;
    CGFloat yMax = 6.0f;  // should determine dynamically based on max price
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(xMin) length:CPTDecimalFromFloat(xMax)];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(yMin) length:CPTDecimalFromFloat(yMax)];
}

// configurePlots creates the bars within the graph based on sleep quality.
-(void) configurePlots{
    self.Quality = [CPTBarPlot tubularBarPlotWithColor:[CPTColor blueColor] horizontalBars:NO];
    
    // 2 - Set up line style
    CPTMutableLineStyle *barLineStyle = [[CPTMutableLineStyle alloc] init];
    barLineStyle.lineColor = [CPTColor blueColor];
    barLineStyle.lineWidth = 0.5;
    // 3 - Add plots to graph
    CPTGraph *graph = self.hostView.hostedGraph;
    CGFloat barX = CPDBarInitialXQ;
    
    NSArray *plots = [NSArray arrayWithObjects:self.Quality, nil];
    for (CPTBarPlot *plot in plots) {
        plot.dataSource = self;
        plot.delegate = self;
        plot.barWidth = CPTDecimalFromDouble(CPDBarWidthQ);
        plot.barOffset = CPTDecimalFromDouble(0.0);
        plot.lineStyle = barLineStyle;
        
        [graph addPlot:plot toPlotSpace:graph.defaultPlotSpace];
        barX += CPDBarWidthQ;
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
    axisSet.xAxis.titleTextStyle = axisTitleStyle;
    axisSet.xAxis.labelTextStyle = axisTitleStyle;
    axisSet.xAxis.titleOffset = 10.0f;
    axisSet.xAxis.axisLineStyle = axisLineStyle;
    
   
    NSMutableArray* issueNames = [NSMutableArray arrayWithObjects:@"Alc", @"Caff", @"Nic", @"Exe", @"Scr", @"Sug", @"None", nil];
    NSMutableSet *issueLabels = [NSMutableSet setWithCapacity:issueNames.count];
    NSMutableSet *xLocations = [NSMutableSet setWithCapacity:issueNames.count];
    for(int i = 0; i < issueNames.count; i++){
        CGFloat location = i;
        NSString* issue = issueNames[i];
        CPTAxisLabel *label = [[CPTAxisLabel alloc] initWithText:issue textStyle:axisSet.xAxis.labelTextStyle];
        label.tickLocation = CPTDecimalFromCGFloat(location);
        label.offset = 4.0f;
        if(label){
            [issueLabels addObject:label];
            [xLocations addObject:[NSNumber numberWithFloat:location]];
        }
    }
    
    axisSet.xAxis.axisLabels = issueLabels;
    axisSet.xAxis.majorTickLocations = xLocations;
    // 4 - Configure the y-axis
    
    NSMutableSet *YdayLabels = [[NSMutableSet alloc] init];
    NSMutableSet *yLocations = [[NSMutableSet alloc] init];
    for(int i = 0; i < 6; i++){
        
        CGFloat location = i;
        NSString* iString = [NSString stringWithFormat:@"%d", i];
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
    axisSet.yAxis.title = @"Quality";
    axisSet.yAxis.titleTextStyle = axisTitleStyle;
    axisSet.yAxis.titleOffset = 15.0f;
    axisSet.yAxis.axisLineStyle = axisLineStyle;
}

// numberOfRecordsForPlotg returns the number of entries in the plot.
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot{
    return self.sleepRatings.count;
}

// doubleForPlot determines the average sleep quality corresponding to the particular sleep problem.
-(double)doubleForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)idx{
    if(fieldEnum == 0){
        return (double) idx;
    }
    else if(fieldEnum == 1) {
        NSNumber* sleepQuality = [self.sleepRatings objectAtIndex:idx];
        return [sleepQuality doubleValue];
    }
    return idx;
    
}

// barPlot allows the user to click on a bar graph and see the average length of sleep given the sleep issue.
-(void) barPlot:(CPTBarPlot *)plot barWasSelectedAtRecordIndex:(NSUInteger)idx{
    static CPTMutableTextStyle *style = nil;
    if (!style) {
        style = [CPTMutableTextStyle textStyle];
        style.color= [CPTColor lightGrayColor];
        style.fontSize = 16.0f;
        style.fontName = @"Helvetica-Bold";
    }
    // 3 - Create annotation, if necessary
    NSNumber *sleepAmount = [self.sleepAverages objectAtIndex:idx];
    int sleepAmountHoursInt = [sleepAmount integerValue] / 60;
    NSNumber* sleepAmountHours = [NSNumber numberWithInt:sleepAmountHoursInt];
    int minutes = fmodf([sleepAmount floatValue], 60.0f);
    NSNumber *minutesNS = [NSNumber numberWithInt:minutes];
    if(!self.sleepAvgAnnotation){
        NSNumber *x = [NSNumber numberWithInt:0];
        NSNumber *y = [NSNumber numberWithInt:0];
        NSArray *anchorPoint = [NSArray arrayWithObjects:x, y, nil];
        self.sleepAvgAnnotation = [[CPTPlotSpaceAnnotation alloc] initWithPlotSpace:plot.plotSpace anchorPlotPoint:anchorPoint];
    }
    // 4 - Create number formatter, if needed
    static NSNumberFormatter *formatter = nil;
    if (!formatter) {
        formatter = [[NSNumberFormatter alloc] init];
        [formatter setMaximumFractionDigits:2];
    }
    // 5 - Create text layer for annotation
    NSString *sleepAsString = [NSString stringWithFormat:@"%@:%@", sleepAmountHours, [formatter stringFromNumber:minutesNS]];
    if(minutes < 10.0f){
         [formatter setMaximumFractionDigits:1];
        sleepAsString = [NSString stringWithFormat:@"%@:0%@", sleepAmountHours, [formatter stringFromNumber:minutesNS]];
    }

    CPTTextLayer *textLayer = [[CPTTextLayer alloc] initWithText:sleepAsString style:style];
    self.sleepAvgAnnotation.contentLayer = textLayer;
    // 7 - Get the anchor point for annotation
    CGFloat x = idx + CPDBarWidthQ - .2;
    NSNumber *anchorX = [NSNumber numberWithFloat:x];
    NSNumber *currRating = [NSNumber numberWithFloat:([[self.sleepRatings objectAtIndex:idx] floatValue])];
    CGFloat y = [currRating floatValue] + .21f;
    NSNumber *anchorY = [NSNumber numberWithFloat:y];
    self.sleepAvgAnnotation.anchorPlotPoint = [NSArray arrayWithObjects:anchorX, anchorY, nil];
    // 8 - Add the annotation 
    [plot.graph.plotAreaFrame.plotArea addAnnotation:self.sleepAvgAnnotation];
}


@end
