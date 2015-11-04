//
//  InviteDetailsViewController.m
//  Wall
//
//  Created by Mindpace on 26/09/13.
//
//

#import "HomeVC.h"
#import "CustomMailViewController.h"
#import "SelectContact.h"
@interface CustomMailViewController ()

@end

@implementation CustomMailViewController
@synthesize strofbody,teamId,keyboardToolbar,keyboardToolbarView,scrollview,currbodytext,selectedContact;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(keyboardDidShow:)
     name:UIKeyboardDidShowNotification object:self.view.window];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification
                                               object:nil];
    
    
    [self.emailtotf becomeFirstResponder];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
     
                                                    name:UIKeyboardWillHideNotification object:nil];
    
    
      [self.emailtotf resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   // [self getUserListing];
    
    self.view.backgroundColor=appDelegate.backgroundPinkColor;
    self.topview.backgroundColor=appDelegate.barGrayColor;
    
    self.textVw.text=self.strofbody;
    
    
    self.textVw.layer.cornerRadius=8.0;
    self.receipientmainview.layer.cornerRadius=8.0;
    
    point=CGPointMake(0,0);
    af=[[UIScreen mainScreen] applicationFrame];
    
    if(keyboardToolbar == nil && keyboardToolbarView==nil)
    {
        keyboardToolbarView=[[UIView alloc] initWithFrame:CGRectMake(0, 372, 320, 84)];
        keyboardToolbarView.backgroundColor=[UIColor blackColor];
        keyboardToolbarView.alpha=0.8;
        
		keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,320,40)];
		keyboardToolbar.barStyle = UIBarStyleBlackTranslucent;
        
        UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(dissmissCanKeyboard:)];
        cancel.tag=0;
        
        UIBarButtonItem *fspace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        
        UIBarButtonItem *done =[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(dissmissCanKeyboard:)];
        done.tintColor=[UIColor blueColor];
        done.tag=1;
        
        NSArray *items = [[NSArray alloc] initWithObjects:cancel,fspace ,done, nil];
        [keyboardToolbar setItems:items];
        [keyboardToolbar setAlpha:1.0];
        
        [keyboardToolbarView addSubview:keyboardToolbar];
	}

    
    
    self.textVw.editable=NO;
    self.textVw.hidden=YES;
}

-(void)dissmissCanKeyboard:(id)sender
{
    int tag=[sender tag];
    
    
  
        if(tag==0)
        {
            self.textVw.text=self.currbodytext;
            
        }
        
        [self.textVw resignFirstResponder];
    
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
   
    self.currbodytext=textView.text;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    CGRect rect = keyboardToolbarView.frame;
    
    
    
    //rect.origin.y = 204;
    
    if(appDelegate.isIphone5)
        rect.origin.y = (170+88);
    else
        rect.origin.y = 170;
    
    
    
    
    
    
    keyboardToolbarView.frame = rect;
    
    //NSLog(@"Toolbar Frame=%f,%f,%f,%f",rect.origin.x,rect.origin.y,rect.size.width,rect.size.height);
    
    [self.view addSubview:keyboardToolbarView];
    [UIView commitAnimations];
    
    [self moveScrollView:textView];
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
     [self hideKeyTool];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return YES;
}

-(void) keyboardDidShow:(NSNotification *) notification
{
    
    
    
    NSDictionary* info = [notification userInfo];
    
    NSValue *aValue =
    [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    [aValue getValue:&kb];
    
    
    
    
    
    
    
    
    
}





//---when the keyboard disappears---



-(void) keyboardDidHide:(NSNotification *) notification {
    
    
    
    
    
    
    
    
    
}


-(void)hideKeyTool
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    CGRect rect = keyboardToolbarView.frame;
    rect.origin.y = 372;
    keyboardToolbarView.frame = rect;
    [keyboardToolbarView removeFromSuperview];
    [UIView commitAnimations];
}
-(void)moveScrollView:(UIView *)theView
{
    CGFloat vcy=theView.center.y;
    
    
    CGFloat fsh=af.size.height;
    
    
    CGFloat sa;//=vcy-fsh/5.8;
    
    
    if(isiPhone5)
        sa=vcy-fsh/5.8;   //sa=vcy-fsh/3.2;
    else
        sa=vcy-fsh/6.8;    //sa=vcy-fsh/5.2;
    
    if(sa<0)
        sa=0;
    
    self.scrollview.contentSize=CGSizeMake(af.size.width,af.size.height+kb.size.height);
    
    [ self.scrollview setContentOffset:CGPointMake(0,sa) animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backf:(id)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    
    //[textField resignFirstResponder];
    return NO;
}


- (IBAction)bTapped:(id)sender
{
//    int tag=[sender tag];
//    
//    NSString *str=nil;
   /* NSMutableDictionary *command = [NSMutableDictionary dictionary];
    [command setObject:[appDelegate.aDef objectForKey:LoggedUserID] forKey:@"user_id"];
    
    
    if([self validEmail: self.emailtotf.text ])
    {
        [command setObject:self.emailtotf.text forKey:@"email_id"];
    }
    else
    {
        [self showAlertMessage:@"The email id is invalid."];
        return;
    }
    
    
    [command setObject:self.textVw.text forKey:@"text"];
    
    NSArray *ar=[self.teamId componentsSeparatedByString:@","];
    
    [command setObject:ar forKey:@"team_id"];
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    
    
    NSString *jsonCommand = [writer stringWithObject:command];
    
    
    [self showHudView:@"Connecting..."];
    [self showNativeHudView];
    NSLog(@"RequestParamJSON=%@",jsonCommand);
    
    
    
    self.requestDic=command;
    [appDelegate sendRequestFor:INVITEFRIENDS from:self parameter:[NSDictionary dictionaryWithObjectsAndKeys:jsonCommand,@"requestParam", nil]];*/
    if([self validEmail: self.emailtotf.text ])
    {
        
      
        self.addAFriendVC.sendEmailId=self.emailtotf.text;
        
        NSLog(@"addAFriendVC.sendEmailId=%@",self.addAFriendVC.sendEmailId);
        [self.addAFriendVC resetData];
        [self.addAFriendVC.tbllView reloadData];
        [self.navigationController pushViewController:self.addAFriendVC animated:YES];
       
    }
    else
    {
        [self showAlertMessage:@"The email id is invalid."];
    
    }
    
    
  
}




- (void)viewDidUnload
{
    self.emailtotf=nil;
        self.receipientmainview=nil;
        self.textVw=nil;
        [super viewDidUnload];
}

-(void)hideHudViewHere
{

    [self.navigationController popViewControllerAnimated:YES];
  
    
}

    
    
    

- (IBAction)dropDownTapped:(id)sender
{
    
    SelectContact *sContact=[[SelectContact alloc] initWithNibName:@"SelectContact" bundle:nil];
    
    sContact.phFriend=self;
    [self.navigationController pushViewController:sContact animated:YES];
    
    sContact=nil;
    
    
}


-(void)populateField:(Contacts*)contact
{
    self.selectedContact=contact;
    NSLog(@"selectedContact=%@",selectedContact);
     self.emailtotf.text=@"";
    self.emailtotf.text=self.selectedContact.email;
    
}



@end

