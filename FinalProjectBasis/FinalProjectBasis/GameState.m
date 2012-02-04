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
        self.ball  = [[NSMutableArray array] retain];
        self.brick = [[NSMutableArray array] retain];
        
        brickImages = [[NSMutableDictionary dictionary] retain];
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
    [brickImages release], brickImages = nil;
    [super dealloc];
}

- (void)loadBricksForLevel:(NSUInteger)level
{
    NSString * levelFile = @"level.lvl";
    
    NSArray * data = [NSArray arrayWithContentsOfFile:levelFile];
    
    for (int i = 0; i < data.count; i = i + 5) 
    {
        
    }
    
    NSString * imageFile = @"brick_pink_purple.png";
    
    UIImage * image = [brickImages objectForKey:imageFile];
    if (nil == image)
    {
        image = [UIImage imageNamed:imageFile];
        [brickImages setObject:image forKey:imageFile];
    }
    CGRect rect  = CGRectMake(13, 30, 49, 25);
    NSArray * array = [NSArray arrayWithObjects:image, nil ];
    ArkanoidBrick * brick = [[ArkanoidBrick alloc] initWithFrame:rect lives:1 images:array bonus:nil];
    
    [self.brick addObject:brick];
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

+ (void)gameOver
{
    _instance.isPause = YES;
    
    NSString * msg = [NSString stringWithFormat:@"Your score %d", _instance.scores];
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Game Over" 
                                                    message:msg 
                                                   delegate:nil 
                                          cancelButtonTitle:@"Ok" 
                                          otherButtonTitles: nil];
    [alert show];
    [alert release];
}

+ (void)liveLost
{
    _instance.lives--;
    
    if (_instance.lives == 0)
    {
        [self gameOver];
    }
}

+ (void)killBricks:(NSArray *)bricks
{
    for (ArkanoidBrick * brick in bricks) 
    {
        [_instance.brick removeObject:brick];
    }
}



@end
