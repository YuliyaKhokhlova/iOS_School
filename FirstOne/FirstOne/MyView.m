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
//    CGPoint center = self.center;
//    CGPoint newCenter = CGPointMake(center.x + 100, center.y + 100);
//    CGPoint newNewCenter = CGPointMake(newCenter.x + 100, newCenter.y + 100);
//    
//    [UIView animateWithDuration:1.0  delay: 0.0
//                        options: UIViewAnimationOptionCurveEaseInOut
//                     animations:^
//    {
//        self.center = newCenter;
//    }
//                     completion:^(BOOL finished)
//    {
//        //self.center = newNewCenter;
//    }];
    
//    [UIView beginAnimations:@"animation" context:nil];
//    
//    CGAffineTransform transform = CGAffineTransformScale([self transform], 1.5, 1.5);
//    CGAffineTransform transform = CGAffineTransformTranslate([self transform], 30, 30);
//    [self setTransform:transform];
//     
//    CALayer * layer = [self layer];
//    [layer setShadowOpacity:1.0];
//    [layer setShadowRadius:2.0];
//    [layer setShadowColor:[UIColor blackColor].CGColor];
//    [layer setShadowOffset:CGSizeMake(10.0, 10.0)];
//    
//    [UIView commitAnimations];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
//    [UIView beginAnimations:@"animation" context:nil];
//    
//    CGAffineTransform transform = CGAffineTransformScale([self transform], 0.666667, 0.66666667);
//    [self setTransform:transform];
//
//    [UIView commitAnimations];
}

@end
