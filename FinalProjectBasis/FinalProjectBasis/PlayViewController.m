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
@synthesize pauseButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    ballViews = [[NSMutableArray array] retain];
    brickViews = [[NSMutableArray array] retain];
    
    UIView * view = [GameState instance].board;
    [self.view addSubview:view];

    for (ArkanoidBall * ball in [GameState instance].ball) 
    {
        [self.view addSubview:ball];
        [ballViews addObject:ball];
    }    
    
    for (ArkanoidBrick * brick in [GameState instance].brick)
    {
        [self.view addSubview:brick];
        //[brickViews addObject:brick];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self launchGame];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    for (ArkanoidBall * ball in ballViews) 
    {
        [ball removeFromSuperview];
    }
    [ballViews release];
    
   
    [GameState instance].isNewGame = NO;
}

- (void)viewDidUnload
{
    [self setPauseButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc 
{
    [brickViews release], brickViews = nil;
    [ballViews release], ballViews = nil;
    [timer release], timer = nil;
    [pauseButton release];
    [super dealloc];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Title" message:nil delegate:nil cancelButtonTitle:@"q" otherButtonTitles:nil];
    [alert show];
    [alert release];
}

- (void)collisionDetectionInPositions:(NSArray *)newCenters withBricks:(NSArray *)bricksToKill
{
}

- (void)moveBallsToCenters:(NSArray *)newCenters
{
    [UIView animateWithDuration:TimerInterval delay:0 options:UIViewAnimationCurveLinear animations:^(void)
     {
         for (int i = 0; i < [GameState instance].ball.count; i++)
         {
             NSValue * value = [newCenters objectAtIndex:i];
             CGPoint center = [value CGPointValue];
             ArkanoidBall * ball = [[GameState instance].ball objectAtIndex:i];
             ball.center = center;
         }
     }
                     completion:^(BOOL finished)
     {
     }];
}

- (void)destroyingBricks:(NSArray *)bricksToKill
{
    for (ArkanoidBrick * brick in bricksToKill)
    {
        CGRect rect = brick.frame;
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationCurveEaseIn animations:^(void)
         {
             brick.frame = CGRectMake(rect.origin.x - 3, rect.origin.y - 3, rect.size.width + 6, rect.size.height + 6);
             brick.alpha = 0;
         }
                         completion:^(BOOL finished)
         {
             [brick setHidden:YES];
         }];
        [[GameState instance].brick removeObject:brick];
    }
}

- (void)gameStep
{
    NSMutableArray * newCenter = [NSMutableArray arrayWithCapacity:[GameState instance].ball.count];
    NSMutableArray * bricksToKill = [NSMutableArray array];
    float delta = 13;
    
    //Collision Detection
    for (ArkanoidBall * ball in [GameState instance].ball)
    {
        CGPoint newPoint = CGPointMake(ball.center.x + ball.velocity.x, ball.center.y + ball.velocity.y);
        
        //Boundary collision detection
        if (newPoint.x < ball.frame.size.width / 2 + delta) 
        {
            newPoint.x = ball.frame.size.width / 2 + delta;
            ball.velocity = CGPointMake(-ball.velocity.x, ball.velocity.y);
        }
        else if (newPoint.x > (ball.superview.frame.size.width - ball.frame.size.width / 2 - delta) )
        {
            newPoint.x = ball.superview.frame.size.width - ball.frame.size.width / 2 - delta;
            ball.velocity = CGPointMake(-ball.velocity.x, ball.velocity.y);
        }
        
        if (newPoint.y < ball.frame.size.height / 2 + delta) 
        {
            newPoint.y = ball.frame.size.height / 2 + delta;
            ball.velocity = CGPointMake(ball.velocity.x, -ball.velocity.y);
        } 
        else if (newPoint.y > (ball.superview.frame.size.height - ball.frame.size.height / 2) )
        {
            [timer invalidate];
        }
        
        [newCenter addObject:[NSValue valueWithCGPoint:newPoint]];

        //Board collision detection
        CGRect newRect = CGRectMake(ball.frame.origin.x + ball.velocity.x, ball.frame.origin.y + ball.velocity.y, ball.frame.size.width, ball.frame.size.height);
        
        if ( CGRectIntersectsRect(newRect, [GameState instance].board.frame) ) 
        {
            ball.velocity = CGPointMake(ball.velocity.x, -ball.velocity.y);
        }

        //Bricks collision detection
        for (ArkanoidBrick * brick in [GameState instance].brick) 
        {
            float deltaCenterX = abs(brick.center.x - ball.center.x);
            float deltaCenterY = abs(brick.center.y - ball.center.y);
                
            if (deltaCenterX > (brick.frame.size.width + ball.frame.size.width) / 2 ||
                deltaCenterY > (brick.frame.size.height + ball.frame.size.height) / 2 )
                continue;
            
            if (deltaCenterY > brick.frame.size.height / 2 )
            {
                ball.velocity = CGPointMake(ball.velocity.x, -ball.velocity.y);
            }
            else
            {
                ball.velocity = CGPointMake(-ball.velocity.x, ball.velocity.y);
            }
            
            [bricksToKill addObject:brick];
        }
    }
    
    //Balls motion
    [self moveBallsToCenters:newCenter];
    
    //Bricks destroying
    [self destroyingBricks:bricksToKill];
    
}

- (void)launchGame
{
    [GameState instance].isPause = NO;
    [GameState instance].board.userInteractionEnabled = YES;
    timer = [[NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(gameStep) userInfo:nil repeats:YES] retain];
}

- (void)pauseGame
{
    [GameState instance].isPause = YES;
    [GameState instance].board.userInteractionEnabled = NO;
    [timer invalidate];
}

@end
