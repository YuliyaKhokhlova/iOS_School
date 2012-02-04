//
//  ArkanoidBoard.m
//  FinalProjectBasis
//
//  Created by Yuliya Khokhlova on 1/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ArkanoidBoard.h"

//static NSString * const BoardNormalImageFile = @"1.jpg";
//static NSString * const BoardWideImageFile = @"1.jpg";
//static NSString * const BoardNarrowImageFile = @"1.jpg";
//
//float const DefaultBoardCenterPositionX = 160;
//float const DefaultBoardCenterPositionY = 430;

@implementation ArkanoidBoard

//@synthesize width = _width;
//@synthesize imageNormal = _imageNormal;
//@synthesize imageWide   = _imageWide;
//@synthesize imageNarrow = _imageNarrow;
//@synthesize centerPos = _centerPos;

- (id)initWithCenterPositionX:(float)startX 
{
    self = [super init];
    if (self) 
    {
//        self.width = ArkanoidBoardWidthNormal;
//        self.imageNormal = nil;
//        self.imageWide   = nil;
//        self.imageNarrow = nil;
//        self.centerPos = CGPointMake(startX, DefaultBoardCenterPositionY);
     }
    return self;
}

- (id)initDefault
{
    return [self initWithCenterPositionX:DefaultBoardCenterPositionX];
}

- (id)init 
{
    return [self initWithCenterPositionX:DefaultBoardCenterPositionX];
}
            
- (void)dealloc 
{
//    [_imageNormal release], _imageNormal = nil;
//    [_imageWide release], _imageWide = nil;
//    [_imageNarrow release], _imageNarrow = nil;
    
    [super dealloc];
}

//- (UIImage *)getImage
//{
//    UIImage * result = nil;
//    switch (self.width) {
//        case ArkanoidBoardWidthNormal:
//            if (self.imageNormal == nil) 
//            {
//                self.imageNormal = [UIImage imageNamed:BoardNormalImageFile];
//            }
//            result = self.imageNormal;
//            break;
//            
//        case ArkanoidBoardWidthWide:
//            if (self.imageNormal == nil) 
//            {
//                self.imageNormal = [UIImage imageNamed:BoardWideImageFile];
//            }
//            result = self.imageWide;
//            break;
//            
//        case ArkanoidBoardWidthNarrow:
//            if (self.imageNormal == nil) 
//            {
//                self.imageNormal = [UIImage imageNamed:BoardNarrowImageFile];
//            }
//            result = self.imageNarrow;
//            break;
//    }
//    return result;
//}

@end
