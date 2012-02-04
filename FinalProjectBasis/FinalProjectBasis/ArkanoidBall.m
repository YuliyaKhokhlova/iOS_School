//
//  BallView.m
//  FinalProjectBasis
//
//  Created by Yuliya Khokhlova on 1/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "GameState.h"
#import "ArkanoidBall.h"

static NSString * const BallImageFile = @"ball.gif";

@implementation ArkanoidBall

@synthesize velocity = _velocity;

- (id)initWithFrame:(CGRect)frame velocity:(CGPoint)velocity center:(CGPoint)center
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        self.velocity = velocity;
        self.center = center;
        UIImage * image = [UIImage imageNamed:BallImageFile];
        self.image = image;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame velocity:CGPointMake(DefaultBallVelocityX, DefaultBallVelocityY) center:CGPointMake(DefaultBallPositionX, DefaultBallPositionY)];
}

- (void)dealloc 
{
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
