//
//  BallView.h
//  FinalProjectBasis
//
//  Created by Yuliya Khokhlova on 1/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

static float const DefaultBallPositionX = 160;
static float const DefaultBallPositionY = 378;

static float const DefaultBallVelocityX = 7;
static float const DefaultBallVelocityY = -7;

static float const DefaultBallWidth = 15;
static float const DefaultBallHeight = 15;

@interface ArkanoidBall : UIImageView
{
    CGPoint _velocity;
}

@property CGPoint velocity;

- (id)initWithFrame:(CGRect)frame velocity:(CGPoint)velocity center:(CGPoint)center;

@end
