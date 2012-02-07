//
//  PlayViewController.m
//  FinalProjectBasis
//
//  Created by Yuliya Khokhlova on 29.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "PlayViewController.h"

static float const TimerInterval = 0.05;

@implementation PlayViewController
@synthesize scoreLabel;
@synthesize livesLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        boardView = nil;
        ballView = nil;
        brickViews = nil;
        bonusViews = nil;
    
        UIBarButtonItem * rightButton = [[UIBarButtonItem alloc] initWithTitle:@">" style:UIBarButtonItemStylePlain target:self action:@selector(playPauseButtonPressed)];
        self.navigationItem.rightBarButtonItem = rightButton;
        [rightButton release];

    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
   
    [boardView.imageNarrow release], boardView.imageNarrow = nil;
    [boardView.imageNormal release], boardView.imageNormal = nil;
    [boardView.imageWide release], boardView.imageWide = nil;
 
    NSMutableArray * bricksToRelease = [NSMutableArray array];
    for (ArkanoidBrick * brick in brickViews)
    {
        if (brick.hidden)
        {
            [bricksToRelease addObject:brickViews];
            [brick removeFromSuperview];
        }
    }
    
    [bricksToRelease removeAllObjects];
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    brickViews = [[NSMutableArray array] retain];
    bonusViews = [[NSMutableArray array] retain];
 
    UIBarButtonItem * leftButton = self.navigationItem.leftBarButtonItem;
    leftButton.title = @"Main menu";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bonusActionAdditionalLive) name:BonusAdditionalLive object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bonusActionFastBall) name:BonusFastBall object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bonusActionSlowBall) name:BonusSlowBall object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bonusActionWideBoard) name:BonusWideBoard object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bonusActionNarrowBoard) name:BonusNarrowBoard object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bonusActionNextLevel) name:BonusNextLevel object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [GameState instance].isPause = YES;
    if (NO == [GameState instance].isNewGame) 
    {
        return;
    }

    //Delete old board
    if (nil != boardView)
    {
        [boardView removeFromSuperview];
        [boardView release], boardView = nil;
    }
    
    //Add new board
    ArkanoidBoard * view = [GameState instance].board;
    [self.view addSubview:view];
    boardView = [view retain];
    
    //Delete old ball
    if (nil != ballView)
    {
        [ballView removeFromSuperview];
        [ballView release];
        ballView = nil;
    }
        
    //Add new balls
    ballView = [[GameState instance].ball retain];
    [self.view addSubview:ballView];
    
    //Delete old bricks
    if (0 != brickViews.count)
    {
        for (ArkanoidBrick * brick in brickViews) 
        {
            [brick removeFromSuperview];
        }
        [brickViews removeAllObjects];
    }
    
    //Add new bricks
    for (ArkanoidBrick * brick in [GameState instance].brick)
    {
        [self.view addSubview:brick];
        [brickViews addObject:brick];
    }
    
    //Delete bonuses
    for (ArkanoidBonus * bonus in bonusViews)
    {
        [bonus removeFromSuperview];
    }
    [bonusViews removeAllObjects];
    
    //Update labels
    self.scoreLabel.text = [NSString stringWithFormat:@"%d", [GameState instance].scores];
    self.livesLabel.text = [NSString stringWithFormat:@"%d", [GameState instance].lives];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
   
    [GameState instance].isNewGame = NO;
    [self pauseGame];
}

