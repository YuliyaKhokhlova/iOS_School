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
    NSMutableArray * _ball;
    NSMutableArray * _brick;
    NSMutableArray * _bonus;
    
    NSMutableDictionary * brickImages;
}
@property Boolean isNewGame;
@property Boolean isPause;
@property NSUInteger level;
@property NSUInteger scores;
@property NSUInteger lives;

@property (retain, nonatomic) ArkanoidBoard * board;
@property (retain, nonatomic) NSMutableArray * ball;
@property (retain, nonatomic) NSMutableArray * brick;
@property (retain, nonatomic) NSMutableArray * bonus;

+ (GameState *)instance;
+ (void)releaseInstance;

- (id)initNewGameFromLevel:(NSUInteger)startLevel;
- (void)loadBricksForLevel:(NSUInteger)level;
+ (void)releaseInstance;
+ (void)resetGame;
+ (void)gameOver;
+ (void)liveLost;
+ (void)killBricks:(NSArray *)bricks;

@end
