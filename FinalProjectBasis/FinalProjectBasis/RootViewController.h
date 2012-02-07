//
//  RootViewController.h
//  FinalProjectBasis
//
//  Created by Yuliya Khokhlova on 29.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PlayViewController.h"
#import "HighScoresViewController.h"
#import "PasswordViewController.h"

@interface RootViewController : UIViewController
{
    PlayViewController * _playVC;
    HighScoresViewController * _highScoreVC;
    PasswordViewController * _passwordVC;
}

@property (retain, nonatomic) PlayViewController * playVC;
@property (retain, nonatomic) HighScoresViewController * highScoreVC;
@property (retain, nonatomic) PasswordViewController * passwordVC;

@property (retain, nonatomic) IBOutlet UIButton *playButton;
@property (retain, nonatomic) IBOutlet UIButton *highScoresButton;
@property (retain, nonatomic) IBOutlet UIButton *passwordButton;
@property (retain, nonatomic) IBOutlet UIButton *continueButton;

@end
