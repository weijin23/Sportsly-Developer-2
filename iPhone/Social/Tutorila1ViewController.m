//
//  Tutorila1ViewController.m
//  Wall
//
//  Created by Mindpace on 04/07/14.
//
//

#import "Tutorila1ViewController.h"
#import "Tutorila2ViewController.h"
#import "FirstLoginViewController.h"
#import "TutorialSingUpViewController.h"
#import "TermsConditionViewController.h"
#import "CenterViewController.h"

@interface Tutorila1ViewController ()

@end

@implementation Tutorila1ViewController

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
    // Do any additional setup after loading the view from its nib.
    if ([appDelegate.aDef objectForKey:ISFIRSTTIME]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNavigationControllerUpdated:) name:SHOWNAVIGATIONCONTROLLERTUTORIAL object:nil];
        if (self.isiPad) {
            self.image1.image=[UIImage imageNamed:@"tutorila_team1_ipad.png"];
        }
        else{
            self.image1.image=[UIImage imageNamed:@"tutorila_team1.png"];
        }
        self.btnSignIn.hidden=YES;
        self.btnSignup.hidden=YES;
        self.btnInvite.hidden=YES;
    }
    
    
    UISwipeGestureRecognizer *sgleft=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeDone)];
    sgleft.direction=UISwipeGestureRecognizerDirectionRight;
    [self.image1 addGestureRecognizer:sgleft];
    
    
    UISwipeGestureRecognizer *sgright=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeDone)];
    sgright.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.image1 addGestureRecognizer:sgright];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)singin:(id)sender {
    
    TermsConditionViewController *loginViewController=[[TermsConditionViewController alloc] initWithNibName:@"TermsConditionViewController" bundle:nil];
    loginViewController.isSign=YES;
    [self.navigationController pushViewController:loginViewController animated:YES];
    
}

- (IBAction)signUpWithFacebook:(id)sender {
    
    TermsConditionViewController *loginViewController=[[TermsConditionViewController alloc] initWithNibName:@"TermsConditionViewController" bundle:nil];
    loginViewController.isSign=NO;
    [self.navigationController pushViewController:loginViewController animated:YES];
}

