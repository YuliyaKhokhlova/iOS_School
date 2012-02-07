//
//  ArkanoidBonus.h
//  FinalProjectBasis
//
//  Created by Yuliya Khokhlova on 04.02.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

static float const DefaultBonusWidth = 30;
static float const DefaultBonusHeight = 30;
static float const DefaultBonusVelocity = 7;

static NSString * const BonusSlowBall = @"bonus_slow.gif";
static NSString * const BonusFastBall = @"bonus_fast.gif";
static NSString * const BonusAdditionalLive = @"bonus_live.gif";
static NSString * const BonusWideBoard = @"bonus_wide.gif";
static NSString * const BonusNarrowBoard = @"bonus_narrow.gif";
static NSString * const BonusNextLevel = @"bonus_victory.gif";
static NSString * const BonusMultiBall = @"bonus_multi.gif";

static float const BoardBonusTime = 10.0;
static float const BallBonusTime = 10.0;

enum ArkanoidBonusType
{
    ArkanoidBonusAdditionalLive = 0,
    ArkanoidBonusWideBoard = 1,
    ArkanoidBonusNarrowBoard = 2,
    ArkanoidBonusNextLevel = 3,
    ArkanoidBonusFastBall = 4,
    ArkanoidBonusSlowBall = 5,
};

@interface ArkanoidBonus : UIImageView
{
    float _velocity;
    NSString * _actionNotificationName;
}

@property float velocity;
@property (retain) NSString * actionNotificationName;

- (id)initWithFrame:(CGRect)frame bonusType:(enum ArkanoidBonusType)bonusType;

@end
