//
//  BrickDescription.h
//  FinalProjectBasis
//
//  Created by Yuliya Khokhlova on 2/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BrickDescription : NSObject
{
    float _x;
    float _y;
    NSUInteger _lives;
    NSString * _bonus;
    NSString * _image1;
    NSString * _image2;
    NSString * _image3;
}

@property float x;
@property float y;
@property (copy) NSString * bonus;
@property NSUInteger lives;
@property (copy) NSString * image1;
@property (copy) NSString * image2;
@property (copy) NSString * image3;

@end
