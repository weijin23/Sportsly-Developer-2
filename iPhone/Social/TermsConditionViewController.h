//
//  TermsConditionViewController.h
//  social_T&C_iphone
//
//  Created by Mindpace on 23/09/14.
//  Copyright (c) 2014 mindpacetech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseVC.h"

@interface TermsConditionViewController : BaseVC

@property (assign) BOOL isSign;


- (IBAction)agree:(id)sender;
- (IBAction)disagree:(id)sender;
- (IBAction)backbtn:(id)sender;

@end
