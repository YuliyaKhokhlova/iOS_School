//
//  A.h
//  auxiliary
//
//  Created by Yuliya Khokhlova on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface A : NSObject
{
    float _posX;
    float _posY;
    NSUInteger _lives;
    NSString * _fileName;
}

@property float posX;
@property float posY;
@property NSUInteger lives;
@property (retain, nonatomic) NSString * fileName;

- (id)initWithPosX:(float)posX posY:(float)posY lives:(NSUInteger)lives fileName:(NSString *)fileName;

@end
