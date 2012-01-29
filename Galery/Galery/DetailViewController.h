//
//  DetailViewController.h
//  Galery
//
//  Created by Yuliya Khokhlova on 17.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
{
    UITextField * _focusTextField;
    NSUInteger _prevIndex;
    NSUInteger _nextIndex;
    
    
}

@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) id detailItem;
@property (retain, nonatomic) UITextField * focusTextField;
@property NSUInteger prevIndex;
@property NSUInteger nextIndex;

@end
