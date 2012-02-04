//
//  ArkanoidBoard.m
//  FinalProjectBasis
//
//  Created by Yuliya Khokhlova on 1/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ArkanoidBoard.h"

static NSString * const BoardNormalImageFile = @"board_normal.png";
static NSString * const BoardWideImageFile = @"board_wide.png";
static NSString * const BoardNarrowImageFile = @"board_narrow.png";

@implementation ArkanoidBoard

@synthesize width = _width;
@synthesize imageNormal = _imageNormal;
@synthesize imageWide   = _imageWide;
@synthesize imageNarrow = _imageNarrow;
@synthesize centerPos = _centerPos;

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame centerPositionX:DefaultBoardCenterPositionX];
}

- (id)initWithFrame:(CGRect)frame centerPositionX:(float)startX 
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        self.imageNormal = nil;
        self.imageWide   = nil;
        self.imageNarrow = nil;
        self.centerPos = CGPointMake(startX, DefaultBoardCenterPositionY);
        //self.width = ArkanoidBoardWidthNormal;
        [self setNewWidth:ArkanoidBoardWidthNormal];
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)setNewWidth:(enum ArkanoidBoardWidth)width
{
    self.width = width;
    CGRect bounds = self.bounds;
    bounds.size.width = width;
    [self setBounds:CGRectMake(bounds.origin.x, bounds.origin.y, width, bounds.size.height)];

    switch (_width) 
    {
        case ArkanoidBoardWidthNormal:
            if (self.imageNormal == nil) 
            {
                self.imageNormal = [UIImage imageNamed:BoardNormalImageFile];
            }
            self.image = self.imageNormal;
            break;

        case ArkanoidBoardWidthWide:
            if (self.imageWide == nil) 
            {
                self.imageWide = [UIImage imageNamed:BoardWideImageFile];
            }
            self.image = self.imageWide;
            break;
        
        case ArkanoidBoardWidthNarrow:
            if (self.imageNarrow == nil)
            {
                self.imageNarrow = [UIImage imageNamed:BoardNarrowImageFile];
            }
            self.image = self.imageNarrow;
            break;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint currentTouchPos = [touch locationInView:[self superview]];
    
    CGPoint newCenter;
    newCenter.x = startCenterPos.x + (currentTouchPos.x - startTouchPos.x);
    newCenter.y = startCenterPos.y;
    
    float delta = 13;
    
    if (newCenter.x < self.bounds.size.width / 2 + delta)
    {
        newCenter.x = self.bounds.size.width / 2 + delta;
    }
    else if (newCenter.x > (self.superview.bounds.size.width - self.bounds.size.width / 2 - delta) )
    {
        newCenter.x = self.superview.bounds.size.width - self.bounds.size.width / 2 - delta;
    }
    
    [self setCenter:newCenter];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    startTouchPos = [touch locationInView:self.superview];
    startCenterPos = self.center;
    
    //[self.nextResponder touchesBegan:touches withEvent:event];
}

- (void)dealloc 
{
//    [_imageNormal release], _imageNormal = nil;
//    [_imageWide release], _imageWide = nil;
//    [_imageNarrow release], _imageNarrow = nil;
    
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
