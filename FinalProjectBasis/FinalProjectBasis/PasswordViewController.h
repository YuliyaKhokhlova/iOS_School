//
//  PasswordViewController.h
//  FinalProjectBasis
//
//  Created by Yuliya Khokhlova on 29.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const MoveToLevelNotificationName = @"move to level";

@interface PasswordViewController : UIViewController

@property (retain, nonatomic) IBOutlet UITextField *textField;

- (IBAction)moveToLevel:(id)sender;

@end
