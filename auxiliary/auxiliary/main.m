//
//  main.m
//  auxiliary
//
//  Created by Yuliya Khokhlova on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "A.h"
#import "BrickDescription.h"

int main (int argc, const char * argv[])
{

    @autoreleasepool 
    {
        
        NSLog(@"Hello, World!");
        
        NSString * str = @"~";
        NSString * str2 = [[str stringByExpandingTildeInPath] stringByAppendingString:@"/level.lvl"];
        
//        NSArray * b1 = [NSArray arrayWithObjects:[NSNumber numberWithFloat:30], [NSNumber numberWithFloat:30], [NSNumber numberWithInt:1], @"brick_lightgreen_green.png", nil];
//        NSArray * b2 = [NSArray arrayWithObjects:[NSNumber numberWithFloat:80], [NSNumber numberWithFloat:30], [NSNumber numberWithInt:1], @"brick_cyan_blue.png", nil];

        
        BrickDescription * br1 = [[BrickDescription alloc] init];
        br1.x = 30;
        br1.y = 30;
        br1.lives = 1;
        br1.bonus = @"none";
        br1.image1 = @"brick_cyan_blue.png";
        br1.image2 = @"";
        br1.image3 = @"";
        
        BrickDescription * br2 = [[BrickDescription alloc] init];
        br2.x = 30;
        br2.y = 60;
        br2.lives = 1;
        br2.bonus = @"none";
        br2.image1 = @"brick_cyan_blue.png";
        br2.image2 = @"";
        br2.image3 = @"";

        
        NSMutableArray * array = [NSMutableArray array];
        
        [array addObject:br1];
        [array addObject:br2];
        
//        [array addObjectsFromArray:b1];
//        [array addObjectsFromArray:b2];                
        
        Boolean res = [array writeToFile:str2 atomically:YES];
        NSLog(@"%d", res);
        
        NSArray * arr2 = [NSArray arrayWithContentsOfFile:str2];
        
    }
    return 0;
}

