//
//  PlayViewController.h
//  FinalProjectBasis
//
//  Created by Yuliya Khokhlova on 29.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArkanoidBoard.h"
#import "GameState.h"

@interface PlayViewController : UIViewController
{
    NSTimer * timer;
    
    NSMutableArray * ballViews;
    NSMutableArray * brickViews;
}

@property (retain, nonatomic) IBOutlet UIImageView *pauseButton;

- (void)launchGame;
- (void)pauseGame;

@end
