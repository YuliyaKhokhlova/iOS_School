//
//  IBonus.h
//  FinalProjectBasis
//
//  Created by Yuliya Khokhlova on 1/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IBonus : NSObject
{
    float _speed;
}

@property float speed;

- (void)bonusAction;

@end
