//
//  ArkanoidBonus.m
//  FinalProjectBasis
//
//  Created by Yuliya Khokhlova on 04.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ArkanoidBonus.h"
#import "PlayViewController.h"

@implementation ArkanoidBonus

@synthesize velocity = _velocity;
@synthesize actionNotificationName = _actionNotificationName;

- (id)initWithFrame:(CGRect)frame bonusType:(enum ArkanoidBonusType)bonusType
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        self.velocity = DefaultBonusVelocity;
        switch (bonusType) 
        {
            case ArkanoidBonusAdditionalLive:
                self.image = [UIImage imageNamed:BonusAdditionalLive];
                self.actionNotificationName = BonusAdditionalLive;
                break;
                
            case ArkanoidBonusFastBall:
                self.image = [UIImage imageNamed:BonusFastBall];
                self.actionNotificationName = BonusFastBall;
                break;
                
            case ArkanoidBonusSlowBall:
                self.image = [UIImage imageNamed:BonusSlowBall];
                self.actionNotificationName = BonusSlowBall;
                break;
                
            case ArkanoidBonusNarrowBoard:
                self.image = [UIImage imageNamed:BonusNarrowBoard];
                self.actionNotificationName = BonusNarrowBoard;
                break;
                
            case ArkanoidBonusWideBoard:
                self.image = [UIImage imageNamed:BonusWideBoard];
                self.actionNotificationName = BonusWideBoard;
                break;
                
            case ArkanoidBonusNextLevel:
                self.image = [UIImage imageNamed:BonusNextLevel];
                self.actionNotificationName = BonusNextLevel;
                break;
        }

    
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
