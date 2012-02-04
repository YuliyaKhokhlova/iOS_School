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
@synthesize images = _images;

- (id)initWithFrame:(CGRect)frame lives:(NSUInteger)lives images:(NSArray *)images bonus:(IBonus *)bonus
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        (lives < 1) ? (self.lives = 1) : (self.lives = lives);
        imageIndex = 0;
        self.bonus = bonus;
        self.images = images;
        self.image = [self.images objectAtIndex:imageIndex];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame 
{
    return [self initWithFrame:frame lives:DefaultBrickLives images:nil bonus:nil];
}

- (void)dealloc {
    [_bonus release], _bonus = nil;
    [_images release], _images = nil;
    [super dealloc];
}

- (void)changeImage
{
    imageIndex++;
    
    if (imageIndex <= self.images.count) 
    {
        self.image = [self.images objectAtIndex:imageIndex];
    }
    else
    {
        self.image = [self.images objectAtIndex:(self.images.count - 1)];
    }
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
