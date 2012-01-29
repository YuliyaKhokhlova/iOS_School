//
//  DetailViewController.m
//  Galery
//
//  Created by Yuliya Khokhlova on 17.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import "TextedView.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

@synthesize scrollView = _scrollView;
@synthesize detailItem = _detailItem;
@synthesize focusTextField = _focusTextField;
@synthesize prevIndex = _prevIndex;
@synthesize nextIndex = _nextIndex;

- (void)dealloc
{
    [_detailItem release];
    [_scrollView release];
    [super dealloc];
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        [_detailItem release]; 
        _detailItem = [newDetailItem retain]; 

        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:) 
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:) 
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldDidBeginEditing:) 
                                                 name:UITextFieldTextDidBeginEditingNotification
                                               object:nil];
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
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                   name:UITextFieldTextDidBeginEditingNotification
                                                 object:nil];
    
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Detail", @"Detail");
    }
    return self;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.prevIndex = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    TextedView * textedView = [[scrollView subviews] objectAtIndex:self.prevIndex];
    [[textedView textField] resignFirstResponder];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
{
    NSInteger newIndex = scrollView.contentOffset.x / scrollView.bounds.size.width;
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.bounds.size.width, 0)];
    
    NSInteger direction = newIndex - self.prevIndex;
    
}

- (void)textFieldDidBeginEditing:(NSNotification *)notification
{
    self.focusTextField = notification.object;
}

- (void)keyboardWasShown:(NSNotification *)notification
{
    NSDictionary * info = [notification userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    double duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        CGRect start = self.focusTextField.frame;
        CGRect finish = CGRectMake(start.origin.x, start.origin.y - keyboardSize.height, start.size.width, start.size.height);
        [self.focusTextField setFrame:finish];
    }];
}

- (void)keyboardWillBeHidden:(NSNotification *)notification
{
    NSDictionary * info = [notification userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    double duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        CGRect start = self.focusTextField.frame;
        CGRect finish = CGRectMake(start.origin.x, start.origin.y + keyboardSize.height, start.size.width, start.size.height);
        [self.focusTextField setFrame:finish];
    }];
}

@end
