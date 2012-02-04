//
//  ArkanoidBrick.h
//  FinalProjectBasis
//
//  Created by Yuliya Khokhlova on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IBonus.h"

static float const DefaultBrickWidth = 30;
static float const DefaultBrickHeight = 15;

@interface ArkanoidBrick : UIImageView
{
    NSUInteger _lives;
    IBonus * _bonus;
    NSArray * _images;
}

@property (nonatomic) NSUInteger lives;
@property (retain, nonatomic) IBonus * bonus;
@property (retain, nonatomic) NSArray * images;

- (id)initWithFrame:(CGRect)frame lives:(NSUInteger)lives images:(NSArray *)images bonus:(IBonus *)bonus;

@end
