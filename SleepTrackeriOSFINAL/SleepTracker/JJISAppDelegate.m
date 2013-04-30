//
//  JJISAppDelegate.m
//  SleepTracker
//
//  Created by Jason Kahn on 2/18/13.
//  Copyright (c) 2013 Jason Kahn. All rights reserved.
//

#import "JJISAppDelegate.h"


@implementation JJISAppDelegate

//  application initializes the audioPlayer and creates the SleepInfoManager.
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"SHSPodcast" ofType:@"mp3"]];
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error: nil];
    self.audioPlayer.volume = 0.5;
    [self.audioPlayer prepareToPlay];
    
    self.manager = [[JJISSleepInfoManager alloc] init];
    
    [self.manager setSleepingStatus:@"Awake"];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

// Calls saveDataToDisk to write files to a p-list file when the application enters the background.
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [self saveDataToDisk];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
}

// loads data from existing p-list file if that file has been created.
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *folder = @"~/App Data";
    folder = [folder stringByExpandingTildeInPath];
    
    if ([fileManager fileExistsAtPath: folder] == YES)
    {
        [self loadDataFromDisk];
    }
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


//method to set the file location
- (NSString *) pathForDataFile
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *folder = @"~/App Data";
    folder = [folder stringByExpandingTildeInPath];
    
    if ([fileManager fileExistsAtPath: folder] == NO)
    {
        [fileManager createDirectoryAtPath:folder withIntermediateDirectories:true attributes:nil error:nil];
    }
    
    NSString *fileName = @"SleepData.plist";
    return [folder stringByAppendingPathComponent: fileName];
}

// saveDataToDisk saves data in the form an encoded p-list to the file designated at path.
- (void) saveDataToDisk
{
    NSString * path = [self pathForDataFile];
    
    NSMutableDictionary * rootObject;
    rootObject = [NSMutableDictionary dictionary];
    [rootObject setValue: [self.manager getAllSleepInfo] forKey:@"sleepData"];
    [rootObject setValue: [self.manager getCurrentSleepInfo] forKey:@"current"];
    [rootObject setValue: [self.manager sleepingStatus] forKey:@"status"];
    [NSKeyedArchiver archiveRootObject: rootObject toFile: path];
}

// loadDataFromDisk loads data from an encoded p-list from the file designated at path.
- (void) loadDataFromDisk
{
    NSString * path = [self pathForDataFile];
    NSDictionary * rootObject;
    rootObject = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    [self.manager setAllSleepInfo:[rootObject valueForKey:@"sleepData"]];
    [self.manager setInfo:[rootObject valueForKey:@"current"]];
    [self.manager setSleepingStatus:[rootObject valueForKey:@"status"]];
}


@end