- (IBAction)inviteACoach:(id)sender {
    
    Class mailclass = (NSClassFromString(@"MFMailComposeViewController"));
    
    if (mailclass)
    {
        
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        
        mc.mailComposeDelegate = self;
        
        mc.navigationBar.tintColor = [UIColor colorWithRed:64.0/255.0 green:144.0/255.0 blue:219.0/255.0 alpha:1.0];
        NSString *msgSub=@"Check out the Sportsly App";
        
       // NSString *msg =[NSString stringWithFormat:@"Hi Coach,\r\nI just downloaded the Sportsly app and I think you should too! It will be a great way to organize and plan our team activities and other things:\n\n- An easy interface to create a team and add roster\n- Send game invites and track attendance\n- Wall to share team moments\n- Create lasting memories of team photos and videos \n\nThanks,\n\nTeam Sportsly"];
        
        NSString *msg1 = @"Hi,";
        NSString *msg2 = @"I just downloaded the Sportsly app and I think you should too! It will be a great way to organize and plan our team activities and provide:";
        NSString *msg3 = @"• An easy interface to create a team and add roster";
        NSString *msg4 = @"• Send game invites and track attendance";
        NSString *msg5 = @"• Wall to share team moments";
        NSString *msg6 = @"• Create lasting memories of team photos and videos";
        NSString *msg7 = @"Please download using the below links.";
        
       // NSString *finalStrMsg = [NSString stringWithFormat:@"%@\n%@\n\n%@\n%@\n%@\n%@\n\n%@\n\n%@",msg1,msg2,msg3,msg4,msg5,msg6,msg7,msg8];
        
        [mc setSubject:[NSString stringWithFormat:@"%@",msgSub]]; //
        NSString *strApp=@"https://itunes.apple.com/gb/app/sportsly-lets-play/id843696027?mt=8";
        NSString *strGoogle=@"https://play.google.com/store/apps/details?id=co.sportsly";
        NSString *UrlStr=[NSString stringWithFormat:@"<html><script language=\"javascript\">\
                               var timeout;\
                               function onDocumentLoaded() {\
                               var start = new Date();\
                               setTimeout(function() {\
                               if (new Date() - start > 2000) {\
                               return;\
                               }\
                               window.location = 'http://your-installation.url';\
                               }, 1000);\
                               }\
                               </script><body><p></p><p><a onClick=\"onDocumentLoaded()\" href='%@'>iTunes App Store</a></p><p><a onClick=\"onDocumentLoaded()\" href='\n%@'>Google Play Store</a></p></body>\
                               </html>",strApp,strGoogle];
        
        
        
        
        
        [mc setMessageBody:[NSString stringWithFormat:@"%@<br /><br />%@<br /><br />%@<br />%@<br />%@<br />%@<br /><br />%@<br />%@ ",msg1,msg2,msg3,msg4,msg5,msg6,msg7,UrlStr] isHTML:YES];
        
       
        
        [mc setToRecipients:nil];
        
        if([mailclass canSendMail])
        {
            [self presentViewController:mc animated:YES completion:nil];
            
        }
    }
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    UIAlertView *mailAlert;
    switch (result)
    {
            
        case MFMailComposeResultCancelled:
        {
            NSLog(@"Mail cancelled");
           /* mailAlert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Mail cancelled." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [mailAlert show];*/
            break;
        }
        case MFMailComposeResultSaved:
        {
            NSLog(@"Mail saved");
            mailAlert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Mail saved." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [mailAlert show];
            break;
        }
        case MFMailComposeResultSent:
        {
            NSLog(@"Mail sent");
            mailAlert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Mail sent." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            
            /*self.emailBtn.enabled = NO;
             self.emailIconImg.image = [UIImage imageNamed:@""];
             self.emailLbl.textColor = [UIColor colorWithRed:64.0/255.0 green:144.0/255.0 blue:219.0/255.0 alpha:1.0];*/
            
           // self.emailShareComplete = YES;
            
            //[self songShareComplete];
            
            break;
        }
        case MFMailComposeResultFailed:
        {
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            mailAlert=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Mail sent failure." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [mailAlert show];
            break;
        }
        default:
            break;
    }
    
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}

-(void)leftSwipeDone
{
   
}
-(void)rightSwipeDone
{
     Tutorila2ViewController *Tutorila2=[[Tutorila2ViewController alloc] initWithNibName:@"Tutorila2ViewController" bundle:nil];
    [self.navigationController pushViewController:Tutorila2 animated:NO];
}

#pragma mark - NavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] postNotificationName:SHOWNAVIGATIONCONTROLLERTUTORIAL object:nil];
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SHOWNAVIGATIONCONTROLLERTUTORIAL object:nil];
    
}

#pragma mark - NavigationControllerUpdate
-(void)showNavigationControllerUpdated:(id)sender
{
    
    
    if(self.navigationController.view.hidden==NO)
    {
        if([[self.navigationController.viewControllers lastObject] isMemberOfClass:[self class]])
        {
            [self showNavigationBarButtons];
            
            
        }
        else
        {
            [[self.navigationController.viewControllers lastObject] showNavigationBarButtons];
        }
    }
    
    
}


-(void)showNavigationBarButtons
{
    
    if(!self.leftBarButtonItem)
    {
        self.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"wallleftslide.png"] style:UIBarButtonItemStylePlain target:self action:@selector(toggleLeftPanel:)];
    }
    
    if(!self.rightBarButtonItem)
    {
        self.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"new_message.png"] style:UIBarButtonItemStylePlain target:self action:@selector(messageToplayer:)];
    }
    
    self.appDelegate.centerViewController.navigationItem.title=@"Tutorial";
    appDelegate.centerViewController.navigationItem.leftBarButtonItem=self.leftBarButtonItem;
    
    appDelegate.centerViewController.navigationItem.rightBarButtonItem=nil;
    
    
    [self setStatusBarStyleOwnApp:1];
    
}

-(void)toggleLeftPanel:(id)sender
{
    [appDelegate.slidePanelController showLeftPanelAnimated:YES];
    
}

@end
