//
//  GameState.m
//  FinalProjectBasis
//
//  Created by Yuliya Khokhlova on 1/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameState.h"


@implementation GameState

static GameState * _instance = nil;

@synthesize isNewGame = _isNewGame;
@synthesize isPause = _isPause;
@synthesize level = _level;
@synthesize scores = _scores;
@synthesize lives = _lives;

@synthesize board = _board;
@synthesize ball = _ball;
@synthesize brick = _brick;
@synthesize bonus = _bonus;

- (id)initNewGameFromLevel:(NSUInteger)startLevel 
{
    self = [super init];
    if (self) 
    {
        self.isPause = NO;
        self.isNewGame = YES;
        self.level = startLevel;
        self.scores = DefaultStartScores;
        self.lives = DefaultStartLives;
        
        self.board = nil;
        self.ball  = [NSMutableArray array];
        self.brick = [NSMutableArray array];
    }
    return self;
}

- (id)init
{
    return [self initNewGameFromLevel:DefaultStartLevel];
}

- (void)dealloc 
{
    [_board release], _board = nil;
    [_ball release], _ball = nil;
    [_brick release], _brick = nil;
    [super dealloc];
}

+ (void)loadBricks
{
    [_instance.brick removeAllObjects];
    
    float stx = 100;
    float sty = 180;
    
    CGRect rect = CGRectMake(stx, sty, DefaultBrickWidth, DefaultBrickHeight);
    UIImage * image = [UIImage imageNamed:@"brick_cyan_blue.png"];
    ArkanoidBonus * bonus = [[ArkanoidBonus alloc] initWithFrame:rect bonusType:ArkanoidBonusFastBall];
    ArkanoidBrick * brick = [[ArkanoidBrick alloc] initWithFrame:rect lives:1 image:image bonus:bonus];
    [bonus release], bonus = nil;
    [[GameState instance].brick addObject:brick];
    [brick release], brick = nil;
    
    rect = CGRectMake(stx + DefaultBrickWidth, sty, DefaultBrickWidth, DefaultBrickHeight);
    image = [UIImage imageNamed:@"brick_cyan_blue.png"];
    brick = [[ArkanoidBrick alloc] initWithFrame:rect lives:1 image:image bonus:nil];
    [[GameState instance].brick addObject:brick];
    [brick release], brick = nil;

    rect = CGRectMake(stx + 2 * DefaultBrickWidth, sty - DefaultBrickHeight, DefaultBrickWidth, DefaultBrickHeight);
    image = [UIImage imageNamed:@"brick_lightgreen_green.png"];
    brick = [[ArkanoidBrick alloc] initWithFrame:rect lives:1 image:image bonus:nil];
    [[GameState instance].brick addObject:brick];
    [brick release], brick = nil;
    
    rect = CGRectMake(stx + 3 * DefaultBrickWidth, sty - DefaultBrickHeight, DefaultBrickWidth, DefaultBrickHeight);
    image = [UIImage imageNamed:@"brick_lightgreen_green.png"];
    brick = [[ArkanoidBrick alloc] initWithFrame:rect lives:1 image:image bonus:nil];
    [[GameState instance].brick addObject:brick];
    [brick release], brick = nil;
    
    rect = CGRectMake(stx + 4 * DefaultBrickWidth, sty - 2 * DefaultBrickHeight, DefaultBrickWidth, DefaultBrickHeight);
    image = [UIImage imageNamed:@"brick_pink_purple.png"];
    brick = [[ArkanoidBrick alloc] initWithFrame:rect lives:1 image:image bonus:nil];
    [[GameState instance].brick addObject:brick];
    [brick release], brick = nil;
    
    rect = CGRectMake(stx + 5 * DefaultBrickWidth, sty - 2 * DefaultBrickHeight, DefaultBrickWidth, DefaultBrickHeight);
    image = [UIImage imageNamed:@"brick_pink_purple.png"];
    bonus = [[ArkanoidBonus alloc] initWithFrame:rect bonusType:ArkanoidBonusWideBoard];
    brick = [[ArkanoidBrick alloc] initWithFrame:rect lives:1 image:image bonus:bonus];
    [bonus release], bonus = nil;
    [[GameState instance].brick addObject:brick];
    [brick release], brick = nil;
    
    //
    rect = CGRectMake(stx, sty - DefaultBrickHeight, DefaultBrickWidth, DefaultBrickHeight);
    image = [UIImage imageNamed:@"brick_cyan_blue.png"];
    brick = [[ArkanoidBrick alloc] initWithFrame:rect lives:1 image:image bonus:nil];
    [[GameState instance].brick addObject:brick];
    [brick release], brick = nil;
    
    rect = CGRectMake(stx + DefaultBrickWidth, sty - DefaultBrickHeight, DefaultBrickWidth, DefaultBrickHeight);
    image = [UIImage imageNamed:@"brick_cyan_blue.png"];
    brick = [[ArkanoidBrick alloc] initWithFrame:rect lives:1 image:image bonus:nil];
    [[GameState instance].brick addObject:brick];
    [brick release], brick = nil;
    
    rect = CGRectMake(stx + 2 * DefaultBrickWidth, sty - 2 * DefaultBrickHeight, DefaultBrickWidth, DefaultBrickHeight);
    image = [UIImage imageNamed:@"brick_lightgreen_green.png"];
    bonus = [[ArkanoidBonus alloc] initWithFrame:rect bonusType:ArkanoidBonusAdditionalLive];
    brick = [[ArkanoidBrick alloc] initWithFrame:rect lives:1 image:image bonus:bonus];
    [bonus release], bonus = nil;
    [[GameState instance].brick addObject:brick];
    [brick release], brick = nil;
    
    rect = CGRectMake(stx + 3 * DefaultBrickWidth, sty - 2 * DefaultBrickHeight, DefaultBrickWidth, DefaultBrickHeight);
    image = [UIImage imageNamed:@"brick_lightgreen_green.png"];
    bonus = [[ArkanoidBonus alloc] initWithFrame:rect bonusType:ArkanoidBonusSlowBall];
    brick = [[ArkanoidBrick alloc] initWithFrame:rect lives:1 image:image bonus:bonus];
    [bonus release], bonus = nil;
    [[GameState instance].brick addObject:brick];
    [brick release], brick = nil;
    
    rect = CGRectMake(stx + 4 * DefaultBrickWidth, sty - 3 * DefaultBrickHeight, DefaultBrickWidth, DefaultBrickHeight);
    image = [UIImage imageNamed:@"brick_pink_purple.png"];
    brick = [[ArkanoidBrick alloc] initWithFrame:rect lives:1 image:image bonus:nil];
    [[GameState instance].brick addObject:brick];
    [brick release], brick = nil;
    
    rect = CGRectMake(stx + 5 * DefaultBrickWidth, sty - 3 * DefaultBrickHeight, DefaultBrickWidth, DefaultBrickHeight);
    image = [UIImage imageNamed:@"brick_pink_purple.png"];
    brick = [[ArkanoidBrick alloc] initWithFrame:rect lives:1 image:image bonus:nil];
    [[GameState instance].brick addObject:brick];
    [brick release], brick = nil;
    
    
}

+ (GameState *)instance
{
    @synchronized(self) 
    {
        if (!_instance) 
        {
            _instance = [[GameState alloc] init];
        }
    }
    return _instance;
}

+ (void)releaseInstance
{
    [_instance release], _instance = nil;
}

+ (void)resetGame
{
    
}

@end
