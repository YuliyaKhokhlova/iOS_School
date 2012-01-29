//
//  TextedView.m
//  
//
//  Created by Yuliya Khokhlova on 18.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TextedView.h"

@implementation TextedView
@synthesize imageView;
@synthesize textField;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc {
    [imageView release];
    [textField release];
    [super dealloc];
}
- (IBAction)textFieldEditingDidBegin:(id)sender 
{
    //[NSNotificationCenter defaultCenter]
}
@end
