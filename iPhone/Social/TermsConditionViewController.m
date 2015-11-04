//
//  TermsConditionViewController.m
//  social_T&C_iphone
//
//  Created by Mindpace on 23/09/14.
//  Copyright (c) 2014 mindpacetech. All rights reserved.
//

#import "TermsConditionViewController.h"
#import "FirstLoginViewController.h"
#import "TutorialSingUpViewController.h"

@interface TermsConditionViewController()

@end

@implementation TermsConditionViewController
@synthesize isSign;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationController.navigationBarHidden=YES;
    //self.navigationItem.title=@"END USER LICENSE AGREEMENT";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)agree:(id)sender {
    
    appDelegate.aDef=[NSUserDefaults standardUserDefaults];
    
    NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    if(![appDelegate.aDef objectForKey:ISFIRSTTIME])
    {
        NSString *udid=  nil;
        
        if(systemVersion<6.0)
            udid= [[UIDevice currentDevice] uniqueDeviceIdentifier];
        else
            udid=[[[UIDevice currentDevice] identifierForVendor] UUIDString];
        
        [appDelegate setUserDefaultValue:udid ForKey:UDID];
        [appDelegate setUserDefaultValue:@"1" ForKey:ISFIRSTTIME];
        
        [appDelegate setUserDefaultValue:appVersion ForKey:APPBUNDLEVERSION];
        
    }

    
    if (self.isSign==YES) {
        FirstLoginViewController *loginViewController=[[FirstLoginViewController alloc] initWithNibName:@"FirstLoginViewController" bundle:nil];
        [self.navigationController pushViewController:loginViewController animated:YES];
        
    }
    else if (self.isSign==NO){
        TutorialSingUpViewController *loginViewController=[[TutorialSingUpViewController alloc] initWithNibName:@"TutorialSingUpViewController" bundle:nil];
        [self.navigationController pushViewController:loginViewController animated:YES];
    }
    
}

- (IBAction)disagree:(id)sender
{
    UIAlertView *a=[[UIAlertView alloc]initWithTitle:nil message:@"Are you sure you want to disagree?" delegate:self cancelButtonTitle:@"No"otherButtonTitles:@"Yes",nil];
    [a show];
   // a.alertViewStyle=UIAlertViewStyleDefault;
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
        /*[appDelegate removeUserDefaultValueForKey:UDID];
        [appDelegate removeUserDefaultValueForKey:ISFIRSTTIME];
        [appDelegate removeUserDefaultValueForKey:APPBUNDLEVERSION];*/

}
- (IBAction)backbtn:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
