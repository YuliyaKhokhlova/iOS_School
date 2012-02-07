//
//  ArkanoidBrick.h
//  FinalProjectBasis
//
//  Created by Yuliya Khokhlova on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArkanoidBonus.h"

static float const DefaultBrickWidth = 30;
static float const DefaultBrickHeight = 15;
static float const BrickHitScore = 10;

@interface ArkanoidBrick : UIImageView
{
    NSUInteger _lives;
    ArkanoidBonus * _bonus;
}

@property (nonatomic) NSUInteger lives;
@property (retain, nonatomic) ArkanoidBonus * bonus;

- (id)initWithFrame:(CGRect)frame lives:(NSUInteger)lives image:(UIImage *)image bonus:(ArkanoidBonus *)bonus;
@end
