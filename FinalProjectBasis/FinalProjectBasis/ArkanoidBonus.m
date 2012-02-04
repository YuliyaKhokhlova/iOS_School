//
//  ArkanoidBonus.m
//  FinalProjectBasis
//
//  Created by Yuliya Khokhlova on 04.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ArkanoidBonus.h"

@implementation ArkanoidBonus

@synthesize velocity = _velocity;
@synthesize action = _action;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        self.velocity = DefaultBonusVelocity;
        self.action = nil;
    }
    return self;
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
