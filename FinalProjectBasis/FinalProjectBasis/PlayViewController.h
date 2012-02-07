//
//  PlayViewController.h
//  FinalProjectBasis
//
//  Created by Yuliya Khokhlova on 29.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameState.h"

@interface PlayViewController : UIViewController
{
    NSTimer * timer;
    NSTimer * bonusBoardTimer;
    NSTimer * bonusBallTimer;
    
    ArkanoidBoard * boardView;
    ArkanoidBall * ballView;
    NSMutableArray * brickViews;
    NSMutableArray * bonusViews;
}

@property (retain, nonatomic) IBOutlet UILabel *scoreLabel;
@property (retain, nonatomic) IBOutlet UILabel *livesLabel;

- (void)launchGame;
- (void)pauseGame;

- (void)bonusActionSlowBall;
- (void)bonusActionFastBall;
- (void)bonusActionWideBoard;
- (void)bonusActionNarrowBoard;
- (void)bonusActionAdditionalLive;
- (void)bonusActionNextLevel;

@end
