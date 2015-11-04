//
//  TutorialSingUpViewController.m
//  Wall
//
//  Created by Mindpace on 24/07/14.
//
//

#import "TutorialSingUpViewController.h"
#import "SignUpViewController.h"
#import "FirstLoginViewController.h"
#import "LoginPageViewController.h"

@interface TutorialSingUpViewController ()

@end

@implementation TutorialSingUpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setStatusBarStyleOwnApp:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signupWithFacebook:(id)sender {
    
     FirstLoginViewController *svc=[[FirstLoginViewController alloc]initWithNibName:@"FirstLoginViewController" bundle:nil];
    svc.isFacebook=1;
    [self.navigationController pushViewController:svc animated:NO];
    
}

- (IBAction)singUpWithEmail:(id)sender {
    
    SignUpViewController *svc=[[SignUpViewController alloc]initWithNibName:@"SignUpViewController" bundle:nil];
    
    [self.navigationController pushViewController:svc animated:YES];
}

- (IBAction)signIn:(id)sender {
    
    LoginPageViewController *loginViewController=[[LoginPageViewController alloc] initWithNibName:@"LoginPageViewController" bundle:nil];
    [self.navigationController pushViewController:loginViewController animated:YES];
}
@end
