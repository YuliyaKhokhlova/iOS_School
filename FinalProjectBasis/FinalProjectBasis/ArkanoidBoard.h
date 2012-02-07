//
//  ArkanoidBoard.h
//  FinalProjectBasis
//
//  Created by Yuliya Khokhlova on 1/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

enum ArkanoidBoardWidth 
{
    ArkanoidBoardWidthNormal = 70,
    ArkanoidBoardWidthWide   = 100,
    ArkanoidBoardWidthNarrow = 40
};

static float const DefaultBoardCenterPositionX = 160;
static float const DefaultBoardCenterPositionY = 400;

static float const DefaultBoardPositionX = 130;
static float const DefaultBoardPositionY = 385;
static float const DefaultWidth = ArkanoidBoardWidthNormal;
static float const DefaultHeight = 15;

@interface ArkanoidBoard : UIImageView
{
    CGPoint startCenterPos;
    CGPoint startTouchPos;
    
    enum ArkanoidBoardWidth _width;
    UIImage * _imageNormal;
    UIImage * _imageWide;
    UIImage * _imageNarrow;
    
    CGPoint _centerPos;
}

@property enum ArkanoidBoardWidth width;
@property (retain, nonatomic) UIImage * imageNormal;
@property (retain, nonatomic) UIImage * imageWide;
@property (retain, nonatomic) UIImage * imageNarrow;

@property CGPoint centerPos;

- (id)initWithFrame:(CGRect)frame centerPositionX:(float)startX;
- (enum ArkanoidBoardWidth)width;
- (void)setNewWidth:(enum ArkanoidBoardWidth)width;

@end
