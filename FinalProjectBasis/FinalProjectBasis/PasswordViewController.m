//
//  PasswordViewController.m
//  FinalProjectBasis
//
//  Created by Yuliya Khokhlova on 29.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PasswordViewController.h"
#import "GameState.h"

@implementation PasswordViewController
@synthesize textField;

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
    [self setTextField:nil];
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

    [textField release];
    [super dealloc];
}
- (IBAction)moveToLevel:(id)sender 
{
    NSString * key = self.textField.text;
    NSNumber * value = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (nil == value)
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Wrong key!" message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
    else
    {
        //[self.navigationController popViewControllerAnimated:YES];
        [GameState instance].level = [value intValue];
        [[NSNotificationCenter defaultCenter] postNotificationName:MoveToLevelNotificationName object:nil];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self resignFirstResponder];
}

@end
