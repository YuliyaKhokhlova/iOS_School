//
//  DetailViewUpdater.h
//  
//
//  Created by Yuliya Khokhlova on 25.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DetailViewUpdater <NSObject>

- (void)updateScrollViewWithDirection:(NSInteger)direction;

@end
