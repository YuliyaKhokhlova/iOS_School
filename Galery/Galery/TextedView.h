//
//  TextedView.h
//  
//
//  Created by Yuliya Khokhlova on 18.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextedView : UIView
@property (retain, nonatomic) IBOutlet UIImageView *imageView;
@property (retain, nonatomic) IBOutlet UITextField *textField;
- (IBAction)textFieldEditingDidBegin:(id)sender;

@end
