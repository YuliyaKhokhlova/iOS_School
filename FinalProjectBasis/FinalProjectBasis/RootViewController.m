//
//  RootViewController.m
//  FinalProjectBasis
//
//  Created by Yuliya Khokhlova on 29.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


// git@github.com:YuliyaKhokhlova/iOS_School.git


#import "RootViewController.h"
#import "PlayViewController.h"
#import "HighScoresViewController.h"
#import "PasswordViewController.h"

#import "GameState.h"

@implementation RootViewController

@synthesize playVC = _playVC;
@synthesize highScoreVC = _highScoreVC;
@synthesize passwordVC = _passwordVC;

@synthesize playButton;
@synthesize highScoresButton;
@synthesize passwordButton;
@synthesize quitButton;
@synthesize continueButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.playVC = nil;
        self.highScoreVC = nil;
        self.passwordVC = nil;
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
    // Do any additional setup after loading the view from its nib.
    if ([GameState instance].isNewGame)
    {
        continueButton.enabled = NO;
    }
    else 
    {
        continueButton.enabled = YES;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([GameState instance].isNewGame)
    {
        continueButton.enabled = NO;
    }
    else 
    {
        continueButton.enabled = YES;
    }   
}

- (void)viewDidUnload
{
    [self setPlayButton:nil];
    [self setHighScoresButton:nil];
    [self setPasswordButton:nil];
    [self setQuitButton:nil];
    [self setContinueButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (IBAction)playButtonTouchDown:(id)sender 
{
    if (![GameState instance].isNewGame)
    {
        [GameState releaseInstance];
    }
    
    [GameState instance].level = DefaultStartLevel;
    [GameState instance].lives = 1;
    [GameState instance].scores = DefaultStartScores;
    
    ArkanoidBoard * board = [[ArkanoidBoard alloc] initWithFrame:CGRectMake(DefaultX, DefaultY, DefaultWidth, DefaultHeight)];
    [GameState instance].board = board;
    [board release], board = nil;
    
    ArkanoidBall * ball = [[ArkanoidBall alloc] initWithFrame:CGRectMake(DefaultBallPositionX, DefaultBallPositionY, DefaultBallWidth, DefaultBallHeight)];
    [[GameState instance].ball addObject:ball];
    [ball release], ball = nil;

    float stx = 13;
    float sty = 200;
    
    CGRect rect = CGRectMake(stx, sty, DefaultBrickWidth, DefaultBrickHeight);
    UIImage * image = [UIImage imageNamed:@"brick_cyan_blue.png"];
    NSArray * images = [NSArray arrayWithObject:image];
    ArkanoidBrick * brick = [[ArkanoidBrick alloc] initWithFrame:rect lives:1 images:images bonus:nil];
    [[GameState instance].brick addObject:brick];
    [brick release], brick = nil;
    
    rect = CGRectMake(stx + DefaultBrickWidth, sty, DefaultBrickWidth, DefaultBrickHeight);
    image = [UIImage imageNamed:@"brick_cyan_blue.png"];
    images = [NSArray arrayWithObject:image];
    brick = [[ArkanoidBrick alloc] initWithFrame:rect lives:1 images:images bonus:nil];
    [[GameState instance].brick addObject:brick];
    [brick release], brick = nil;

    rect = CGRectMake(stx + 2 * DefaultBrickWidth, sty + DefaultBrickHeight, DefaultBrickWidth, DefaultBrickHeight);
    image = [UIImage imageNamed:@"brick_lightgreen_green.png"];
    images = [NSArray arrayWithObject:image];
    brick = [[ArkanoidBrick alloc] initWithFrame:rect lives:1 images:images bonus:nil];
    [[GameState instance].brick addObject:brick];
    [brick release], brick = nil;

    rect = CGRectMake(stx + 3 * DefaultBrickWidth, sty + DefaultBrickHeight, DefaultBrickWidth, DefaultBrickHeight);
    image = [UIImage imageNamed:@"brick_lightgreen_green.png"];
    images = [NSArray arrayWithObject:image];
    brick = [[ArkanoidBrick alloc] initWithFrame:rect lives:1 images:images bonus:nil];
    [[GameState instance].brick addObject:brick];
    [brick release], brick = nil;
    
    rect = CGRectMake(stx + 4 * DefaultBrickWidth, sty + 2 * DefaultBrickHeight, DefaultBrickWidth, DefaultBrickHeight);
    image = [UIImage imageNamed:@"brick_pink_purple.png"];
    images = [NSArray arrayWithObject:image];
    brick = [[ArkanoidBrick alloc] initWithFrame:rect lives:1 images:images bonus:nil];
    [[GameState instance].brick addObject:brick];
    [brick release], brick = nil;

    rect = CGRectMake(stx + 5 * DefaultBrickWidth, sty + 2 * DefaultBrickHeight, DefaultBrickWidth, DefaultBrickHeight);
    image = [UIImage imageNamed:@"brick_pink_purple.png"];
    UIImage * image2 = [UIImage  imageNamed:@"brick_cyan_blue.png"];
    images = [NSArray arrayWithObjects:image, image2, nil];
    brick = [[ArkanoidBrick alloc] initWithFrame:rect lives:1 images:images bonus:nil];
    [[GameState instance].brick addObject:brick];
    [brick release], brick = nil;

    if (!self.playVC)
    {
        self.playVC = [[PlayViewController alloc] initWithNibName:@"PlayViewController" bundle:nil];
        [self.playVC setTitle:@"Level 1"];
    }
    [self.navigationController pushViewController:self.playVC animated:YES];
}
    
- (IBAction)continueButtonTouchDown:(id)sender 
{
    if (!self.playVC)
    {
        self.playVC = [[PlayViewController alloc] initWithNibName:@"PlayViewController" bundle:nil];
        [self.playVC setTitle:@"Game"];
    }
    [self.navigationController pushViewController:self.playVC animated:YES];
}

- (IBAction)highScoresTouchDown:(id)sender 
{
    if (!self.highScoreVC)
    {
        self.highScoreVC = [[HighScoresViewController alloc] initWithNibName:@"HighScoresViewController" bundle:nil];
        [self.highScoreVC setTitle:@"Best Scores"];
    }
    [self.navigationController pushViewController:self.highScoreVC animated:YES];
}

- (IBAction)passwordButtonTouchDown:(id)sender 
{
    PasswordViewController * passwordViewCtrl = [[PasswordViewController alloc] initWithNibName:@"PasswordViewController" bundle:nil];
    [passwordViewCtrl setTitle:@"Go To The Level"];
    [self.navigationController pushViewController:passwordViewCtrl animated:YES];
    [passwordViewCtrl release], passwordViewCtrl = nil;
}

- (void)dealloc 
{
    [playButton release];
    [highScoresButton release];
    [passwordButton release];
    [quitButton release];
    [continueButton release];
    [super dealloc];
}
@end
