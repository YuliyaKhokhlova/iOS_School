//
//  ViewController.h
//  FirstOne
//
//  Created by Yuliya Khokhlova on 03.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyView.h"

@interface ViewController : UIViewController

- (IBAction)buttonTouchUpInside:(id)sender;

@property (retain, nonatomic) IBOutlet MyView *v1;
@property (retain, nonatomic) IBOutlet MyView *v2;

@end
