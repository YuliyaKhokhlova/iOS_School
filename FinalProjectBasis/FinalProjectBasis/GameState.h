//
//  GameState.h
//  FinalProjectBasis
//
//  Created by Yuliya Khokhlova on 1/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArkanoidBoard.h"
#import "ArkanoidBall.h"
#import "ArkanoidBrick.h"
#import "ArkanoidBonus.h"

static NSUInteger const DefaultStartLevel = 1;
static NSUInteger const DefaultStartScores = 0;
static NSUInteger const DefaultStartLives = 3;

@interface GameState : NSObject
{
    Boolean _isNewGame;
    Boolean _isPause;
    NSUInteger _level;
    NSUInteger _scores;
    NSUInteger _lives;
    
    ArkanoidBoard * _board;
    ArkanoidBall * _ball;
    NSMutableArray * _brick;
    NSMutableArray * _bonus;
}
@property Boolean isNewGame;
@property Boolean isPause;
@property NSUInteger level;
@property NSUInteger scores;
@property NSUInteger lives;

@property (retain, nonatomic) ArkanoidBoard * board;
@property (retain, nonatomic) ArkanoidBall * ball;
@property (retain, nonatomic) NSMutableArray * brick;
@property (retain, nonatomic) NSMutableArray * bonus;

+ (GameState *)instance;
+ (void)releaseInstance;

- (id)initNewGameFromLevel:(NSUInteger)startLevel;
+ (void)loadBricks;
+ (void)releaseInstance;
+ (void)resetGame;

@end
