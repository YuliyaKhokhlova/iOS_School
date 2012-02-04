//
//  ViewController.m
//  FirstOne
//
//  Created by Yuliya Khokhlova on 03.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController
@synthesize v1;
@synthesize v2;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setV1:nil];
    [self setV2:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)buttonTouchUpInside:(id)sender 
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Title" 
                                                     message:@"Message" 
                                                    delegate:nil
                                           cancelButtonTitle:@"Ok" 
                                           otherButtonTitles: nil];
    [alert show];
    [alert release], alert = nil;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:1.0  delay: 0.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^
     {
         v1.center = CGPointMake(300, 300);
     }
                     completion:^(BOOL finished)
     {
     }];

    
    [UIView animateWithDuration:1.0  delay: 0.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^
    {
        v2.center = CGPointMake(300, 300);
    }
                     completion:^(BOOL finished)
    {
    }];

    
}
- (void)dealloc {
    [v1 release];
    [v2 release];
    [super dealloc];
}
@end
