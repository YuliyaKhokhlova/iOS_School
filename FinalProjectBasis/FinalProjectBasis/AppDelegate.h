//
//  AppDelegate.h
//  FinalProjectBasis
//
//  Created by Yuliya Khokhlova on 30.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UINavigationController * _navigationControler;
    RootViewController * _rootViewCtrl;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController * navigationControler;
@property (strong, nonatomic) RootViewController * rootViewCtrl;

@end
