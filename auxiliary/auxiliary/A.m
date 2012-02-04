//
//  A.m
//  auxiliary
//
//  Created by Yuliya Khokhlova on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "A.h"

@implementation A

@synthesize posX = _posX;
@synthesize posY = _posY;
@synthesize lives = _lives;
@synthesize fileName = _fileName;

- (id)initWithPosX:(float)posX posY:(float)posY lives:(NSUInteger)lives fileName:(NSString *)fileName 
{
    self = [super init];
    if (self) 
    {
        self.posX = posX;
        self.posY = posY;
        self.lives = lives;
        self.fileName = fileName;
    }
    return self;
}

@end
