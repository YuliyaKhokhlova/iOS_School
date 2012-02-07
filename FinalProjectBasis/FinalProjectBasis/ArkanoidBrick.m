//
//  ArkanoidBrick.m
//  FinalProjectBasis
//
//  Created by Yuliya Khokhlova on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ArkanoidBrick.h"

static NSUInteger const DefaultBrickLives = 1;
static NSString * const DefaultBrickImageFile = @"brick_grey_black.png";

@implementation ArkanoidBrick

@synthesize lives = _lives;
@synthesize bonus = _bonus;

- (id)initWithFrame:(CGRect)frame lives:(NSUInteger)lives image:(UIImage *)image bonus:(ArkanoidBonus *)bonus
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        (lives < 1) ? (self.lives = 1) : (self.lives = lives);
        self.bonus = bonus;
        self.image = image;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame 
{
    return [self initWithFrame:frame lives:DefaultBrickLives image:nil bonus:nil];
}

- (void)dealloc {
    [_bonus release], _bonus = nil;
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
