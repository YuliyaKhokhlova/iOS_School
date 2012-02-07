//
//  AppDelegate.m
//  FinalProjectBasis
//
//  Created by Yuliya Khokhlova on 30.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "GameState.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize navigationControler = _navigationControler;
@synthesize rootViewCtrl = _rootViewCtrl;

- (void)dealloc
{
    [_window release], _window = nil;
    [_navigationControler release], _navigationControler = nil;
    [_rootViewCtrl release], _rootViewCtrl = nil;
    
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    RootViewController * vc = [[RootViewController alloc] initWithNibName:@"RootViewController" bundle:nil];
    self.rootViewCtrl = vc;
    [vc release], vc = nil;
    self.rootViewCtrl.title = @"Arkanoid";

    UINavigationController * nc = [[UINavigationController alloc] init];
    self.navigationControler = nc;
    [nc release], nc = nil;
    [self.navigationControler setNavigationBarHidden:NO];
    [self.navigationControler pushViewController:self.rootViewCtrl animated:NO];

    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    [self.window setRootViewController:self.navigationControler];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [GameState releaseInstance];
    [self.rootViewCtrl.playVC release], self.rootViewCtrl.playVC = nil;
    [self.rootViewCtrl.highScoreVC release], self.rootViewCtrl.highScoreVC = nil;
    [self.rootViewCtrl.passwordVC release], self.rootViewCtrl.passwordVC = nil;
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
