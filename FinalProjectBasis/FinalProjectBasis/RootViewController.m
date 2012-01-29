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

@implementation RootViewController

@synthesize playButton;
@synthesize highScoresButton;
@synthesize passwordButton;
@synthesize quitButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setPlayButton:nil];
    [self setHighScoresButton:nil];
    [self setPasswordButton:nil];
    [self setQuitButton:nil];
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
    PlayViewController * playViewCtrl = [[PlayViewController alloc] initWithNibName:@"PlayViewController" bundle:nil];
    [playViewCtrl setTitle:@"Game"];
    [self.navigationController pushViewController:playViewCtrl animated:YES];
    [playViewCtrl release], playViewCtrl = nil;
}
- (IBAction)continueButtonTouchDown:(id)sender 
{
    PlayViewController * playViewCtrl = [[PlayViewController alloc] initWithNibName:@"PlayViewController" bundle:nil];
    [playViewCtrl setTitle:@"Game"];
    [self.navigationController pushViewController:playViewCtrl animated:YES];
    [playViewCtrl release], playViewCtrl = nil;
}

- (IBAction)highScoresTouchDown:(id)sender 
{
    HighScoresViewController * highScoresViewCtrl = [[HighScoresViewController alloc] initWithNibName:@"HighScoresViewController" bundle:nil];
    [highScoresViewCtrl setTitle:@"Best Scores"];
    [self.navigationController pushViewController:highScoresViewCtrl animated:YES];
    [highScoresViewCtrl release], highScoresViewCtrl = nil;
}

- (IBAction)passwordButtonTouchDown:(id)sender 
{
    PasswordViewController * passwordViewCtrl = [[PasswordViewController alloc] initWithNibName:@"PasswordViewController" bundle:nil];
    [passwordViewCtrl setTitle:@"Go To The Level"];
    [self.navigationController pushViewController:passwordViewCtrl animated:YES];
    [passwordViewCtrl release], passwordViewCtrl = nil;
}

- (void)dealloc {
    [playButton release];
    [highScoresButton release];
    [passwordButton release];
    [quitButton release];
    [super dealloc];
}
@end
