//
//  MyView.m
//  FirstOne
//
//  Created by Yuliya Khokhlova on 03.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MyView.h"
#import <QuartzCore/QuartzCore.h>

@implementation MyView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
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

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint pos = [touch locationInView:[self superview]];
    
    [self setCenter:pos];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [UIView beginAnimations:@"animation" context:nil];
    
    CGAffineTransform transform = CGAffineTransformScale([self transform], 1.5, 1.5);
    [self setTransform:transform];
     
    CALayer * layer = [self layer];
    [layer setShadowOpacity:1.0];
    [layer setShadowRadius:2.0];
    [layer setShadowColor:[UIColor blackColor].CGColor];
    [layer setShadowOffset:CGSizeMake(10.0, 10.0)];
ß    
    [UIView commitAnimations];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [UIView beginAnimations:@"animation" context:nil];
    
    CGAffineTransform transform = CGAffineTransformScale([self transform], 0.666667, 0.66666667);
    [self setTransform:transform];

    [UIView commitAnimations];
}

@end