- (void)viewDidUnload
{
    [self setScoreLabel:nil];
    [self setLivesLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;

    [[NSNotificationCenter defaultCenter] removeObserver:self name:BonusAdditionalLive object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:BonusFastBall object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:BonusSlowBall object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:BonusNarrowBoard object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:BonusWideBoard object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:BonusNextLevel object:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc 
{
    [boardView release], boardView = nil;
    [brickViews release], brickViews = nil;
    [ballView release], ballView = nil;
    [bonusViews release], bonusViews = nil;
    [timer release], timer = nil;
    [scoreLabel release];
    [livesLabel release];
    [super dealloc];
}

- (void)collisionDetectionInPosition:(CGPoint)newCenter bricksToHit:(NSMutableArray *)bricksToHit
{
    float delta = 13;

    //Boundary collision detection
    if (newCenter.x < ballView.frame.size.width / 2 + delta) 
    {
        newCenter.x = ballView.frame.size.width / 2 + delta;
        ballView.velocity = CGPointMake(-ballView.velocity.x, ballView.velocity.y);
    }
    else if (newCenter.x > (ballView.superview.frame.size.width - ballView.frame.size.width / 2 - delta) )
    {
        newCenter.x = ballView.superview.frame.size.width - ballView.frame.size.width / 2 - delta;
        ballView.velocity = CGPointMake(-ballView.velocity.x, ballView.velocity.y);
    }
    
    if (newCenter.y < ballView.frame.size.height / 2 + delta) 
    {
        newCenter.y = ballView.frame.size.height / 2 + delta;
        ballView.velocity = CGPointMake(ballView.velocity.x, -ballView.velocity.y);
    } 
    else if (newCenter.y > (ballView.superview.frame.size.height - ballView.frame.size.height / 2) )
    {
        //[timer invalidate];
    }
    
    //Board collision detection
    CGRect newRect = CGRectMake(ballView.frame.origin.x + ballView.velocity.x, ballView.frame.origin.y + ballView.velocity.y, ballView.frame.size.width, ballView.frame.size.height);
    
    if ( CGRectIntersectsRect(newRect, [GameState instance].board.frame) && boardView.center.y > ballView.center.y) 
    {
        ballView.velocity = CGPointMake(ballView.velocity.x, -ballView.velocity.y);
    }
    
    //Bricks collision detection
    for (ArkanoidBrick * brick in [GameState instance].brick) 
    {
        float deltaCenterX = abs(brick.center.x - ballView.center.x);
        float deltaCenterY = abs(brick.center.y - ballView.center.y);
        
        if (deltaCenterX > (brick.frame.size.width + ballView.frame.size.width) / 2 ||
            deltaCenterY > (brick.frame.size.height + ballView.frame.size.height) / 2 )
            continue;
        
        if (deltaCenterY > brick.frame.size.height / 2 )
        {
            ballView.velocity = CGPointMake(ballView.velocity.x, -ballView.velocity.y);
        }
        else
        {
            ballView.velocity = CGPointMake(-ballView.velocity.x, ballView.velocity.y);
        }
        [bricksToHit addObject:brick];
    }
    
}

- (BOOL)isBallLostWhenMovedToCenter:(CGPoint)newCenter
{
    BOOL isBallLost;
    (newCenter.y >= ballView.superview.frame.size.height) ? (isBallLost = YES) : (isBallLost = NO);
    
    [UIView animateWithDuration:TimerInterval delay:0 options:UIViewAnimationCurveLinear animations:^(void)
     {
         ballView.center = newCenter;
     }
                     completion:^(BOOL finished)
     {
     }];
    
    return isBallLost;
}

- (void)destroyingBricks:(NSArray *)bricksToHit
{
    for (ArkanoidBrick * brick in bricksToHit)
    {
        CGRect rect = brick.frame;
        [UIView animateWithDuration:(TimerInterval * 2) delay:0 options:UIViewAnimationCurveEaseIn animations:^(void)
         {
             brick.frame = CGRectMake(rect.origin.x - 3, rect.origin.y - 3, rect.size.width + 6, rect.size.height + 6);
             brick.alpha = 0;
         }
                         completion:^(BOOL finished)
         {
             brick.hidden = YES;
         }];
        
        [[GameState instance].brick removeObject:brick];
        
        ArkanoidBonus * bonus = brick.bonus;
        if (bonus)
        {
            bonus.center = brick.center;
            [bonusViews addObject:bonus];
            [self.view addSubview:bonus];
        }
        
    }
}

- (void)moveBonus
{
    NSMutableArray * bonusCatched = [NSMutableArray array];
    
    for (ArkanoidBonus * bonus in bonusViews)
    {
        CGPoint newCenter = CGPointMake(bonus.center.x, bonus.center.y + bonus.velocity);
        [UIView animateWithDuration:TimerInterval delay:0 options:UIViewAnimationCurveLinear animations:^(void)
         {
             bonus.center = newCenter;
         }
                         completion:^(BOOL finished)
         {
             bonus.center = newCenter;
         }];
        
        if ( CGRectIntersectsRect(bonus.frame, [GameState instance].board.frame) )
        {
            [bonusCatched addObject:bonus];
            [[NSNotificationCenter defaultCenter] postNotificationName:bonus.actionNotificationName object:nil];
            bonus.hidden = YES;
        }
        else if (bonus.frame.origin.y > boardView.frame.origin.y + boardView.frame.size.height)
        {
            [bonusCatched addObject:bonus];
            [UIView animateWithDuration:TimerInterval delay:0 options:UIViewAnimationCurveLinear animations:^(void)
             {
                 bonus.alpha = 0;
                 bonus.hidden = YES;
             }
                             completion:^(BOOL finished)
             {
             }];
            
        }
    }
    
    [bonusViews removeObjectsInArray:bonusCatched];
}

- (void)liveLost
{
    [GameState instance].lives--;
    [self pauseGame];
    self.livesLabel.text = [NSString stringWithFormat:@"%d", [GameState instance].lives];
    
    if ([GameState instance].lives < 1)
    {
        [GameState instance].isNewGame = YES;
        
        //Show game over alert
        NSString * message = [NSString stringWithFormat:@"Your score: %d", [GameState instance].scores];
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"GAME OVER" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        [alert release];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        //Show live lost alert
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"LOST BALL" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        [alert release];

        ballView.frame = CGRectMake(DefaultBallPositionX, DefaultBallPositionY, DefaultBallWidth, DefaultBallHeight);
        ballView.velocity = CGPointMake(DefaultBallVelocityX, DefaultBallVelocityY);
        
        boardView.center = CGPointMake(DefaultBoardCenterPositionX, DefaultBoardCenterPositionY);
        [boardView setNewWidth:ArkanoidBoardWidthNormal];
        
        
    }
}

- (void)levelComplete
{
    [self pauseGame];
    
    [GameState instance].level++;
    self.title = [NSString stringWithFormat:@"Level %d", [GameState instance].level];
    
    for (ArkanoidBrick * brick in brickViews)
    {
        [brick removeFromSuperview];
    }
    [brickViews removeAllObjects];
    [GameState loadBricks];
    for (ArkanoidBrick * brick in [GameState instance].brick)
    {
        [self.view addSubview:brick];
        [brickViews addObject:brick];
    }
    
    CGPoint boardCenter = CGPointMake(DefaultBoardCenterPositionX, DefaultBoardCenterPositionY);
    [GameState instance].board.center = boardCenter;
    
    [GameState instance].ball.frame = CGRectMake(DefaultBallPositionX, DefaultBallPositionY, DefaultBallWidth, DefaultBallHeight);
    [GameState instance].ball.velocity = CGPointMake(DefaultBallVelocityX, DefaultBallVelocityY);
    
    boardView.center = CGPointMake(DefaultBoardCenterPositionX, DefaultBoardCenterPositionY);
    [boardView setNewWidth:ArkanoidBoardWidthNormal];

    [[GameState instance].bonus removeAllObjects];
    for (ArkanoidBonus * bonus in bonusViews)
    {
        [bonus removeFromSuperview];
    }
    [bonusViews removeAllObjects];
    
    NSUInteger level = [GameState instance].level;
    NSString * levelStr = [NSString stringWithFormat:@"level %d", level];
    NSString * message = [NSString stringWithFormat:@"Remember next level key: 'level %d'", level];
    NSValue * value = [[NSUserDefaults standardUserDefaults] objectForKey:levelStr];
    if (nil == value)
    {
        [[NSUserDefaults standardUserDefaults] setInteger:level forKey:levelStr];
    }
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"LEVEL COMPLETED!" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
    [alert release];
}

- (void)gameStep
{
    NSMutableArray * bricksToHit = [NSMutableArray array];
    CGPoint newCenter = CGPointMake(ballView.center.x + ballView.velocity.x, ballView.center.y + ballView.velocity.y);
    
    //Collision Detection
    [self collisionDetectionInPosition:newCenter bricksToHit:bricksToHit];
    
    //Balls motion
    BOOL isBallLost = [self isBallLostWhenMovedToCenter:newCenter];
    
    //Check live lost
    if (isBallLost)
    {
        [self liveLost];
        return;
    }
    
    //Bricks beating
    if (0 != bricksToHit.count)
    {
        [self destroyingBricks:bricksToHit];
    }
        
    //Add score
    [GameState instance].scores += bricksToHit.count * BrickHitScore;
    scoreLabel.text = [NSString stringWithFormat:@"%d", [GameState instance].scores];
    
    //Bonus motion and acting
    if (0 != bonusViews.count)
    {
        [self moveBonus];
    }
        
    //Check level completion
    if (0 == [GameState instance].brick.count) 
    {
        [self levelComplete];
    }
    
}

- (void)bonusActionSlowBall
{
    ballView.velocity = CGPointMake(ballView.velocity.x * 0.5, ballView.velocity.y * 0.5);

    if (nil != bonusBallTimer)
    {
        [bonusBallTimer invalidate];
    }
    else
    {
        bonusBallTimer = [[NSTimer scheduledTimerWithTimeInterval:BallBonusTime target:self selector:@selector(bonusActionFastBall) userInfo:nil repeats:NO] retain];
    }
}

- (void)bonusActionFastBall
{
    ballView.velocity = CGPointMake(ballView.velocity.x * 2.0, ballView.velocity.y * 2.0);
    
    if (nil != bonusBallTimer)
    {
        [bonusBallTimer invalidate];
    }
    else
    {
        bonusBallTimer = [[NSTimer scheduledTimerWithTimeInterval:BallBonusTime target:self selector:@selector(bonusActionSlowBall) userInfo:nil repeats:NO] retain];
    }
}

- (void)bonusActionWideBoard
{
    if (ArkanoidBoardWidthNormal == boardView.width)
    {
        bonusBoardTimer = [[NSTimer scheduledTimerWithTimeInterval:BoardBonusTime target:self selector:@selector(bonusActionNarrowBoard) userInfo:nil repeats:NO] retain];
        [boardView setNewWidth:ArkanoidBoardWidthWide];
    }
    else
    {
        [bonusBoardTimer invalidate];
        [boardView setNewWidth:ArkanoidBoardWidthNormal];
    }
}

- (void)bonusActionNarrowBoard
{
    if (ArkanoidBoardWidthNormal == boardView.width)
    {
        bonusBoardTimer = [[NSTimer scheduledTimerWithTimeInterval:BoardBonusTime target:self selector:@selector(bonusActionWideBoard) userInfo:nil repeats:NO] retain];
        [boardView setNewWidth:ArkanoidBoardWidthNarrow];
    }
    else
    {
        [bonusBoardTimer invalidate];
        [boardView setNewWidth:ArkanoidBoardWidthNormal];
    }
}

- (void)bonusActionAdditionalLive
{
    [GameState instance].lives++;
    self.livesLabel.text = [NSString stringWithFormat:@"%d", [GameState instance].lives];
}

- (void)bonusActionNextLevel
{
    [self levelComplete];
}

- (void)playPauseButtonPressed
{
    if ([GameState instance].isPause)
    {
        [self launchGame];
    }
    else
    {
        [self pauseGame];
    }
}

- (void)launchGame
{
    [GameState instance].isPause = NO;
    [GameState instance].board.userInteractionEnabled = YES;
    self.navigationItem.rightBarButtonItem.title = @"||";
    timer = [[NSTimer scheduledTimerWithTimeInterval:TimerInterval target:self selector:@selector(gameStep) userInfo:nil repeats:YES] retain];
}

- (void)pauseGame
{
    [GameState instance].isPause = YES;
    [GameState instance].board.userInteractionEnabled = NO;
    self.navigationItem.rightBarButtonItem.title = @">";
    [timer invalidate];
}
         
@end
