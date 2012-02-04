//
//  ArkanoidBonus.h
//  FinalProjectBasis
//
//  Created by Yuliya Khokhlova on 04.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

float const DefaultBonusWidth = 30;
float const DefaultBonusHeight = 30;
float const DefaultBonusVelocity = 10;

@interface ArkanoidBonus : UIImageView
{
    float _velocity;
    SEL _action;
}

@property float velocity;
@property SEL action;

@end
